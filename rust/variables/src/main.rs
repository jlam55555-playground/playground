fn main() {
    // this variable has to be mutable for the following example to work
    let mut x = 5;
    println!("The value of x is: {}", x);
    x = 6;
    println!("The value of x is: {}", x);

    // shadowing
    let x = 5;
    let x = x + 1;
    let x = x * 2;
    println!("The value of x is: {}", x);

    // numeric types: note that we can also use type annotations or suffixes,
    // and Rust supports up to 128-bit arithmetic on all platforms; default
    // type is i32 (for 32 or 64-bit systems)
    let _decimal = 98_222;
    let _hex = 0xff;
    let _octal = 0o77;
    let _binary = 0b1111_0000;
    let _byte = b'A'; // u8 only

    // in debug mode, rust will check for and warn of overflow, but it will
    // not in release mode; we can make the behavior explicit using the
    // wrapping_*, checked_*, overflowing_*, or saturating_* methods

    let _fp32 = 2.0f32;
    let _fp64 = 2.0;

    let _bool = true; // bool type

    // 32-bit unicode scalar value (not sure what the difference
    // between this and a code point is
    let _char = 'a';

    let _tuple: (i32, f64, u8) = (500, 6.4, 1);
    let _array: [i32; 5] = [1, 2, 3, 4, 5];

    let _array_initialized = [3; 5];

    // tuple indexing occurs like _tuple.0, array indexing like _array[3].
    // Rust performs bounds checks when indexing.

    // multiple variable declaration is done with tuple destructuring
    // (can also do this with mutable by adding the mut keyword as necessary)

    another_function(5);

    control_flow();

    for i in 0..10 {
	println!("fib({}) = {}", i, fib(i));
    }
}

fn another_function(x: i32) -> i32 {
    println!("Another function.");

    println!("The value of x is: {}", x);

    // rust makes a distinction (much like C) between statements and expressions
    // in particular, declarations (with let) are not expressions, but blocks
    // and function bodies are expressions -- the last value of the block, if
    // it doesn't end in a semicolon, is the value of the block expression
    let y = {
	let x = 3;
	x + 1
    };

    y
}

// returning nothing is implicit, but we can make it explicit with the ()
// void type
fn control_flow() -> () {
    let number = 3;
    
    // note that the condition must be a bool, and that we don't require ()
    if number < 5 {
	println!("condition was true");
    } else {
	println!("condition was false");
    }

    // note that if is a block, so it can be used as an expression; note that
    // the different arms must return the same type (note that (), the unit
    // type, is also a type)

    // loop is a block and thus can return a value (the argument to break)
    let mut x = 0;
    let loop_result = loop {
	if x == 10 {
	    break x;
	}
	println!("The value of x is: {}", x);
	x = x + 1;
    };
    println!("The expression value of the loop is: {}", loop_result);

    // there are also while loops, which are straightforward

    // for arrays, it is best to use a for loop, as we don't have the
    // implicit bounds checking (it is done for us)
    let a = [10, 20, 30, 40, 50, 60];
    for element in a.iter() {
	println!("The value is: {}", element);
    }
}

// exercise suggested by the book: calculate fibonacci numbers
fn fib(n: i32) -> i32 {
    if n < 2 {
	return n;
    }

    let (mut a, mut b) = (0, 1);
    for _ in 1..n {
	let tmp = b;
	b += a;
	a = tmp;
    }
    b
}
