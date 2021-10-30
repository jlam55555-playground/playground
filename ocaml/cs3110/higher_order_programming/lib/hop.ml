module Helpers = Helpers
open Helpers

(* higher-order programming *)
let double x = 2 * x
let square x = x * x

let twice f x = f (f x)

let quad x = twice double x
let fourth x = twice square x

(* higher-order functions either take other functions as input or return
 * other functions as output (or both); higher-order functions are also
 * known as "functionals" *)

(* meaning of "higher order" w.r.t. logic:
 * - "first order": universal and existential quantifiers over some domain
 * - "second order": quantify over properties of the domain; properties
 *   are assertions about individual elements
 * - "third order": quantification over properties of properties
 * - "fourth order" quantification over properties of properties of properties
 * - "higher order": all logics that are more powerful than first-order
 *   logic; all higher-order logics can be expressed in second-order logic
 *
 * meaning of "higher order" in programming languages:
 * - "first order": functions that operate on individual data elements
 * - "higher order": functions that can operate on functions *)

(* "abstraction principle": avoid requiring something to be stated more than
 * once: factor out the recurring pattern *)

(* sample higher-order functions: *)
let apply f x = f x
let pipeline x f = f x
let ( |> ) = pipeline
let compose f g x = f (g x)
let both f g x = f x, g x
let cond p f g x = if p x then f x else g x

(* famous higher-order functions *)

(* [map f [x1; x2; ...; xn]] is [[f x1; f x2; ...; f xn]] *)
let rec map1 f = function
  | [] -> []
  | x::xs -> f x :: map1 f xs

(* [filter p l] is the list of elements of [l] that satisfy the predicate [p].
 * The order of the elements in the input list is preserved. *)
let rec filter1 f = function
  | [] -> []
  | x::xs -> if f x then x :: filter1 f xs else filter1 f xs

(* Note the following types:
 * `val fold_left : ('a -> 'b -> 'a) -> 'a -> 'b list -> 'a = <fun>`
 * `val fold_right : ('a -> 'b -> 'b) -> 'a list -> 'b -> 'b = <fun>` *)
let rec fold_left f acc = function
  | [] -> acc
  | x::xs -> fold_left f (f acc x) xs

let rec fold_right f lst acc = match lst with
  | [] -> acc
  | x::xs -> f x (fold_right f xs acc)

(* difference between these two matters when `f` is left-associative
 * vs. right-associative, and if we care about tail-recursion (`fold_left`
 * is tail-recursive, `fold_rght` is not) *)

(* see `ListLabels` module for `fold_left` and `fold_right` with labeled
 * arguments *)

(* writing other functions in terms of `fold_*` *)
let length l = fold_left (fun a _ -> a+1) 0 l
let rev l = fold_left (fun a x -> x::a) [] l
let map f l = fold_right (fun x a -> f x :: a) l []
let filter f l = fold_right (fun x a -> if f x then x::a else a) l []

(* fold on tree data structures *)
type 'a tree = Leaf | Tree of 'a * 'a tree * 'a tree

let rec foldtree init f = function
  | Leaf -> init
  | Tree (v,l,r) -> f v (foldtree init f l) (foldtree init f r)

let size t = foldtree 0 (fun _ l r -> 1 + l + r) t
let depth t = foldtree 0 (fun _ l r -> 1 + max l r) t
let preorder t = foldtree [] (fun x l r -> [x] @ l @ r) t

(* the fold operation can be generalized to any OCaml variant type,
 * using the following procedure:
 * - write a recursive `fold` function that takes in one argument for
 *   each constructor of the variant type `t`
 * - That `fold` function matches against the constructors, calling
 *   itself recursively on any value of type `t` that it encounters
 * - Use the appropriate argument of `fold` to combine the results
 *   of all recursive calls as well as all data not of type `t` at each
 *   constructor
 *
 * This technique constructs something called a "catamorphism", or a
 * generalized fold operation *)

(* pipelining is very natural and reads top-to-bottom or left-to-right
 * as opposed to normal function composition (rtl) or explicit loops/recursion
 * (difficult to quickly grok). E.g., sum of squares: *)
let sum_sq_1 n =
  (* recursive, difficult to read and write *)
  let rec loop i sum =
    if i>n then sum
    else loop (i+1) (sum + square i)
  in loop 0 0

let sum_sq_2 n =
  (* pipelining, elegant *)
  0 -- n
  |> List.map square
  |> sum

let sum_sq_3 n =
  (* regular composition reads rtl (inside-to-outside) *)
  sum (List.map square (0 -- n))

let sum_sq_4 n =
  (* lots of let statements to read top-to-bottom w/o pipelining *)
  let l = 0 -- n in
  let sq_l = List.map square l in
  sum sq_l
