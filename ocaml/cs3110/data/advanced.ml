(* advanced data types: section 3.2 *)

(* option types; also using `begin ... end` instead of parens
 * to delimit a long expression (note we don't need many parens at all)
 * *)
let rec list_max = function
  | [] -> None
  | h::t -> Some begin
      match list_max t with
      | Some x -> max h x
      | _ -> h
    end

(* association lists *)
let d = [ ("rectangle",4)
        ; ("triangle",3)
        ; ("dodecagon",12)
        ]

let insert k v d = (k,v)::d
let rec lookup k = function
  (* this is the same as `List.assoc` *)
  | [] -> None
  | (k',v)::t -> if k=k' then Some v else lookup k t

(* type synonyms *)
type point = float * float
type vector = float list
type matrix = float list list

let getx ((x,_) : point) : float = x

(* doesn't matter how we annotate the values, the two
 * types are exactly equivalent
 * *)
let _ = getx (1.,2. : point)
let _ = getx (1.,2. : float * float)

(* algebraic data types *)
type shape =
  | Point of point
  | Circle of point * float     (* center and radius *)
  | Rect of point * point       (* lower-left and upper-right corners *)

let pi = 3.14159265358979323846264
let area = function
  | Point _ -> 0.
  | Circle (_,r) -> pi *. (r ** 2.0)
  | Rect ((x1,y1),(x2,y2)) ->
    let w = x2 -. x1 in
    let h = y2 -. y1 in
    w *. h

let center = function
  | Point p -> p
  | Circle (p,_) -> p
  | Rect ((x1,y1),(x2,y2)) ->
    ((x2 +. x1) /. 2., (y2 +. y1) /. 2.)

(* variant types are sometimes called tagged unions;
 * - "algebra" refers to the fact that variant types contani both
 *   sum and product types
 * - "sum" types come from the fact that a value of a variant is formed
 *   by one of the constructors
 * - "product" types come from the fact that at a constructor can carry
 *   tuples or records, whose values have a sub-value from each of their
 *   component types
 *
 * as we've seen, variant types can either contain no data ("constant") or
 * contain data using the `of` clause ("non-constant"). These are reflected
 * in their constructors and pattern matching as well
 *
 * note that both type synonyms (existing types) and algebraic types
 * (new types) are declared using the `type` keyword, whereas they are
 * declared differently in Haskell (`data` vs `type`)
 * *)

(* avoid catch-all clauses with variant types: these will be problematic
 * if you add new sum types to the variant type
 * *)

(* recursive variants *)
type intlist =
  | Nil
  | Cons of int * intlist

let lst3 = Cons (3, Nil)
let list123 = Cons (1, Cons (2, Cons (3, Nil)))

(* mutual recursion *)
type node = { value: int
            ; next: mylist }
and mylist = Nil | Node of node

(* illegal: recursion must "go through" at least one record or variant type
 * basically: need tagging for recursion to work *)
(* type t = u and u = t *)
(* type t = t * t *)
type t = U of u and u = T of t  (* OK *)
type node = { value: int        (* OK; note this cannot be instantiated *)
            ; next: node
            }

(* parameterized variants; now `myList` is not a type but a type constructor *)
type 'a myList = Nil | Cons of 'a * 'a myList

(* type annotations here are optional: we have parametric polymorphism *)
let rec length : 'a myList -> int = function
  | Nil -> 0
  | Cons (_,t) -> 1 + length t

let empty : 'a myList -> bool = function
  | Nil -> true
  | Cons _ -> false

(* multiple type parameters: parens are needed *)
type ('a,'b) pair = { first: 'a
                    ; second: 'b
                    }
let x = { first = 2; second = "hello"; }

(* "polymorphic variants" (anonymous variants?) can be used when one-off
 * variant types are needed, e.g., only used in a single function.
 *
 * the text says that their use is discouraged for now until we revisit them,
 * since their types may be difficult to manage *)
let f = function
  | 0 -> `Infinity
  | 1 -> `Finite 1
  | n -> `Finite (-n)

(* if you look at the type of `f`, it has type:
 * `int -> [> `Finite of int | `Infinity ]`; square brackets indicate
 * a set of possible constructors, `>` indicates that a pattern matching
 * must be able to at least handle the stated constructors (and possibly
 * more) *)
let _ = match f 3 with
  | `NegInfinity -> "negative infinity"
  | `Finite n -> "finite"
  | `Infinity -> "infinity"

(* declaring new exceptions syntax: `exception E of t` (`of t` is
 * optional, similar to variant)
 *
 * `raise e` to raise an exception. The `Failure s of string` variant
 * type is predefined in the stdlib. The convenience function
 * `failwith s` is equivalent to `raise (Failure s)` *)
exception MyException

let _ =
  try failwith "ERRORRRRRR" with
  | Failure s -> "exception raised: " ^ s
  | MyException -> "my exception hit"

(* all exceptions are of type `exn`, which is an "extensible variant",
 * which allows new constructors of the variant to be defined after
 * the variant type itself is defined *)

(* dynamic semantics of exceptions:
 * each OCaml expression either:
 * - evaluates to a value (already dealt with this)
 * - raises an exception (now we talk about this)
 * - fails to terminate
 *
 * when an exception is thrown, it is not a traditional OCaml expression;
 * it is only handled by the `try` and `raise` expressions and may contain
 * extra information in the "exception packet" (e.g., a stack trace)
 *
 * if there are multiple expressions without a well-defined execution
 * order (e.g., values in the same tuple), then which exception is raised
 * is UB. This is not true for function applications or `let` expressions,
 * since the evaluation order is well-defined; note that for functions
 * with multiple arguments, the argument evaluation order is well-defined
 * to be right-to-left, and all arguments are evaluated before the function
 * expression is evaluated: see example below *)
exception A
exception B

let f a b = ""
let _ =
  try f (raise A) (raise B) with
  | A -> "caught A"
  | B -> "caught B"

(* ignore the warning, this still runs as expected *)
let _ =
  try (raise A) (raise B) with
  | A -> "caught A"
  | B -> "caught B"

(* interesting example: raising an exception inside another exception:
 * since the `raise` syntax doesn't catch exceptions, the inner exception
 * will be evaluated first and bubble up to the `try` block: see the
 * following illustration
 * *)
exception C of int
exception D
let _ =
  try raise (C (raise D)) with
  | C _ -> "caught C"
  | D -> "caught D"

(* pattern matching for expressions: since `match` expressions can't
 * really catch exceptions, there is syntactic sugar that wraps the
 * body of the match with a try *)
let _ =
  match List.hd [] with
  | [] -> "empty"
  | h::t -> "nonempty"
  | exception (Failure s) -> s

(* OUnit can test for exceptions using the `assert_raises exc thunk`
 * function*)
