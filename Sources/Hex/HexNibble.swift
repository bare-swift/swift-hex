// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
// Copyright (c) 2026 The bare-swift Project Authors.

/// Internal nibble (4-bit half-byte) primitives shared by all encode/decode
/// paths. Not part of the public API.
enum HexNibble {
    /// Convert a 4-bit nibble value (0...15) to its lowercase ASCII byte.
    /// Caller must ensure `nibble < 16`.
    @inlinable
    static func nibbleToASCIILower(_ nibble: UInt8) -> UInt8 {
        nibble < 10 ? (0x30 &+ nibble) : (0x61 &+ nibble &- 10)
    }

    /// Convert a 4-bit nibble value (0...15) to its uppercase ASCII byte.
    /// Caller must ensure `nibble < 16`.
    @inlinable
    static func nibbleToASCIIUpper(_ nibble: UInt8) -> UInt8 {
        nibble < 10 ? (0x30 &+ nibble) : (0x41 &+ nibble &- 10)
    }

    /// Convert an ASCII byte to a 4-bit nibble. Returns nil if the byte is
    /// not in `[0-9A-Fa-f]`.
    @inlinable
    static func asciiToNibble(_ byte: UInt8) -> UInt8? {
        switch byte {
        case 0x30...0x39: return byte &- 0x30                  // '0'-'9'
        case 0x41...0x46: return byte &- 0x41 &+ 10            // 'A'-'F'
        case 0x61...0x66: return byte &- 0x61 &+ 10            // 'a'-'f'
        default: return nil
        }
    }
}
