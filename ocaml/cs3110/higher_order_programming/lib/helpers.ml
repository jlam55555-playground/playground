(* helpers for hop.ml *)

let ( -- ) a b =
  (* tail-recursive range generator *)
  let rec helper acc a b =
    if a > b then acc else helper (b::acc) a (b-1)
  in helper [] a b

let sum = List.fold_left (+) 0
