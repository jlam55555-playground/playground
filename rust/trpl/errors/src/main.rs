// `panic!` typically unwinds the stack and performs cleanup
// instead we can tell it in `Cargo.toml` to simply abort

fn main() {
    // panic!("crash and burn");

    let v = vec![1, 2, 3];
    v[99];
}
