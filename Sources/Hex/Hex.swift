// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
// Copyright (c) 2026 The bare-swift Project Authors.

/// Sendable, Foundation-free hex encoding and decoding.
///
/// Public API is namespaced under `Hex` (general-purpose) and `Hex.ConstantTime`
/// (constant-time variants for crypto contexts).
public enum Hex: Sendable {
    /// Decode a hex-encoded string to bytes. Accepts upper, lower, and mixed
    /// case. Throws ``HexError/oddLength(_:)`` if the input length is odd, or
    /// ``HexError/invalidCharacter(byte:atIndex:)`` on any non-hex character.
    public static func decode(_ string: String) throws(HexError) -> [UInt8] {
        let utf8 = Array(string.utf8)
        if utf8.count % 2 != 0 {
            throw .oddLength(utf8.count)
        }
        var output: [UInt8] = []
        output.reserveCapacity(utf8.count / 2)
        var i = 0
        while i < utf8.count {
            guard let hi = HexNibble.asciiToNibble(utf8[i]) else {
                throw .invalidCharacter(byte: utf8[i], atIndex: i)
            }
            guard let lo = HexNibble.asciiToNibble(utf8[i + 1]) else {
                throw .invalidCharacter(byte: utf8[i + 1], atIndex: i + 1)
            }
            output.append((hi &<< 4) | lo)
            i += 2
        }
        return output
    }
}
