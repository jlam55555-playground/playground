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

    
}
