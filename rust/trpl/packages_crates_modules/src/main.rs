// a crate is a binary or library
// a package is one or more crates that provides a set of functionality
// a package contains a `Cargo.toml` that describes how to build those crates
// a package must contain zero or one library crates, and no more
// it can contain arbitrarily many binary crates (at least 1)
//
// `cargo new --lib [name]`
//
// can roughly think of a crate as a single rust file (similar to a translation
// unit?)
//
// modules allow us to bring in code from external scope
// keywords: use, pub, as
//
// `use` is similar to an import statement; usually we `use` the immediate
// module of the identifier we wish to use, rather than the identifier itself;
// this is idiomatic Rust
//
// see the `restaurant` package for examples of this
//
// we can alias names using the `as` keyword; we can export this name by a
// `pub use ...` statement
//
// concise syntax:
// `use std::{cmp::Ordering, io};`
// `use std::io::{self, Write};`
//
// also a wildcard/glob operator
// `use std::collections::*;`
// glob is often using in tests
fn main() {

}
