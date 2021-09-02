pub enum RcList {
    RcCons(i32, Rc<RcList>),
    RcNil,
}

pub use RcList::{RcCons, RcNil};
pub use std::rc::Rc;
