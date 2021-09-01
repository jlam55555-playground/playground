// this is how the iterator looks
// note that iterators are zero-cost abstractions
pub trait Iterator {
    // associated type -- we will look at this later
    type Item;
    fn next(&mut self) -> Option<Self::Item>;
}

fn iterator_demonstration() {
    let v1 = vec![1, 2, 3];

    let mut v1_iter = v1.iter();

    assert_eq!(v1_iter.next(), Some(&1));
    assert_eq!(v1_iter.next(), Some(&2));
    assert_eq!(v1_iter.next(), Some(&3));
    assert_eq!(v1_iter.next(), None);
}

// some methods consume iterators;
// these are called "consumers"
fn iterator_sum() {
    let v1 = vec![1, 2, 3];
    let v1_iter = v1.iter();

    let total: i32 = v1_iter.sum();

    assert_eq!(total, 6);
}

// others transform iterators; know that iterators are
// lazy so we have to collect it using a terminal operation
// like `collect()`;
// these are called "adapters"
fn iterator_map() {
    let v1 = vec![1, 2, 3];
    let v2: Vec<_> = v1.iter().map(|x| x+1).collect();

    assert_eq!(v2, vec![2, 3, 4]);
}

struct Counter {
    count: u32,
}

impl Counter {
    fn new() -> Counter {
	Counter { count: 0 }
    }
}

impl std::iter::Iterator for Counter {
    type Item = u32;

    fn next(&mut self) -> Option<Self::Item> {
	if self.count < 5 {
	    self.count += 1;
	    Some(self.count)
	} else {
	    None
	}
    }
}

fn main() {
    let v1 = vec![1, 2, 3];
    let v1_iter = v1.iter();

    for val in v1_iter {
	println!("Got: {}", val);
    }

    iterator_demonstration();
    iterator_sum();
    iterator_map();

    for i in Counter::new() {
	println!("Got value: {}", i);
    }
}
