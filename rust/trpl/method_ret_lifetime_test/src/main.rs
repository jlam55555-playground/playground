struct TestStruct {}

impl TestStruct {
    fn test_fn<'a>(&self, i: &'a i32) -> &'a i32 {
	i
    }
}

fn main() {
    let i;
    {
	let ts = TestStruct{};
	i = ts.test_fn(&5);
    }

    println!("i: {}", i);
}
