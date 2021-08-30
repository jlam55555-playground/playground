struct ImportantExcerpt<'a> {
    part: &'a str,
}

fn main() {
    let r;
    {
	let x = 5;
	r = &x;
    }
    // error: borrowed value does not live long enough
    //    println!("r: {}", r);

    let novel = String::from("Call me Ishmael. Some years ago...");
    let first_sentence = novel.split('.').next()
	.expect("Could not find a '.'");

    // this struct only lives as long as the borrowed string
    let i = ImportantExcerpt {
	part: first_sentence,
    };
}

// error: this function's return type contains a borrowed value,
// but the signature does not say whether it is borrowed from `x` or `y`;
// when returning a reference from a function, the lifetime parameter
// for the return type needs to match the lifetime parameter for one
// of the parameters
// fn longest(x: &str, y: &str) -> &str {
//     if x.len() > y.len() {
// 	x
//     } else {
// 	y
//     }
// }

fn longest<'a>(x: &'a str, y: &'a str) -> &'a str {
    if x.len() > y.len() {
	x
    } else {
	y
    }
}

// output elision allows you to omit some lifetime annotations
// in cases where the compiler can figure it out on its own. Rules:
// 1. Each parameter has its own lifetime parameter.
// 2. If there is one input lifetime, that lifetime is assigned to all
//    output lifetime parameters.
// 3. If there are multiple input lifetime parameters, but one of them
//    is `&self` or `&mut self` (i.e., a method with a reference target),
//    the lifetime of `self` is assigned to all output lifetime parameters.

// example of everything put together
use std::fmt::Display;

fn longest_with_an_announcement<'a, T>(
    x: &'a str,
    y: &'a str,
    ann: T,
) -> &'a str
where T: Display,
{
    println!("Announcement! {}", ann);
    if x.len() > y.len() {
	x
    } else {
	y
    }
}
