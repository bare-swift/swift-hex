# ``Hex``

Sendable, Foundation-free hex encoding and decoding for Swift 6 — including a constant-time variant for crypto contexts.

## Overview

`Hex` translates two Rust crates into a single small Swift module:

- General-purpose encode/decode (translated from `hex`).
- Constant-time encode/decode (translated from `base16ct`), suitable for handling secret material where the runtime should not branch on input bytes.

All public API is `Sendable`, accepts `some Sequence<UInt8>` for byte input, and uses Swift 6 typed throws (``HexError``) for error returns. No Foundation types appear in the public surface.

```swift
import Hex

let raw: [UInt8] = [0xde, 0xad, 0xbe, 0xef]
let encoded = Hex.encode(raw)             // "deadbeef"
let decoded = try Hex.decode(encoded)     // [0xde, 0xad, 0xbe, 0xef]
```

## Topics

### Encoding

- ``Hex/encode(_:)``
- ``Hex/encodeUppercase(_:)``

### Decoding

- ``Hex/decode(_:)``

### Constant-time variants

- ``Hex/ConstantTime``
- ``Hex/ConstantTime/encode(_:)``
- ``Hex/ConstantTime/decode(_:)``

### Errors

- ``HexError``
