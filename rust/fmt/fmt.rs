/*
 * learning how to use the std::fmt module macros. We also see the use
 * of named arguments
 *
 * ref:
 * - https://doc.rust-lang.org/stable/rust-by-example/hello/print.html
 * - https://doc.rust-lang.org/std/fmt/
 */

fn main() {
	// can have index
	println!("{0}, this is {1}. {1}, this is {0}.", "Alice", "Bob");

	// format strings after colon
	println!("{} of {:b} people know binary, the other half doesn't.",
		1, 2);

	// right/left alignment (>/<) and zero-padding
	// can use argument as padding width followed by $
	// see std::fmt docs for all options
	println!("{num:<3} {num:>00$} {num:>0num$} {num:width$}",
		num=10, width=4);
}
