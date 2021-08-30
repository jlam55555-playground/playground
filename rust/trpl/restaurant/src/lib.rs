mod front_of_house;

// define some modules and function signatures
pub fn eat_at_restaurant() {
    // // absolute path
    // crate::front_of_house::hosting::add_to_waitlist();

    // // relative path
    // front_of_house::hosting::add_to_waitlist();

    // let mut meal = back_of_house::Breakfast::summer("Rye");
    // meal.toast = String::from("Wheat");
    // println!("I'd like {} toast please", meal.toast);

    // note: we can also import `add_to_waitlist` diroectly,
    // but bringing its immediate module is more idiomatic Rust
    pub use crate::front_of_house::hosting;

    hosting::add_to_waitlist();
    hosting::add_to_waitlist();
    hosting::add_to_waitlist();
}

fn serve_order() {}

mod back_of_house {

    // we can hide some of the fields of a struct
    pub struct Breakfast {
        pub toast: String,
        seasonal_fruit: String,
    }

    impl Breakfast {
        pub fn summer(toast: &str) -> Breakfast {
            Breakfast {
                toast: String::from(toast),
                seasonal_fruit: String::from("peaches"),
            }
        }
    }
    
    fn fix_incorrect_order() {
        cook_order();
        super::serve_order();
    }

    fn cook_order() {}
}
