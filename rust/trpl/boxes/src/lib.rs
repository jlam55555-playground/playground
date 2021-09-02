#![allow(dead_code)]
#![allow(unused_variables)]
#![allow(unused_imports)]

mod mybox;
mod deref_coercion;
mod drop_trait;
mod boxed_cons;
mod rc;

use boxed_cons::{List, Cons, Nil, BoxedList, BoxedCons, BoxedNil};
use mybox::MyBox;
use rc::{Rc, RcList, RcCons, RcNil};

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn boxed_cons() {
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
    
    #[test]
    fn deref() {
        let x = 5;
        let y = MyBox::new(x);

        assert_eq!(5, x);

        // this is equivalent to:
        // `assert_eq!(5, *(y.deref()));`
        assert_eq!(5, *y);
    }

    #[test]
    fn deref_coercion_test() {
        // calling with `&str` type
        deref_coercion::hello("Hello, world");

        // calling with `&String` type
        deref_coercion::hello(&String::from("Hello, world"));

        // calling with `&Box<String>` type
        deref_coercion::hello(&Box::new(String::from("Hello, world")));
    }

    // run this test with flag `--nocapture` to see the output
    #[test]
    fn drop_trait_test() {
        let c = drop_trait::CustomSmartPointer {
            data: String::from("my stuff"),
        };
        let d = drop_trait::CustomSmartPointer {
            data: String::from("other stuff"),
        };
        println!("CustomSmartPointers created.");
    }

    // we are not allowed to call `drop()` method early, or else we could
    // have a double-free error; this doesn't compile
    #[test]
    fn early_drop() {
        let c = drop_trait::CustomSmartPointer {
            data: String::from(""),
        };
        // uncommenting this breaks compilation
        // c.drop();
        
        // this uses `std::mem::drop`, which does work
        drop(c);
    }

    // showing some test cases that make use of a reference counter
    #[test]
    fn sharing_ownership() {
        // the book says this doesn't work but it does, because the
        // behavior of temporaries has changed
        // let a = Cons(5, &Nil);
        // println!("Pair: ({}, ...)", a.car());
        // println!("Pair: {}", a);

        let a = Rc::new(RcCons(5, Rc::new(RcCons(10, Rc::new(RcNil)))));
        let b = RcCons(3, Rc::clone(&a));
        let c = RcCons(4, Rc::clone(&a));
    }
}
