# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [Semantic Versioning](https://semver.org/).

## [Unreleased]

## [0.1.0] - 2026-05-05

### Added
- `Hex.encode(_:)`, `Hex.encodeUppercase(_:)` — produce lowercase / uppercase hex strings from `some Sequence<UInt8>`.
- `Hex.decode(_:)` — case-insensitive hex decoding with typed throws (`HexError`).
- `Hex.ConstantTime.encode(_:)` and `Hex.ConstantTime.decode(_:)` — variants suitable for crypto contexts; processes the full input before reporting errors (no early exit on first invalid character).
- `HexError` — typed error enum (`oddLength`, `invalidCharacter`).
- DocC documentation, full README example, NOTICE crediting upstream `hex` and `base16ct` Rust crates.
