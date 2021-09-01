struct MyBox<T>(T);

impl<T> MyBox<T> {
    fn new(x: T) -> MyBox<T> {
        MyBox(x)
    }
}

use std::ops::Deref;

impl<T> Deref for MyBox<T> {
    type Target = T;

    fn deref(&self) -> &Self::Target {
        &self.0
    }
}

mod deref_coercion;

#[cfg(test)]
mod tests {
    use super::*;
    
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
}
