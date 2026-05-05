// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception

import Testing
@testable import Hex

@Suite("HexError")
struct HexErrorTests {
    @Test("HexError is Sendable, Equatable, and Error")
    func conformances() {
        let a: HexError = .oddLength(1)
        let b: HexError = .oddLength(1)
        let c: HexError = .oddLength(3)
        #expect(a == b)
        #expect(a != c)
        // Compile-time conformance check via existential casts:
        let _: any Error = a
        let _: any Sendable = a
    }

    @Test("invalidCharacter carries character and index")
    func invalidCharacterPayload() {
        let err: HexError = .invalidCharacter(byte: 0x67, atIndex: 4)  // 'g'
        if case .invalidCharacter(let byte, let idx) = err {
            #expect(byte == 0x67)
            #expect(idx == 4)
        } else {
            Issue.record("expected .invalidCharacter case")
        }
    }
}
