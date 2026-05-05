// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception

import Testing
@testable import Hex

@Suite("Internal nibble helpers")
struct HexNibbleTests {
    @Test("nibbleToASCIILower maps 0..<16 to '0'..='f'")
    func toASCIILower() {
        #expect(HexNibble.nibbleToASCIILower(0) == 0x30)   // '0'
        #expect(HexNibble.nibbleToASCIILower(9) == 0x39)   // '9'
        #expect(HexNibble.nibbleToASCIILower(10) == 0x61)  // 'a'
        #expect(HexNibble.nibbleToASCIILower(15) == 0x66)  // 'f'
    }

    @Test("nibbleToASCIIUpper maps 0..<16 to '0'..='F'")
    func toASCIIUpper() {
        #expect(HexNibble.nibbleToASCIIUpper(0) == 0x30)   // '0'
        #expect(HexNibble.nibbleToASCIIUpper(9) == 0x39)   // '9'
        #expect(HexNibble.nibbleToASCIIUpper(10) == 0x41)  // 'A'
        #expect(HexNibble.nibbleToASCIIUpper(15) == 0x46)  // 'F'
    }

    @Test("asciiToNibble accepts both cases and rejects non-hex")
    func fromASCII() {
        #expect(HexNibble.asciiToNibble(0x30) == 0)        // '0'
        #expect(HexNibble.asciiToNibble(0x39) == 9)        // '9'
        #expect(HexNibble.asciiToNibble(0x61) == 10)       // 'a'
        #expect(HexNibble.asciiToNibble(0x66) == 15)       // 'f'
        #expect(HexNibble.asciiToNibble(0x41) == 10)       // 'A'
        #expect(HexNibble.asciiToNibble(0x46) == 15)       // 'F'
        #expect(HexNibble.asciiToNibble(0x67) == nil)      // 'g'
        #expect(HexNibble.asciiToNibble(0x20) == nil)      // ' '
        #expect(HexNibble.asciiToNibble(0x40) == nil)      // '@'
    }
}
