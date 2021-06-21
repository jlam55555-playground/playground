fn main() {
    // each value in Rust has a variable called its "owner"; there can only
    // be one owner at a time; and when the owner goes out of scope, the
    // value will be dropped

    // the String type involves a mutable element on the heap
    let mut s = String::from("Hello");
    s.push_str(", world!");
    println!("{}", s);

    // move invalidates the original variable
    let s1 = String::from("hello");
    let s2 = s1;
    println!("{}", s2); // putting s1 here would cause an error

    // clone (deep copy) is allowed and works as expected
    let s1 = String::from("hello");
    let s2 = s1.clone();
    println!("s1 = {}, s2 = {}", s1, s2);

    // variables with the Drop trait have special cleanup when they go out of
    // scope; variables with the Copy trait don't and cannot contain members
    // with the Drop trait. Copy-trait variables are usually entirely on the
    // stack and can easily be deep-copied.

    // passing a variable to a function has similar semantics to assignin
    // (including the copy semantic). Returning a variable from a function
    // will pass ownership

    // a function can also "borrow" its arguments; it has to be explicitly
    // declared mut if we want to be able to change it, like normal variables

    // you're only allowed to have one mutable reference to a particular piece
    // of data in a particular scope, and you're not allowed to have a mutable
    // reference simultaneously with immutable ones

    // Rust prevents dangling pointers with lifetimes -- there is a guarantee
    // that values will not go out of scope before you're done with them

    // slices example: slices are immutable borrows; note that string slices are
    // represented with str rather than String
    let phrase = String::from("hello world");
    let fw = first_word(&phrase[..]);
    println!("first word of {}: {}", phrase, fw);

    // other slices
    let a = [1, 2, 3, 4, 5];
    let slice: &[i32] = &a[1..3]; // explicitly put the type of the slice
    assert_eq!(slice, &[2, 3]);
}

// slices example: first_word
fn first_word(s: &str) -> &str {
    let bytes = s.as_bytes();

    for (i, &item) in bytes.iter().enumerate() {
        if item == b' ' {
            return &s[..i];
        }
    }

    &s[..]
}
