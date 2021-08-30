#[cfg(test)]
mod tests {
    #[test]
    fn exploration() {
        assert_eq!(2 + 2, 4);
    }

    #[test]
    #[should_panic]
    fn another() {
	panic!("This fails");
    }

    use super::*;

    #[test]
    fn larger_can_hold_smaller() {
	let larger = Rectangle {
	    width: 8,
	    height: 7,
	};
	let smaller = Rectangle {
	    width: 5,
	    height: 1,
	};

	assert!(larger.can_hold(&smaller));
    }

    #[test]
    fn returns_result() -> Result<(), String> {
	if 2 + 2 == 4 {
	    Ok(())
	} else {
	    Err(String::from("two plus two does not equal four"))
	}
    }
}

#[derive(Debug)]
struct Rectangle {
    width: u32,
    height: u32,
}

impl Rectangle {
    fn can_hold(&self, other: &Rectangle) -> bool {
	self.width > other.width && self.height > other.height
    }
}

pub fn add_two(a: i32) -> i32 {
    internal_adder(a, 2)
}

fn internal_adder(a: i32, b: i32) -> i32 {
    a + b
}
