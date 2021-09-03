// unsafe superpowers:
// - dereference a raw pointer
// - call an unsafe function or method
// - access or modify a mutable static variable
// - implement an unsafe trait
// - access fields of `union`s
//
// references and borrowing are still the same
//
// raw pointers are of the type `*const T` or `*mut T`
// and are distinct from references

#[cfg(test)]
mod tests {
    #[test]
    fn raw_pointers() {
        let mut num = 5;

        // allowed to create raw pointers in safe code;
        // just can't dereference them here
        let r1 = &num as *const i32;
        let r2 = &mut num as *mut i32;

        let address = 0x012345usize;
        let r = address as *const i32;

        unsafe {
            println!("r1 is: {}", *r1);
            println!("r2 is: {}", *r2);
            // causes segmentation fault
            // println!("r is: {}", *r);
        }
    }

    unsafe fn dangerous() {}
    
    #[test]
    fn call_unsafe() {
        unsafe {
            dangerous();
        }
    }

    use std::slice;

    fn split_at_mut(slice: &mut [i32], mid: usize) -> (&mut [i32], &mut [i32]) {
        let len = slice.len();
        let ptr = slice.as_mut_ptr();

        assert!(mid <= len);

        unsafe {
            (
                slice::from_raw_parts_mut(ptr, mid),
                slice::from_raw_parts_mut(ptr.add(mid), len - mid),
            )
        }
    }

    #[test]
    fn safe_wrapper() {
        let mut v = vec![1, 2, 3, 4, 5, 6];
        let r = &mut v[..];
        let (a, b) = r.split_at_mut(3);

        assert_eq!(a, &mut [1, 2, 3]);
        assert_eq!(b, &mut [4, 5, 6]);
    }

    #[test]
    fn use_extern() {
        extern "C" {
            // note: extern functions are automatically unsafe
            fn abs(input: i32) -> i32;
        }

        unsafe {
            println!("abs(-3) using the C stdlib abs: {}", abs(-3));
        }
    }

    #[test]
    fn mutable_static() {
        // globals in Rust are called static variables and
        // declared with the `static` keyword; references to static
        // variables always have lifetime `'static`.
        static HELLO_WORLD: &str = "Hello, world!";

        println!("name is: {}", HELLO_WORLD);

        // as expected, globals can cause data races in multithreaded
        // programs; therefore, accessing or modifying a mutable
        // static variable is unsafe

        static mut COUNTER: u32 = 0;

        fn add_to_count(inc: u32) {
            unsafe {
                COUNTER += inc;
            }
        }

        add_to_count(1);
        add_to_count(2);
        add_to_count(3);

        unsafe {
            println!("COUNTER: {}", COUNTER);
        }
    }
}

#[no_mangle]
pub extern "C" fn call_from_c() {
    println!("Called a Rust function from C!");
}
