open Base
open Stdio

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

(* variant type syntax *)
type ptype = TNormal | TFire | TWater
type peff = ENormal | ENotVery | ESuper

(* record type syntax *)
type mon = { name: string
           ; hp: int
           ; ptype: ptype
           }

let _ =
  let c = { name="Charmander"; hp=39; ptype=TFire } in
  match c with { name=n; hp=h; ptype=t } -> h |> Int.to_string |> Stdio.print_endline ;
    match c with { name; hp; ptype } -> hp |> Int.to_string |> Stdio.print_endline ;
      (* record update syntax *)
      let c2 = { c with name="Charmeleon"; hp=58 } in
      match c2 with {hp} -> hp |> Int.to_string |> Stdio.print_endline

(* tuples type syntax; note that parens are (usually) optional, unless operation
 * precedence is an issue
 * *)
let _ =
  match 1,2,3 with
  | x,y,z -> x + y + z

(* sum vs. product types:
 * - variant types are "sum types", which are one of a number of types
 * - tuple types are "product types" (product as in cartesian product), which
 *   means they include all of the types
 * *)

(* advanced pattern matching *)
(* "or" patterns, constant matching, pattern guards *)
let _ = match 5 with
  | x when x >= 1 && x <= 3 -> "1 or 2 or 3"
  | 4 | 5 -> "4 or 5"
  | _ -> "other"

(* character ranges and as-patterns *)
let _ = match 'F' with
  | 'a'..'z' as c -> c
  | 'A'..'Z' as c -> Char.lowercase c
  | _ -> failwith "not a letter"

