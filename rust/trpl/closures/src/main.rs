// closures are like functions
//
// in a closure, the type is usually inferred; that is because they are
// local (cannot be exported since they are not on the top-level)
//
// a closure can only be used with values of one type; it is not
// automatically polymorphic
//
// each closure instance his its own unique anonymous type
//
// All closures implement at least one of the traits: `Fn`, `FnMut`, or `FnOnce`
// - `FnOnce` tries to own the captured values (thus can only be called once)
// - `Fn` and `FnMut` borrow the values
//
// There are "move closures," which force a closure to own its variables --
// these are useful in threading
//
// Moving into a closure occurs when the closure is defined.
struct Cacher<T>
where
    T: Fn(u32) -> u32,
{
    calculation: T,
    value: Option<u32>,
}

impl<T> Cacher<T>
where
    T: Fn(u32) -> u32,
{
    fn new(calculation: T) -> Cacher<T> {
        Cacher {
            calculation,
            value: None,
        }
    }

    fn value(&mut self, arg: u32) -> u32 {
        match self.value {
            Some(v) => v,
            None => {
                let v = (self.calculation)(arg);
                self.value = Some(v);
                v
            }
        }
    }
}

fn main() {
    let z = 3;
    let mut computation = Cacher::new(|x| x+z);

    // note that the value will only be calculated with the
    // first value passed in; after wthat it will return
    // the first computed value; better to use a hashmap
    // to cache many values
    println!("First value: {}", computation.value(3));
    println!("Second value: {}", computation.value(4));

    // we can have nested functions; they just can't capture variables
    fn nested() {
        ()
    }

    nested();
}
