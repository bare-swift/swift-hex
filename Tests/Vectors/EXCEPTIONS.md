# Test-parity exceptions

Per [RFC-0002](https://github.com/bare-swift/bare-swift/blob/main/rfcs/0002-test-parity-policy.md), this file documents why some upstream test cases are not
extracted as fixtures.

## Source: `hex` (Rust crate)

The `hex` crate's test cases are inline `#[test]` functions in `src/lib.rs`,
not fixture files. They exercise: encode/decode round trips, case sensitivity
(upper/lower/mixed on decode), odd-length rejection, invalid-character
rejection, and empty input.

The Swift implementation translates those test bodies as Swift Testing cases
in `Tests/HexTests/Hex{Encode,Decode,RoundTrip}Tests.swift`. Every assertion in
the Rust source has a corresponding Swift test.

## Source: `base16ct` (Rust crate)

Same situation — inline tests in the constant-time module. Translated to
`Tests/HexTests/ConstantTimeTests.swift`. Both lower and mixed-case constant-time
decode paths are covered.

## Refresh

When either upstream crate releases a new minor version, re-read the inline
tests and add Swift equivalents for any new cases. Record the source commit
hash in this file when refreshing:

- `hex`: tracked at upstream commit (record at next refresh)
- `base16ct`: tracked at upstream commit (record at next refresh)
