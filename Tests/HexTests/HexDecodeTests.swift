// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception

import Testing
@testable import Hex

@Suite("Hex.decode")
struct HexDecodeTests {
    @Test("empty input decodes to empty output")
    func empty() throws {
        #expect(try Hex.decode("") == [])
    }

    @Test("decodes lowercase hex (translated from rust-hex test_decode)")
    func lowercase() throws {
        // 'foobar' → "666f6f626172"
        #expect(try Hex.decode("666f6f626172") == [0x66, 0x6f, 0x6f, 0x62, 0x61, 0x72])
    }

    @Test("decodes uppercase hex (translated from rust-hex test_from_hex_okay_str)")
    func uppercase() throws {
        #expect(try Hex.decode("666F6F626172") == [0x66, 0x6f, 0x6f, 0x62, 0x61, 0x72])
    }

    @Test("decodes mixed-case hex")
    func mixedCase() throws {
        #expect(try Hex.decode("DeAdBeEf") == [0xde, 0xad, 0xbe, 0xef])
    }

    @Test("decodes the 'kiwi' fixture (translated from rust-hex test_decode_to_slice)")
    func kiwi() throws {
        #expect(try Hex.decode("6b697769") == [0x6b, 0x69, 0x77, 0x69])         // 'kiwi'
        #expect(try Hex.decode("6b69776973") == [0x6b, 0x69, 0x77, 0x69, 0x73]) // 'kiwis'
    }

    @Test("rejects odd-length input (translated from rust-hex test_invalid_length)")
    func oddLength() {
        #expect(throws: HexError.oddLength(1)) { try Hex.decode("1") }
        #expect(throws: HexError.oddLength(13)) { try Hex.decode("666f6f6261721") }
    }

    @Test("rejects invalid character (translated from rust-hex test_invalid_char)")
    func invalidCharacter() {
        #expect(throws: HexError.invalidCharacter(byte: 0x67, atIndex: 3)) {
            try Hex.decode("66ag")
        }
    }

    @Test("rejects whitespace (translated from rust-hex test_from_hex_whitespace)")
    func whitespace() {
        #expect(throws: HexError.invalidCharacter(byte: 0x20, atIndex: 4)) {
            try Hex.decode("666f 6f62617")
        }
    }
}
