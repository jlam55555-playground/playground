#![allow(unused_variables)]
#![allow(unused_imports)]

use std::thread;
use std::time::Duration;

// test using `cargo test -- --nocapture --test-threads=1`
#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn spawn_threads() {
        thread::spawn(|| {
            for i in 1..10 {
                println!("hi number {} from spawned thread!", i);
                thread::sleep(Duration::from_millis(1));
            }
        });

        for i in 1..5 {
            println!("hi number {} from the main thread!", i);
            thread::sleep(Duration::from_millis(1));
        }
    }

    #[test]
    fn spawn_threads_join() {
        let handle = thread::spawn(|| {
            for i in 1..10 {
                println!("hi number {} from spawned thread!", i);
                thread::sleep(Duration::from_millis(1));
            }
        });

        for i in 1..5 {
            println!("hi number {} from the main thread!", i);
            thread::sleep(Duration::from_millis(1));
        }

        handle.join().unwrap();
    }

    // without the `move` keyword, doesn't compile because
    // thread closure may outlive calling function
    #[test]
    fn move_into_thread() {
        let v = vec![1, 2, 3];

        let handle = thread::spawn(move || {
            println!("Here's a vector: {:?}", v);
        });

        handle.join().unwrap();
    }
}
