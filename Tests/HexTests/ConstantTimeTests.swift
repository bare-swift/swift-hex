// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception

import Testing
@testable import Hex

@Suite("Hex.ConstantTime")
struct ConstantTimeTests {
    @Test("encode produces same output as Hex.encode")
    func encodeMatchesPlain() {
        for length in [0, 1, 16, 32, 64] {
            let bytes = (0..<length).map { UInt8($0 ^ 0xa5) }
            #expect(Hex.ConstantTime.encode(bytes) == Hex.encode(bytes))
        }
    }

    @Test("decode accepts lowercase, mixed case, and rejects invalid")
    func decodeBehavior() throws {
        #expect(try Hex.ConstantTime.decode("") == [])
        #expect(try Hex.ConstantTime.decode("deadbeef") == [0xde, 0xad, 0xbe, 0xef])
        #expect(try Hex.ConstantTime.decode("DeAdBeEf") == [0xde, 0xad, 0xbe, 0xef])
        #expect(throws: HexError.oddLength(1)) { try Hex.ConstantTime.decode("a") }
        #expect(throws: HexError.self) { try Hex.ConstantTime.decode("66ag") }
    }

    @Test("decode round-trips the encoded output")
    func roundTrip() throws {
        for length in [0, 1, 7, 32, 256] {
            let bytes = (0..<length).map { UInt8(($0 &* 17) & 0xff) }
            let encoded = Hex.ConstantTime.encode(bytes)
            let decoded = try Hex.ConstantTime.decode(encoded)
            #expect(decoded == bytes)
        }
    }
}
