open Base

(* lested `let/in` expressions to build up the components of a larger function *)
let area_of_ring inner_radius outer_radius =
  let pi = Float.acos (-1.) in
  let area_of_circle r = pi *. r *. r in
  area_of_circle outer_radius -. area_of_circle inner_radius

let _ = area_of_ring 1. 3.

let (ints, strings) = List.unzip [(1,"one"); (2,"two"); (3,"three")]

(* tuple and record patterns are irrefutable, but list patterns are not;
 * using a pattern in a `let` binding makes mose sense for irrefutable patterns;
 * even if an empty list can't come up in practice, best to have an empty
 * case (e.g., w/ and assertion) there just to be safe
 * *)

(* while calling a curried function with all of its arguments has no extra cost,
 * partial application of a curried function has some extra cost
 * *)

(* calling convention with tuples is pretty efficient; OCaml doesn't have
 * to allocate a new tuple for the function invocation
 * *)

(* recursive functions have to be explicitly labelled so that the type-inference
 * can fork correctly. Recursive functions are harder to reason about than
 * non-recursive ones, and "having a nonrecursive form makes it easier to
 * create a new definition that extends and supercedes an existing one
 * by shadowing it"
 * *)

(* a function is treated syntactically as an operator if the name of that
 * function is chosen from one of a specialized set of characters, including:
 * ! $ % & * + - . / : < = > ? @ ^ | ~
 *
 * a description of what the operators usually mean based on their prefixes
 * is given on page 37
 * *)

(* The pipe operator is defined as follows, and depends on its
 * left-associativity and low precedence:
 * *)
let ( |> ) x f = f x

(* We can also declare functions with the `function` keyword, which has
 * built-in pattern matching (think Haskell); this is equivalent to combining
 * an ordinary function with a `match` clause; note that we don't explicitly
 * list the argument to the function
 * *)
let some_or_zero = function
  | Some x -> x
  | None -> 0

let _ = List.map ~f:some_or_zero [Some 3; None; Some 4]

(* label punning can be used in function definitions and when invoking the
 * function
 *
 * use cases for punning:
 * - functions with lots of arguments
 * - functions in which types don't make argument purposes clear
 * - functions with multiple arguments that might get confused with one another
 * - when you want flexibility in the order of arguments
 *
 * notes:
 * - labels act as part of type: cannot mix functions that take different
 *   label names
 * - for higher-order functions, label order matters
 * *)
let ratio ~num ~denom = Float.of_int num /. Float.of_int denom

let _ =
  let num = 3 in
  let denom = 4 in
  ratio ~num ~denom

(* optional arguments are easy to abuse: they "really only make sense when the
 * extra concision of omitting the argument outweighs the corresponding loss
 * of explicitness"
 *
 * optional arguments can be passed explicitly using the `Some x` or `None`
 * notation by using the `?arg:value` notation rather than the `~arg:value`
 * notation
 *
 * due to the ambiguity lent by the multiple uses of `~` for both labelled
 * arguments and optional arguments, we may need to supply extra type info
 *
 * optional arguments are difficult in regards to partial application: they are
 * "erased" "as soon as the first positional argument defined after the
 * optional argument is passed in"); however if the function is totally
 * applied, this is not a problem, and we can write optional arguments
 * anywhere
 *
 * as a result of the previous statement, a function that has an optional
 * argument as its final parameter means that that optional parameter cannot
 * be erased, i.e., it is effectively not optional; this gives the warning:
 * `unerasable-optional-argument`
 * *)
let non_opt x ?(y=0) = x + y

(* summary: labeled and optional arguments are complex, but useful for
 * making API's both more convenient and safer
 * *)
