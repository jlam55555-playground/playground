type disjunctive =
  | DBool of bool
  | DVar of string
  | DAnd of disjunctive * disjunctive

type conjunctive =
  | CBool of bool
  | CDisj of disjunctive
  | COr of conjunctive * conjunctive

(* TODO: page 75 *)
(* let dpll = function
 *   | CBool b -> b
 *   | CDisj exp -> match exp with
 *     | DBool b -> b
 *     | 
 *   | COr (exp1,exp2) ->  *)
