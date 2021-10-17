let rec gcd a b =
  (* elegant! euclidean algorithm *)
  let r = a mod b in
  if r = 0 then b else gcd b r

(* features of ML and OCaml:
 * 
 * ML:
 * - functional
 * - strongly typed
 * - uses type inference
 * - polymorphic type system
 * - pattern matching
 * - module system (w/ functors?!)
 * - formal semantics
 *
 * OCaml:
 * - Object system
 * - Separate compilation (both byte-code and native code)
*)
