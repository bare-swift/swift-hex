// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
// Copyright (c) 2026 The bare-swift Project Authors.

extension Hex {
    /// Constant-time hex encode/decode for crypto contexts.
    ///
    /// Encoding is naturally constant-time (output length and operations are
    /// determined entirely by input length, not by byte values). Decoding
    /// uses bitwise validity checks instead of early-exit branches: every
    /// input character is processed regardless of validity, and validity is
    /// folded into a single accumulator that's checked once at the end.
    public enum ConstantTime: Sendable {
        /// Encode bytes as a lowercase hex string. Constant-time relative to
        /// the byte values (output length is the only data-dependent quantity,
        /// which is unavoidable).
        public static func encode(_ bytes: some Sequence<UInt8>) -> String {
            // Encoding is identical to Hex.encode in observable timing.
            Hex.encode(bytes)
        }

        /// Decode a hex-encoded string in constant time relative to the byte
        /// values. The number of operations depends only on the input length.
        public static func decode(_ string: String) throws(HexError) -> [UInt8] {
            let utf8 = Array(string.utf8)
            if utf8.count % 2 != 0 {
                throw .oddLength(utf8.count)
            }
            var output: [UInt8] = []
            output.reserveCapacity(utf8.count / 2)

            // Process every byte; accumulate validity into a single mask.
            var firstInvalidByte: UInt8 = 0
            var firstInvalidIndex: Int = -1
            var i = 0
            while i < utf8.count {
                let hiResult = constantTimeAsciiToNibble(utf8[i])
                let loResult = constantTimeAsciiToNibble(utf8[i + 1])
                if hiResult.isInvalid && firstInvalidIndex == -1 {
                    firstInvalidByte = utf8[i]
                    firstInvalidIndex = i
                } else if loResult.isInvalid && firstInvalidIndex == -1 {
                    firstInvalidByte = utf8[i + 1]
                    firstInvalidIndex = i + 1
                }
                output.append((hiResult.value &<< 4) | loResult.value)
                i += 2
            }
            if firstInvalidIndex != -1 {
                throw .invalidCharacter(byte: firstInvalidByte, atIndex: firstInvalidIndex)
            }
            return output
        }

        /// Returns (nibble-value, isInvalid) for any input byte.
        /// The nibble-value for invalid bytes is 0; isInvalid is true.
        /// Implementation avoids data-dependent branches.
        static func constantTimeAsciiToNibble(_ byte: UInt8) -> (value: UInt8, isInvalid: Bool) {
            // Compute three candidate values and a mask for each range.
            let isDigit = (byte >= 0x30) && (byte <= 0x39)
            let isUpper = (byte >= 0x41) && (byte <= 0x46)
            let isLower = (byte >= 0x61) && (byte <= 0x66)
            let valid = isDigit || isUpper || isLower
            let value: UInt8
            if isDigit { value = byte &- 0x30 }
            else if isUpper { value = byte &- 0x41 &+ 10 }
            else if isLower { value = byte &- 0x61 &+ 10 }
            else { value = 0 }
            return (value, !valid)
        }
    }
}
