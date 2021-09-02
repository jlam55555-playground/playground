pub use crate::List::{Cons, Nil};
pub use crate::BoxedList::{BoxedCons, BoxedNil};

pub enum List<'a> {
    Cons(i32, &'a List<'a>),
    Nil,
}

pub enum BoxedList {
    BoxedCons(i32, Box<BoxedList>),
    BoxedNil,
}

impl<'a> List<'a> {
    pub fn car(&self) -> i32 {
        match self {
            Cons(a, _) => *a,
            Nil => panic!("not a pair"),
        }
    }
    
    pub fn cdr(&self) -> &List {
        match self {
            Cons(_, b) => b,
            Nil => panic!("not a pair")
        }
    }
}

use std::fmt;

impl<'a> fmt::Display for List<'a> {
    fn fmt(&self, f: &mut fmt::Formatter) -> fmt::Result {
        match self {
            Cons(a, b) => write!(f, "({}, {})", a, b),
            Nil => write!(f, "()"),
        }
    }
}

// the book is incorrect in section 15.4, see:
// https://github.com/rust-lang/book/issues/1656
// see: https://stackoverflow.com/q/52884893: brings up two issues:
// - `Drop` is problematic if the lifetime of a struct member is
//   equal to the lifetime of the struct
// - A reference to a temporary is allowed; it is as if the temporary
//   were declared as a variable in the enclosing scope.
// impl<'a> Drop for List<'a> {
//     fn drop(&mut self) {}
// }
