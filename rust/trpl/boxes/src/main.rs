use crate::List::{Cons, Nil};
use crate::BoxedList::{BoxedCons, BoxedNil};

enum List<'a> {
    Cons(i32, &'a List<'a>),
    Nil,
}

enum BoxedList {
    BoxedCons(i32, Box<BoxedList>),
    BoxedNil,
}

fn main() {
    let b = Box::new(5);
    println!("b = {}", b);

    // we can also use boxes for the following;
    // cannot have purely recursive data types
    // without indirection (same as in C); boxed values
    // act like this but are allocated on the heap
    // (good for arbitrarily-sized values such as
    // recursive data structures, which may be too
    // large to fit on the stack); in boxed types
    // we also do not have to worry about lifetimes,
    // since they are "managed" unlike plain
    // references
    let list = Cons(1, &Cons(2, &Cons(3, &Nil)));

    // feels like lisp!
    let list = BoxedCons(1, Box::new(BoxedCons(2, Box::new(BoxedCons(3, Box::new(BoxedNil))))));

    // note: boxes give you *value semantics* -- only
    // the value matters, the identity does not
    // (i.e., not referential transparent)

    // in general more complex data types
    // can also be represented by more complex
    // boxed types, e.g., additional state such
    // as string length
}
