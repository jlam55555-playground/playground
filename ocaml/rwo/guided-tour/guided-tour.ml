(* https://dev.realworldocaml.org/guided-tour.html *)

open Base ;;

(* basic expressions *)
3 + 4 ;;
8 / 3 ;;
3.5 +. 6. ;;
30_000_000 / 300_000 ;;
3 * 5 > 14 ;;

(* basic variables *)
let x = 3 + 4 ;;
let y = x + x ;;
let x7 = 3 + 4 ;;
let x_plus_y = x + y ;;
let x' = x + 1 ;;

(* functions and type inference *)
let square x = x * x ;;
square (square 2) ;;

let ratio x y = Float.of_int x /. Float.of_int y ;;
let ratio x y =
  let open Float.O in
  of_int x / of_int y
;;
ratio 4 7 ;;

let sum_if_true test first second =
  (if test first then first else 0)
  + (if test second then second else 0)
;;
let even x = x % 2 = 0 ;;
sum_if_true even 3 4 ;;
sum_if_true even 2 4 ;;

(* type inference and annotations *)
let sum_if_true (test : int -> bool) (first : int) (second : int) : int =
  (if test first then first else 0)
  + (if test second then second else 0)
;;

(* inferring generic types *)
let first_if_true test x y =
  if test x then x else y
;;

(* tuples, lists, and pattern matching *)
let a_tuple = (3, "three") ;;
let (x, y) = a_tuple ;;

let distance (x1, y1) (x2, y2) =
  Float.sqrt ((x1 -. x2) **. 2. +. (y1 -. y2) **. 2.)
;;
distance (0., 0.) (3., 4.) ;;

let languages = ["OCaml" ; "Perl" ; "C"] ;;

(* list of different types won't compile *)
(* let numbers = [3; "four"; 5] ;; *)

List.length languages ;;

(* labeled arguments *)
List.map languages ~f:String.length ;;
List.map ~f:String.length languages ;;

(* cons/car/cdr *)
"French" :: "Spanish" :: languages ;;

(* commas are used for tuples *)
["OCaml", "Perl", "C"] ;;
"OCaml", "Perl", "C" ;;

(* concatenation *)
[1; 2; 3] @ [4; 5; 6] ;;

(* match *)
let get_first lst =
  match lst with
  | x :: xs -> x
  | [] -> -1
;;
get_first [2;3;4] ;;

(* recursive functions *)
let rec sum l =
  match l with
  | [] -> 0
  | hd :: tl -> hd + sum tl
;;
sum [1;2;3] ;;

let rec rsd l =
  (* remove sequential duplicates *)
  match l with
  | [] -> []
  | [x] -> [x]
  | x1 :: x2 :: xs ->
    let new_xs = rsd (x2 :: xs) in
    if x1 = x2 then new_xs else x1 :: new_xs
;;
rsd [1;1;2;3;3;4;4;1;1;1] ;;

let x = 7 in
let y = x * x in
x + y
;; 

(* options *)
let divide x y =
  if y = 0 then None else Some (x / y)
;;
divide 3 4 ;;
divide 5 0 ;;

let dce fn =
  (* downcase extension of filename *)
  match String.rsplit2 fn ~on:'.' with
  | None -> fn
  | Some (base, ext) -> base ^ "." ^ String.lowercase ext
;;
List.map ~f:dce [ "Hello_World.TXT"; "Hello_World.txt"; "Hello_World" ] ;;

(* records and variants *)
type point2d = { x : float; y : float } ;;
let p = { x = 3.; y = -4. } ;;

(* pattern matching w/ field punning *)
let magnitude { x; y } = Float.sqrt (x **. 2. +. y **. 2.) ;;
let distance { x = x1; y = y1 } { x = x2; y = y2 } =
  magnitude { x = (x2 -. x1); y = (y2 -. y1) } ;;

magnitude p ;;

type circle_desc = { center: point2d; radius: float } ;;
type rect_desc = { lower_left: point2d; width: float; height: float } ;;
type segment_desc = { endpoint1: point2d; endpoint2: point2d } ;;

type scene_element =
  | Circle of circle_desc
  | Rect of rect_desc
  | Segment of segment_desc
;;

let is_inside_scene_element point scene_element =
  let open Float.O in
  match scene_element with
  | Circle { center; radius } -> distance center point < radius
  | Rect { lower_left; width; height } ->
    point.x > lower_left.x && point.x < lower_left.x + width
    && point.y > lower_left.y && point.y < lower_left.y + height
  | Segment _ -> false
;;

(* anonymous function! *)
let is_inside_scene point scene =
  List.exists scene ~f:(fun el -> is_inside_scene_element point el)
;;

is_inside_scene { x = 3.; y = 7. }
  [ Circle {center = {x=4.;y=4.}; radius = 0.5} ] ;;
is_inside_scene { x = 3.; y = 7. }
  [ Circle {center = {x=4.;y=4.}; radius = 5.} ] ;;

(* arrays *)
let numbers = [| 1; 2; 3; 4 |] ;;
numbers.(2) <- 4 ;;
numbers ;;

(* mutable record fields *)
type running_sum = {
  mutable sum: float;
  mutable sum_sq: float;
  mutable samples: int;
} ;;
(* haskell indentation style? *)
(* type running_sum =
 *   { mutable sum: float
 *   ; mutable sum_sq: float
 *   ; mutable samples: int
 *   } ;; *)

let mean rsum = rsum.sum /. Float.of_int rsum.samples ;;
let stdev rsum =
  Float.sqrt (rsum.sum_sq /. Float.of_int rsum.samples
              -. (rsum.sum /. Float.of_int rsum.samples) **. 2.) ;;

(* wow: function with unit parameter type looks like ordinary fncall *)
let create_rsum () = { sum = 0.; sum_sq = 0.; samples = 0; } ;;
let update_rsum rsum x =
  rsum.samples <- rsum.samples + 1;
  rsum.sum <- rsum.sum +. x;
  rsum.sum_sq <- rsum.sum_sq +. x *. x;
;;

let rsum = create_rsum () ;;
List.iter [1.;3.;2.;-7.;4.;5.] ~f:(fun x -> update_rsum rsum x) ;;
mean rsum ;;
stdev rsum ;;

(* refs: single mutable values *)
(* refs are records with a single mutable field called `contents` *)
let x = { contents = 0 } ;;
x.contents <- x.contents + 1 ;;
x ;;

(* convenience notations for `ref` *)
let x = ref 0 ;;
!x ;;
x := !x + 1 ;;
!x ;;

(* redefining these operators for `ref` *)
type 'a my_ref = { mutable my_contents: 'a } ;;
let my_ref x = { my_contents = x } ;;

(* operator naming rules are complex;
 * see: https://ocaml.org/manual/lex.html#sss:lex-ops-symbols
 * and: https://stackoverflow.com/a/6150853/2397327*)
let (!~) r = r.my_contents ;;
let (@~) r x = r.my_contents <- x ;;

let x = my_ref 0 ;;
!~x ;;
x @~ !~x + 1 ;;
!~x ;;

(* `ref`s are used to simulate the traditional variables in other languages *)
let sum list =
  let sum = ref 0 in
  List.iter list ~f:(fun x -> sum := !sum + x);
  !sum
;;
sum [1;2;3] ;;

(* for and while loops *)
let permute array =
  let length = Array.length array in
  for i = 0 to length - 2 do
    (* pick a j to swap with *)
    let j = i + Random.int (length - i) in
    (* swap i and j *)
    let tmp = array.(i) in
    array.(i) <- array.(j);
    array.(j) <- tmp
  done
;;

let ar = Array.init 20 ~f:(fun i -> i) ;;
permute ar ;;
ar ;;

let find_first_negative_entry array =
  let pos = ref 0 in
  while !pos < Array.length array && array.(!pos) >= 0 do
    pos := !pos + 1
  done;
  if !pos = Array.length array then None else Some !pos
;;
find_first_negative_entry [|1;2;0;3|] ;;
find_first_negative_entry [|1;-2;0;3|] ;;
