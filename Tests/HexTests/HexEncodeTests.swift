// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception

import Testing
@testable import Hex

@Suite("Hex.encode / Hex.encodeUppercase")
struct HexEncodeTests {
    @Test("empty input encodes to empty string")
    func empty() {
        #expect(Hex.encode([]) == "")
        #expect(Hex.encodeUppercase([]) == "")
    }

    @Test("encodes 'foobar' (translated from rust-hex test_encode)")
    func foobar() {
        let bytes: [UInt8] = [0x66, 0x6f, 0x6f, 0x62, 0x61, 0x72]
        #expect(Hex.encode(bytes) == "666f6f626172")
        #expect(Hex.encodeUppercase(bytes) == "666F6F626172")
    }

    @Test("encodes 'kiwi' fixture (translated from rust-hex test_encode_to_slice)")
    func kiwi() {
        #expect(Hex.encode([0x6b, 0x69, 0x77, 0x69]) == "6b697769")
        #expect(Hex.encodeUppercase([0x6b, 0x69, 0x77, 0x69]) == "6B697769")
    }

    @Test("accepts any Sequence<UInt8>, not just [UInt8]")
    func sequenceInput() {
        let arr = ContiguousArray<UInt8>([0xde, 0xad, 0xbe, 0xef])
        #expect(Hex.encode(arr) == "deadbeef")
    }

    @Test("encodes all 256 byte values correctly")
    func fullByteRange() {
        let allBytes: [UInt8] = (0..<256).map { UInt8($0) }
        let encoded = Hex.encode(allBytes)
        #expect(encoded.count == 512)
        #expect(encoded.hasPrefix("000102"))
        #expect(encoded.hasSuffix("fdfeff"))
    }
}
