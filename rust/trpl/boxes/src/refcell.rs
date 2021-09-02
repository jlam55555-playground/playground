// "Mutating the value inside an immutable value is the *interior mutability* pattern."

// won't copy the entire example; a `RefCell` is an immutable object with mutable
// contents; this is similar to a `const` object in JavaScript/referential transparency,
// since the container/memory location is immutable but its contents are not

// `Rc` and `RefCell` can be combined to allow for multiple owners to a `RefCell`

// Note that with `Rc` and `RefCell`, it is possible to create reference cycles
// (think a graph data structure with a loop). This will never be cleaned up.

// Instead, we can create "weak" references (smart pointer with type `Weak<T>`)
// rather than the default `Strong<T>` pointers created by `Rc`. These do not
// affect cleanup; there may be a positive weak pointer count and the pointer
// will still get cleaned up if the strong pointer count becomes 0.
