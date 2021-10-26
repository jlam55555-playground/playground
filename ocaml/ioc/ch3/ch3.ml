let rec power i x =
  if i = 0 then
    1.0
  else
    x *. (power (i-1) x)

let dx = 1e-10
let deriv f x = (f (x +. dx) -. f x) /. dx

let f = power 3
let f' = deriv f
let f'' = deriv f'              (* numerical errors *)

(* rules of thumb for labeled and optional arguments:
 * - an optional parameter should always be followed by a non-optional
 *   parameter (usually labeled)
 * - the order of labeled arguments does not matter, except when
 *   a label occurs more than once
 * - labeled and optional arguments should be specified explicitly
 *   for higher-order functions
 *
 * regarding the secong bullet point: you can have the same label
 * more than once, see example below
 * *)
let g ~x ~x:y = x + y
