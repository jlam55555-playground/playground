(* values *)
let _ : int = (7 * (1 + 2 + 3)) ;;
let _ : string = "CS " ^ Int.to_string 3110 ;;

(* operators *)
42 * 10 ;;
3.14 /. 2.0 ;;
let rec pow x n = if n = 0 then 1. else x *. pow x (n - 1) in
pow 4.2 7 ;;

(* equality *)
42 = 42 ;;
"hi" = "hi" ;;                  (* true, because equal value *)
"hi" == "hi" ;;                 (* false, because different references *)

(* assert *)
assert true ;;
(* assert false ;; *)           (* intentional assertion failure *)
assert (2110 != 3110) ;;

(* if *)
if 2 > 1 then 42 else 7 ;;

(* double fun *)
let double x = x * 2 in
assert (double 7 = 14) ;
assert (double 10 = 20) ;
assert (double 42 = 84) ;;

(* more fun *)
(* helper function for later *)
let assert_threshold x y =
  let threshold = 1e-6 in
  assert (Float.abs(x -. y) < threshold) ;;

let cube x = x *. x *. x in
assert_threshold (cube 10.) 1000. ;
assert_threshold (cube 3.14) 30.959144 ;;

let sgn x =
  if x = 0 then 0
  else if x < 0 then -1
  else 1 in
assert (sgn (-2) = -1) ;
assert (sgn 0 = 0) ;
assert (sgn 42123123 = 1) ;;

let circle_area rad = 3.14 *. rad *. rad in
assert_threshold (circle_area 1.) 3.14 ;
assert_threshold (circle_area 4.) 50.24 ;;

(* RMS *)
let rms x y = Float.sqrt ((x *. x +. y *. y) /. 2.) in
assert_threshold (rms 3. 4.) 3.5355339059 ;
assert_threshold (rms (-4.5) 42.3) 30.07939494 ;;

(* date fun *)
let valid_date d m =
  let days n = d >= 0 && d <= n in
  match m with
  | "Jan" | "Mar" | "May" | "July" | "Aug" | "Oct" | "Dec" -> days 31
  | "Feb" -> days 28
  | "Apr" | "Jun" | "Sept" | "Nov" -> days 30
  | _ -> false in
assert (not (valid_date 32 "Jan")) ;
assert (valid_date 31 "Jan") ;
assert (valid_date 4 "Sept") ;;

(* editor tutorial; master and editor *)
(* already deep in the editor wars :/ *)

(* fib (slow) *)
let rec fib n =
  if n < 3
  then 1
  else fib (n-1) + fib(n-2) in
assert (List.map fib [1;2;3;4;5;6;7;8;9;10]
        = [1;1;2;3;5;8;13;21;34;55]) ;;

(* fib (fast) *)
let rec fib n =
  let rec h n pp p = if n = 1 then p else h (n-1) p (pp+p) in
  h n 0 1 in
assert (List.map fib [1;2;3;4;5;6;7;8;9;10]
        = [1;1;2;3;5;8;13;21;34;55]) ;

(* get first negative fib argument *)
let rec find_first_neg f n =
  if f n < 0 then n else find_first_neg f (n+1) in
"fib(" ^ Int.to_string (find_first_neg fib 1) ^ ") < 0" ;;

(* poly types *)
let f (x : bool) : bool = if x then x else x
let g (x : 'a) (y : bool) : 'a = if y then x else x
let h (x : bool) (y : 'a) (z : 'a) : 'a = if x then y else z
let i (x : bool) (y : 'a) (z : 'b) : 'a = if x then y else y
;;

(* divide *)
let divide numerator denominator = numerator /. denominator in
assert_threshold (divide 4.6 2.) 2.3 ;
assert_threshold (divide 5. 3.) 1.6666666667 ;;

(* associativity *)
let add x y = x + y in
ignore (add 5 1) ;              (* fine, total application *)
ignore (add 5) ;                (* fine, partial application *)
ignore ((add 5) 1) ;            (* fine, curried fn *)
(* ignore (add (5 1)) ; *)      (* not ok, `5` is not a fn *)
;;

(* average *)
let ( +/. ) x y = (x +. y) /. 2. in
assert_threshold (1.0 +/. 2.0) 1.5 ;
assert_threshold (0. +/. 0.) 0. ;

(* hello world *)
print_endline "Hello world!" ;;
print_string "Hello world!" ;;
