// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
// Copyright (c) 2026 The bare-swift Project Authors.

/// Errors thrown by ``Hex`` decoding functions.
public enum HexError: Error, Equatable, Sendable {
    /// The input had an odd number of hex digits. Hex encoding requires an
    /// even count (two digits per byte). The associated value is the offending
    /// length (in characters).
    case oddLength(Int)

    /// The input contained a non-hex character. The associated values are the
    /// raw ASCII byte that wasn't `[0-9A-Fa-f]` and its zero-based index in
    /// the input.
    case invalidCharacter(byte: UInt8, atIndex: Int)
}
