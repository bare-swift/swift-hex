# swift-hex

Sendable, Foundation-free hex encoding and decoding for Swift 6 — including a constant-time variant for crypto contexts.

Part of the [bare-swift](https://github.com/bare-swift) ecosystem.

## Install

Add to your `Package.swift`:

```swift
.package(url: "https://github.com/bare-swift/swift-hex.git", from: "0.1.0")
```

Then depend on the `Hex` product:

```swift
.product(name: "Hex", package: "swift-hex")
```

## Usage

```swift
import Hex

// Encode bytes → hex string
let bytes: [UInt8] = [0x66, 0x6f, 0x6f]
print(Hex.encode(bytes))            // "666f6f"
print(Hex.encodeUppercase(bytes))   // "666F6F"

// Decode hex string → bytes (case-insensitive)
let decoded = try Hex.decode("666f6f")  // [0x66, 0x6f, 0x6f]

// Constant-time variants for crypto contexts
let token = Hex.ConstantTime.encode(bytes)
let raw = try Hex.ConstantTime.decode(token)
```

Errors are typed: `Hex.decode` and `Hex.ConstantTime.decode` throw ``HexError``.

## Documentation

Full DocC documentation: <https://bare-swift.github.io/swift-hex/>

## Source

Translated from the Rust crates [`hex`](https://crates.io/crates/hex) and [`base16ct`](https://crates.io/crates/base16ct).

## License

Apache 2.0 with LLVM exception. See [LICENSE](./LICENSE) and [NOTICE](./NOTICE).
