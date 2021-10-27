(* lists: if the element of a list has type `t`, then the list is
 * of type `t list` -- this is read from right to left;
 *
 * `list` is a type constructor -- given a type (`int`), it constructs
 * another type (`int list`) -- it is like a function that operates
 * on types rather than on values
 * *)

(* use notation `e ==> v` to indicate an expression `e` evaluations to
 * a value `v` (not part of OCaml language, but the language of our
 * reasoning)
 * *)

(* static semantics for lists:
 * `[] : a' list`
 * `e1 : t` ^ `e2 : t list` => `e1::e2 :: t list`
 * *)

(* list functions use recursion, is very related to induction
 * note that there are also the functions `List.hd` and `List.tl`,
 * but it is not considered idiomatic to use these
 * *)

(* list static checking also checks for pattern exhaustiveness
 * and unused patterns
 * *)

(* for pattern-matching the final argument of a function, the
 * `function` keyword may be used in place of a `match` stmt
 * *)

(* no list comprehension syntax built-into the language *)

(* variant types can be defined like the following;
 * note that the later definition will prevail if there are multiple
 * constructors with the same name, unless we explicitly declare the
 * type of `x` to be `t1`
 * *)
type t1 = C | D
type t2 = D | E
let x = D
