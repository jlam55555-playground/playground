// this can take as parameter any value that can be
// converted to `&str` by calling `.deref()` multiple times;
// this only works on `Deref` types of course.
// For example:
// `&Box<String> ~= Box<String>::deref() -> &String`
// `&String ~= String.deref() -> &str`
// so we can throw at this a dereferenced version of
// any one of these three types
pub fn hello(name: &str) {
    println!("Hello, {}!", name);
}
