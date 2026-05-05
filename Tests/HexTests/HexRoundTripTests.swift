// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception

import Testing
@testable import Hex

@Suite("Hex round-trip")
struct HexRoundTripTests {
    @Test("encode → decode is identity for empty")
    func emptyRoundTrip() throws {
        #expect(try Hex.decode(Hex.encode([])) == [])
    }

    @Test("encode → decode is identity for arbitrary lengths")
    func variousLengths() throws {
        // Deterministic pseudo-random fill. No need for actual RNG —
        // we want reproducible coverage.
        for length in [0, 1, 2, 7, 16, 17, 64, 1023, 1024] {
            var bytes: [UInt8] = []
            bytes.reserveCapacity(length)
            for i in 0..<length {
                bytes.append(UInt8(truncatingIfNeeded: i &* 0x9e3779b1))
            }
            let encoded = Hex.encode(bytes)
            #expect(encoded.count == length * 2)
            let decoded = try Hex.decode(encoded)
            #expect(decoded == bytes)
        }
    }

    @Test("encodeUppercase → decode is identity")
    func uppercaseRoundTrip() throws {
        let bytes: [UInt8] = [0x00, 0x55, 0xAA, 0xFF, 0x12, 0x34, 0x56, 0x78]
        let upper = Hex.encodeUppercase(bytes)
        #expect(upper == upper.uppercased())
        let decoded = try Hex.decode(upper)
        #expect(decoded == bytes)
    }
}
