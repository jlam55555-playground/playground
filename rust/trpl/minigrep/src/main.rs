use std::env;
use std::process;

// general idea: move most of your logic to `lib.rs`;
// only have some small driver code in `main.rs` (e.g., command-line
// parsing code); this allows you to test your code (`main.rs` cannot
// be tested directly)
fn main() {
    let config = minigrep::Config::new(env::args()).unwrap_or_else(|err| {
        eprintln!("Problem parsing arguments: {}", err);
        process::exit(1);
    });

    if let Err(e) = minigrep::run(config) {
        eprintln!("Application error: {}", e);
        process::exit(1);
    }
}
