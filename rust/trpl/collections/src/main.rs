fn main() {
    let _v: Vec<i32> = Vec::new();

    // can infer types
    let _v = vec![1, 2, 3];

    let mut _v = Vec::new();
    _v.push(5);
    _v.push(6);
    _v.push(7);
    _v.push(8);

    // a vector contains (owns) its elements, so when it is dropped its
    // elements also get dropped

    let _third: &i32 = &_v[2];
    match _v.get(2) {
        Some(third) => println!("The third element is {}.", third),
        None => println!("There is no third element."),
    }

    // note that the following will not work; is an immutable and mutable
    // borrow of v simultaneously
    // let mut v = vec![1, 2, 3, 4, 5];
    // let first = &v[0];
    // v.push(6);
    // println!("The first element is {}.", first);

    // iterating over a vector
    for i in &_v {
        println!("{}", i);
    }

    // iterating over a vector with mutable references
    let mut _v = vec![100, 32, 57];
    for i in &mut _v {
        *i += 50;
    }
    for i in &_v {
        println!("{}", i);
    }

    // enums (algebraic types) can be used to store unrelated types
    // in a vector (think: vector of unions)

    // Note difference between `str` and `String` borrowed and owned
    // types; also `OsString`, `OsStr`, `CString`, `CStr`, etc.

    // ways to create a string
    let _s = String::from("Initial contents");
    let _s = "Initial contents".to_string();
    let _s = "Initial contents".to_owned();

    let mut _s = String::from("foo");
    _s.push_str("ba");
    _s.push('r');
    println!("{}", _s);

    // concatenation behavior is a little tricky to avoid
    // excess copying; this takes ownership of s1 and only
    // copies s2
    let _s1 = String::from("Hello, ");
    let _s2 = String::from("world!");
    let _s3 = _s1 + &_s2;

    let _s1 = String::from("tic");
    let _s2 = String::from("tac");
    let _s3 = String::from("toe");
    let _s = _s1 + "-" + &_s2 + "-" + &_s3;

    // using `format!` doesn't borrow any of the operands
    let _s1 = String::from("tic");
    let _s = format!("{}-{}-{}", &_s1, &_s2, &_s3);

    // Slicing a string literal over an invalid boundary causes
    // a compile-time error

    // three ways of looking at Unicode text:
    // bytes, unicode scalar values (may be part of a letter),
    // and grapheme clusters (letters)

    // can iterate over a string using the `String::chars()`
    // or `String::bytes()` methods
    
    use std::collections::HashMap;

    let mut scores = HashMap::new();
    scores.insert(String::from("Blue"), 10);
    scores.insert(String::from("Yellow"), 50);

    // we can use the `collect` method on a array of tuples
    // to generate a `HashMap`; we can generate the array of tuples
    // from key and value arrays using `zip`
    let teams = vec![String::from("Blue"), String::from("Yellow")];
    let initial_scores = vec![10, 50];

    // need a type annotation here because `collect` can return different types
    let scores: HashMap<_, _> =
        teams.into_iter().zip(initial_scores.into_iter()).collect();

    // values will be copied/moved into a hashmap like normal
    // references stored in a hashmap will last at least as long as the
    // hashmap is valid
    if let Some(score) = scores.get("Blue") {
        println!("Blue score: {}", score);
    }

    // iterating over a `HashMap`
    for (key, value) in &scores {
        println!("{}: {}", key, value);
    }

    // updating/overwriting a value in a `HashMap` is easy with
    // `HashMap::insert`

    // updating values if they don't exist: use `HashMap::entry()`
    // and `Entry::or_insert`. Note that the latter returns a mutable
    // reference to the value
    let text = "hello world wonderful world";
    let mut map = HashMap::new();

    for word in text.split_whitespace() {
        let count = map.entry(word).or_insert(0);
        *count += 1;
    }
}
