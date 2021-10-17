(* evaluator to interact with system called "toploop" *)

(* primitive types: unit, int, char, float, bool, string *)
let x = ()
let int_dec = 12354
let int_oct = 0o123
let int_bin = 0b101
let int_hex = 0x4AB

(* weirdness with integer negation *)
let neg_five = ~-5

(* logical operators all are prefixed with `l` *)
let not_five = lnot 5
let five_ls_1 = 5 lsl 1

(* fp numbers *)
let fp_nums = [ 0.2; 2e7; 3.1415926; 31.415926E-1; 2. ]

(* characters *)
let c = '\120'
let c_code = Char.code 'x'
let hex_c = '\x7e'
let upper_z = Char.uppercase_ascii 'z'
let char_from_int = Char.chr 33

(* strings *)
let hello_1 = "Hello".[1]

(* extended indexing operators;
 * see: https://discuss.ocaml.org/t/warning-when-using-a-b-c-operator-with-bytes/1484/3*)
let ( .%[]<- ) = Bytes.set
let ( .%[] ) = Bytes.get
;;
let hello_mut = Bytes.of_string "Hello" in
hello_mut.%[0] <- 'h';
hello_mut
;;
let substr = String.sub "Hello" 1 2

(* difference between `=` and `==`; fp are handled differently than ints *)
let comparisons = [ 1.0 = 1.0; 1.0 == 1.0; 1 == 1 ]

(* operator precedence levels are listed on page 11 *)

(* C is statically and weakly-typed *)
(* Lisp (CL?) is dynamically and strictly-typed *)
(* ML is statically and strictly typed *)

(* when an expression is evaluated, one of four things may happen:
 * - it may evaluate to an expression of the same type as the expression
 * - it may raise an exception
 * - it may not terminate
 * - it may exit
 * *)

(* compilation steps:
 * - `ocamlc -g -c -o program program.ml`
 * - `ocamlopt` is used for native compilation
 * - `ocamlc` produces `*.cmo` files, while `ocamlopt` produces `*.cmx` files
 * *)

(* `ocamldebug` similar to gdb, except that you can undo using
 * the `back` command *)
