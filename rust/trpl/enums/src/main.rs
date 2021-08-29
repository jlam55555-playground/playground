// enums are "algebraic data types"

#[derive(Debug)]
enum IpAddrKind {
    V4,
    V6
}

#[derive(Debug)]
struct IpAddr {
    kind: IpAddrKind,
    address: String,
}

// alternatively; note that enums can store data associated with them,
// and the data can be different for different enum entries of the same
// kind; this is kind of like a safer union

// enum Ipv4Addr {
//     // ...
// }

// enum Ipv6Addr {
//     // ...
// }

// enum IpAddr {
//     V4(Ipv4Addr),
//     V6(Ipv6Addr),
// }

enum Message {
    Quit,
    Move { x: i32, y: i32 },
    Write(String),
    ChangeColor(i32, i32, i32),
}

// note: we can define methods on enums
impl Message {
    fn call(&self) {
        // ...
    }
}

#[derive(Debug)]
enum UsState {
    Alabama,
    Alaska,
    // ...
}

enum Coin {
    Penny,
    Nickel,
    Dime,
    Quarter(UsState),
}

fn value_in_cents(coin: Coin) -> u8 {
    match coin {
        Coin::Penny => 1,
        Coin::Nickel => 5,
        Coin::Dime => 10,

        // we can extract values from an enum
        Coin::Quarter(state) => {
            println!("State quarter from {:?}!", state);
            25
        },
    }
}

// very similar to the Maybe monad
fn plus_one(x: Option<i32>) -> Option<i32> {
    match x {
        None => None,
        Some(i) => Some(i+1),
    }
}

// if-let is same as a match statement with only one branch
fn plus_one_if_let(x: Option<i32>) -> Option<i32> {
    if let Some(i) = x {
        Some(i+1)
    } else {
        None
    }
}

fn main() {
    println!("Hello, world!");

    let _four = IpAddrKind::V4;
    let _six = IpAddrKind::V6;

    let home = IpAddr {
        kind: IpAddrKind::V4,
        address: String::from("127.0.0.1"),
    };

    let loopback = IpAddr {
        kind: IpAddrKind::V6,
        address: String::from("::1"),
    };

    println!("IpAddr1: {:#?}", home);
    println!("IpAddr1: {:#?}", loopback);
}
