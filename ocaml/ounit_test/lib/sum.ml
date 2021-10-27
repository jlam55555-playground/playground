module Meh = Meh

let rec sum = function
  | [] -> 0
  | x::xs -> x + sum xs
