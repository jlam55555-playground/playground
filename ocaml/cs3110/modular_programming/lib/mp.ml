(* ocaml module system is based on structures and signatures;
 * structures are the module definitions, and signatures
 * are module types *)

(* module implementation can contain `type` definitions,
 * `exception` definitions, `let` definitions, `open` statements,
 * and some others we haven't seen yet *)

(* bring module names into scope with the `open` statement
 * or by explicitly using the module name and the dot notation;
 * note that `Stdlib` is automatically `open`ed by every struct *)

(* as always, later names shadow earlier ones, even if there are
 * multiple names from different `open`ed modules. Therefore, it
 * is good practice not to `open` all modules. Some alternative
 * syntaxes: *)
let f x =
  let open List in
  let y = filter ((>) 0) x in
  y

let s = String.(" BigRed  " |> trim |> lowercase_ascii)

(* syntax for defining a module type;
 * the signature is unnamed until we bind it to a
 * module type *)
module type Stack = sig
  type 'a stack
  val empty : 'a stack
  val is_empty : 'a stack -> bool
  val push : 'a -> 'a stack -> 'a stack
  val peek : 'a stack -> 'a
  val pop : 'a stack -> 'a stack
  val format : (Format.formatter -> 'a -> unit) -> Format.formatter -> 'a stack -> unit
end

(* a structure "matches" a signature if the structure
 * provides definitions for all the names specified
 * in the definition (and possibly more); note that the
 * definitions can be more general than in the signature *)
module type Sig = sig
  val f : int -> int
end

module M1 : Sig = struct
  let f x = x+1
end

module M2 : Sig = struct
  let f x = x
end

(* making our ListStack match Stack *)
module ListStack : Stack = struct
  (* this is called a "representation type" -- a type
   * that is used to represent a version of a data structure *)
  type 'a stack = 'a list

  let empty = []
  let is_empty s = s = []

  let push x s = x :: s
  let peek = function
    | [] -> failwith "Empty"
    | x::_ -> x

  let pop = function
    | [] -> failwith "Empty"
    | _::xs -> xs

  let format fmt_elt fmt s =
    Format.fprintf fmt "[";
    List.iter (fun elt -> Format.fprintf fmt "%a; " fmt_elt elt) s;
    Format.fprintf fmt "]";
end

(* outside of the module, no one is allowed to know
 * what the implementation type of the abstract type is *)

(* only declarations in the signature are accessible outside
 * of the module; elements that are defined in the structure
 * but not declared in the signature are called "sealed"
 * by the signature *)

module MyStack : Stack = struct
  type 'a stack =
    | Empty
    | Entry of 'a * 'a stack

  let empty = Empty
  let is_empty s = s = Empty
  let push x s = Entry (x, s)
  let peek = function
    | Empty -> failwith "Empty"
    | Entry (x,_) -> x
  let pop = function
    | Empty -> failwith "Empty"
    | Entry (_,s) -> s

  let format fmt_elt fmt s =
    Format.fprintf fmt "[";
    let rec recurse = function
      | Empty -> ()
      | Entry (x,xs) -> Format.fprintf fmt "%a; " fmt_elt x; recurse xs
    in recurse s;
    Format.fprintf fmt "]";
end

(* functional data structures are ones that don't make use
 * of any imperative features; they have structural sharing and
 * typically return the new value (rather than unit) *)

(* two-list queue ... ??? not sure how this works *)

(* cool example: field implementation *)

(* sharing constraints allow you to expose a type defined
 * in a signature.
 *
 * We don't have to specify the sharing constraint in the original
 * definition of the module. We can create a structure, bind it to
 * a module name, then bind it to another module name with its
 * types being either abstract or exposed *)

(* a "compilation unit" is a pair of OCaml source files in the
 * same directory with the same base name and one "*.ml" and one
 * "*.mli" (implementation and interface); compiling it will
 * have the same effect as defining the struct and signature
 *
 * Note that interface and implementation file comments have different
 * target users: the former for maintainers, the latter for
 * users of the module *)

(* we can use the `includes` statement in a module to include
 * all the values defined by another structure (or analogously
 * for signatures) *)

(* functors are functions (-ish) from modules to modules
 *
 * they are not ordinary functions because modules are not first-
 * class in OCaml, i.e., the language is "stratified".
 *
 * we can also think of these as parameterized structures
 * 
 * example: *)
module type X = sig
  val x : int
end

module IncX (M: X) = struct
  let x = M.x + 1
end

module A = struct let x = 0 end
module B = IncX (A)
module C = IncX (B)

(* why "functor": analogy between the idea of categories
 * (which contain morphisms) and structures (which contain
 * functions); mapping between categories is known as
 * a functor *)

(* alternative syntax for functors *)
module IncX2 = functor (M: X) -> struct
  let x = M.x + 1
end

(* a higher-order functor is analogous to higher-order
 * functions: *)
module IncX3 (M1: X) (M2: X) = struct
  let x = M1.x + M2.x
end

module IncX4 = functor (M1: X) (M2: X) -> struct
  let x = M1.x + M2.x
end

module IncX5 = functor (M1: X) -> functor (M2: X) -> struct
  let x = M1.x + M2.x
end

(* functors can be used to create a test suite for
 * multiple structures *)

(* anonymous structures can be passed into functors *)
