(** @author Jonathan Lam <jlam55555@gmail.com> **)
(* see section about ocamldoc; this is a documentation tag *)

(* semantics: meaning of a program
 * - dynamic semantics: run-time behavior
 * - static semantics: compile-time checking for legality, past syntax
 *   (e.g., type checking)
 * *)

let x = 42

let _ = print_endline "Hello world!"
;;

(* `let` definitions at the toplevel don't evaluate to any value; you can think of
 * them as a `let` expression with an implicit body of the rest of the program
 * typed into the toplevel
 * *)

(* We can define the dynamic and static semantics of statements like `if` and `let` *)

(* Variable scoping:
 * We should avoid shadowing names in nested `let` expressions.
 * It does what we expect, following the "principle of name irrelevance": the name
 * of a variable shouldn't intrinsically matter;
 * I.e., "alpha equivalence": two functions are equivalent up to renaming of variables
 * (a.k.a. "alpha conversion")
 *
 * Toplevel let expressions are not mutable assignment, but rather shadowing; a variable
 * can be bound and stick around even after it is shadowed
 *
 * Fixnums have a maximum size of 31 or 63 bits. One bit is stolen to distinguish between
 * ints and pointers for the garbage collector's use. Thus in a signed integer, we only
 * get 62 bits.
 *
 * Recursive functions defined with `let rec`
 *
 * Mutually recursive functions defined with `let rec ... and`
 *
 * We have metavariables in the type declarations: these can either indicate values (in
 * function definitions) or types (in type declarations)
 *
 * No dynamic semantics of function definitions; only when funnctions is applied
 *
 * Type checking rule for recursive functions assumes a particular type, and then checks
 * that the function body is well-type under that assumption.
 *
 * For lambda functions, static semantics is the same as (ordinary) functions
 * *)

(* the following are equivalent; rather, the `let` syntax is syntactic sugar for
 * function application
 * *)
let x = 3 in x + 2
;;

(fun x -> x + 2) 3
;;

(* the pipeline operator *)
let inc x = x + 1
;;

let square x = x * x
;;

5 |> inc |> square |> inc |> inc |> square
;;

(* polymorphism simply means "many forms" *)
let id x = x
;;

(* labeled and optional arguments *)
let f ~augend:x ~addend:y = x + y
;;

(* or *)
let f ~augend ~(addend:int) : int = augend + addend
;;

f ~augend:2 ~addend:3
;;

(* note that a non-optional argument must be last,
 * otherwise OCaml will get confused
 * *)
let f ?(x=0) ?arg2:((y:int)=0) z = x + y + z
;;

f 0
;;

f ~x:1 0
;;

f ~x:1 ~arg2:2 0
;;

(* functions each take one argument
 * function types are right associative
 * function applications are left associative
 * *)

(* ocamldoc examples *)
(** [sum lst] is the sum of the elements of list [lst].
 ** The sum of an empty list is 0. **)
let rec sum lst = match lst with
  | [] -> 0
  | x :: xs -> x + sum xs

(* good to specify declaratively using "is"
 * don't need to specify the type of each parameter, or
 * describe each one, as this is usually redundant
 * good to specify which exceptions might be thrown by this function
 * "Requires:" preconditions and "Raises:" postconditions *)

(* rob miller's defenses against bugs:
 * 1. make them impossible
 * 2. use tools that find them
 * 3. make them immediately visible
 * 4. extensive testing
 * 5. debugging
 *
 * steps for debugging:
 * 1. distill the bug into a small test case
 * 2. employ the scientific method
 * 3. fix the bug
 * 4. permanently add the small test case to your test suite
 *
 * debugging in ocaml:
 * 1. print statements:
 *    let () = print_something in ...
 * 2. function traces:
 *    #trace fib;;
 *    #untrace fib;;
 * 3. ocamldebug
 *
 * options for checking preconditions:
 * - `assert`
 * - error function, e.g., `invalid_arg` or `failwith`
 *
 * preconditions may be rewritten as postconditions, which force
 * the implementation of the function to check it (rather than
 * preconditions, where it is ambiguous whether the caller or the
 * callee has to enforce the precondition)
 * *)

(* special syntax for functions that return unit: use semicolon
 * for non-unit types, this is a warning because you are throwing
 * away return info; if this is desired, use the `ignore` function
 * to disregard a value and return unit (similar to the `void`
 * syntax in C)
 * *)
