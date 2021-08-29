// a program intended to demonstrate the use of structs

#[derive(Debug)]
struct Rectangle {
    width: u32,
    height: u32,
}

impl Rectangle {
    fn area(&self) -> u32 {
        self.width * self.height
    }
}

fn main() {
    let rect1 = Rectangle {
        width: 30,
        height: 50,
    };

    println!(
        "The area of the rectangle is {} square pixels.",
        rect1.area(),
        
        // the following line is equivalent:
        // Rectangle::area(&rect1),

        // original example:
        // area(&rect1),
    );

    println!("rect1 is {:?}", rect1);
    println!("rect1 is {:#?}", rect1);
}

// replaced by a method
// fn area(rectangle: &Rectangle) -> u32 {
//     rectangle.width * rectangle.height
// }
