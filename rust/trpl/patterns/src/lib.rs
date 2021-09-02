// patterns can be used to destructure values
// `if/while let` expressions can be used to match; if the
// pattern matches, then it is as if the condition is true
//
// general form of a `let` statement is:
// `let PATTERN = EXPRESSION;`
//
// function parameters can also be patterns
//
// tuple destructuring is another example of pattern-matching
//
// "refutable" vs. "irrefutable" patterns -- same as Haskell
// Function parameters, `let` statements, and `for` loops
// can only accept irrefutable patterns; `while let`, `if/let`,
// and `match` allow refutable patterns
//
// Rust warns if you try to `if let` an irrefutable pattern,
// since this is not very useful.

#[cfg(test)]
mod tests {
    #[test]
    fn match_literals() {
        let x = 1;

        match x {
            1 => println!("one"),
            2 => println!("two"),
            _ => println!("other"),
        }
    }

    #[test]
    fn match_parameters() {
        // can have both literal parameters and named parameters;
        // named parameters will shadow outside scope
        let x = Some(5);
        // this will get shadowed and never used; compiler
        // even warns about it
        let y = 10;

        match x {
            Some(50) => println!("Got 50"),
            Some(y) => println!("Matched, y={:?}", y),
            _ => println!("got other, x={:?}", x),
        }
    }

    #[test]
    fn match_or() {
        let x = 1;

        match x {
            1 | 2 => println!("one or two"),
            _ => println!("other"),
        }
    }

    #[test]
    fn match_range() {
        let x = 5;

        match x {
            // note that this only works for integer and char ranges
            1..=5 => println!("one through five"),
            _ => println!("other"),
        }
    }

    struct Point {
        x: i32,
        y: i32,
    }
    
    #[test]
    fn destructured_object() {
        let p = Point { x: 0, y: 7 };

        let Point { x, y } = p;
        assert_eq!(0, x);
        assert_eq!(7, y);
    }

    #[test]
    fn destructured_object_refutable() {
        let p = Point { x: 0, y: 7 };
        match p {
            Point { x, y: 0 } => println!("On the x axis at {}", x),
            Point { x: 0, y } => println!("On the y axis at {}", y),
            Point { x, y } => println!("On neither axis: ({}, {})", x, y),
        }
    }

    // enums can also be destructured -- we've already seen this before
    // pattern matching can be multiple levels deep as well; basically
    // we can destructure a complex value all the way down to its primitive
    // elements

    // note that `_` will never bind to a value in a pattern -- thus
    // it avoids accidentally moving a variable in when we don't care
    // about it

    // the `..` pattern ignores the remaining values in a struct or tuple;
    // it must be used unambiguously in a tuple

    #[test]
    fn match_guard() {
        let num = Some(4);

        match num {
            Some(x) if x < 5 => println!("less than five: {}", x),
            Some(x) => println!("{}", x),
            None => (),
        }
    }

    // same as Haskell as-patterns; note that these allow us to both test
    // and name a pattern, whereas before we could only do one or the other
    #[test]
    fn at_operator() {
        enum Message {
            Hello { id: i32 },
        }

        let msg = Message::Hello { id: 5 };

        match msg {
            Message::Hello {
                id: id_variable @ 3..=7,
            } => println!("Found an id in range: {}", id_variable),
            Message::Hello { id: 10..=12 } => {
                println!("Found an id in another range")
            }
            Message::Hello { id } => println!("Found some other id: {}", id),
        }
    }
}
