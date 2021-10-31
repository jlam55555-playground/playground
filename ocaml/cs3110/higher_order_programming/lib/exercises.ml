open Helpers

(* twice, no arguments
 *
 * `quad` and `fourth` can be function types without using
 * the function syntax because `twice` returns a function type
 * (it is a higher-order function) *)
let double x = 2 * x
let square x = x * x
let twice f x = f (f x)
let quad = twice double
let fourth = twice square

(* mystery operator
 *
 * `$` is a left-associative infix operator with a lower
 * precedence than `+`, so it allows right-associativity
 * of function arguments. This is a predefined operator in Haskell *)
let ( $ ) f x = f x

let _ = square $ 2 + 2
let _ = square 2 + 2

(* mystery operator 2
 *
 * this is a function composition operator (seems to be
 * builtin to the language). This is similar to the `.` operator
 * in Haskell *)
let ( @@ ) f g x = x |> g |> f

let _ = List.map (String.length @@ string_of_int) [1;10;100]

(* repeat *)
let rec repeat f n x =
  if n = 0 then x
  else repeat f (n-1) (f x)

(* product *)
let product_left = List.fold_left ( *. ) 1.
let product_right lst = List.fold_right ( *. ) lst 1.

(* clip *)
let clip n =
  if n < 0 then 0
  else if n > 10 then 10
  else n

let cliplist_1 = List.map clip

let rec cliplist_2 = function
  | [] -> []
  | x::xs -> clip x :: cliplist_2 xs

(* sum_cube_odd
 *
 * the `$` operator has different behavior in OCaml
 * due to its precedence and associativity, so we have
 * to be careful with its usage; we can combine it with
 * `@@`, which is right associative and has higher precedence *)
let sum_cube_odd_1 n = List.fold_left (+) 0
  @@ List.map (fun x -> x * x * x)
     $ List.filter (fun x -> x mod 2 <> 0) (0 -- n)

(* sum_cube_odd pipeline *)
let sum_cube_odd_2 n =
  0 -- n
  |> List.filter (fun x -> x mod 2 <> 0)
  |> List.map (fun x -> x * x * x)
  |> List.fold_left (+) 0

(* exists *)
let rec exists_rec p = function
  | [] -> false
  | x::xs -> if p x then true else exists_rec p xs

let exists_fold p = List.fold_left (fun acc x -> acc || p x) false

let exists_lib = List.exists    (* is this cheating??? *)

(* budget
 * 
 * I don't really understand this question -- is this simply
 * subtracting a list of integers (expenses) from an integer
 * (the budget)? *)

(* library uncurried *)
let uncurried_nth (lst,n) = List.nth lst n
let uncurried_append (lst1,lst2) = List.append lst1 lst2
let uncurried_compare (c1,c2) = Char.compare c1 c2
let uncurried_max (x,y) = Stdlib.max x y

(* uncurry
 * 
 * this only works for functions with two arguments though? *)
let uncurry f = fun (x,y) -> f x y

(* compiler complains about weak types without explicit parameters *)
let uncurried_nth_2 n = uncurry List.nth n
let uncurried_append_2 n = uncurry List.append n
let uncurried_compare_2 = uncurry Char.compare
let uncurried_max_2 n = uncurry max n

(* curry *)
let curry f = fun x y -> f (x,y)

(* terse product
 * 
 * I think my solutions are fairly terse
 *
 * (I was thinking tensor products when I read this, scared me
 * for a moment) *)

(* map composition *)
let map_fg f g = List.map (f @@ g)

let _ = map_fg square double [1;2;3]

(* more list fun *)
let strings_len_gt_3 lst = List.filter (fun s -> List.length s > 3) lst
let add_1_map = List.map (fun x -> x +. 1.)
let join_delim lst delim =
  let s = List.fold_left (fun acc s -> acc ^ delim ^ s) "" lst in
  String.sub s (String.length delim) (String.length s - String.length delim)

(* tree map *)
type 'a tree = Leaf | Node of 'a * 'a tree * 'a tree

let rec tree_map f = function
  | Leaf -> Leaf
  | Node (v,l,r) -> Node (f v,tree_map f l,tree_map f r)

let add1 = tree_map (fun x -> x + 1)

let _ = add1 $ Node (2, Node (3, Leaf, Node (4, Leaf, Leaf)), Leaf)

(* association list keys
 *
 * is `List.sort_uniq` cheating? *)
let keys al = List.sort_uniq compare $ List.map fst al

(* valid matrix *)
let is_valid_matrix = function
  | [] -> false
  | row::rows -> let cols = List.length row in
    if cols = 0 then false
    else List.for_all (fun row -> List.length row = cols) rows

(* row vector add *)
let add_row_vectors = List.map2 (+)

(* matrix add *)
let add_matrices = List.map2 add_row_vectors

(* matrix multiply *)
let dot_row_vectors m n = List.fold_left (+) 0 (List.map2 ( * ) m n)
let rec transpose_matrix = function
  (* ref: https://blog.shaynefletcher.org/2017/08/transpose.html
   * less elegant than Lisp with n-ary `map` but still okay *)
  | [] | [] :: _ -> []
  | m -> List.map List.hd m :: transpose_matrix (List.map List.tl m)

let multiply_matrices m1 m2 =
  let m2' = transpose_matrix m2 in
  List.map (fun row -> List.map (dot_row_vectors row) m2') m1
