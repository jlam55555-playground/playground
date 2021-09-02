// trait objects vs. impl trait vs. generics vs. associated types
// all have to do with associating a secondary type with an object
// - trait object: dynamic dispatch like OOP languages
// - impl trait: compile-time type inference, nothing special
//   going on here (basically so that you don't have to type out
//   the type name)
// - generics: monomorphization at compile-time; allow you to
//   have several implementations for different associated types
// - associated types: like generics but only allow one associated
//   type (no monomorphization required)
//
// You can mix and match.

// "object-safe" traits: traits that only have methods with the
// following properties:
// - return type isn't `Self`
// - no generic type parameters
//
// (note: `Self` is an alias for the current struct/enum/
// concrete type name)

#[cfg(test)]
mod tests {
    #[test]
    fn it_works() {
        assert_eq!(2 + 2, 4);
    }
}
