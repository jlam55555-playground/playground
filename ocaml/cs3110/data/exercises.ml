open OUnit2

let ( << ) f g x =
  (* helper function for composition: https://stackoverflow.com/a/19214968/ *)
  f (g x)

(* --------------- *)

(* list expressions *)
let l1 = [1;2;3;4;5]
let l2 = 1::2::3::4::5::[]
let l3 = [1] @ [2;3;4] @ [5]

(* product *)
let rec prod = function
  | [] -> 1
  | x::xs -> x * prod xs

(* concat *)
let rec concat = function
  | [] -> ""
  | x::xs -> x ^ concat xs

(* product test: see exercises_test.ml *)

(* patterns *)
let first_bigred = function
  | "bigred"::_ -> true
  | _ -> false

let two_or_four_list = function
  | _::_::_::_::[] | _::_::[] -> true
  | _ -> false

let first_two_equal = function
  | [] | _::[] -> failwith "first_two_equal requires >1 elements"
  | x::y::_ -> x = y

(* library *)
let get_fifth lst =
  if List.length lst < 5
  then 0
  else List.nth lst 5

let sort_desc_list lst = (List.rev << List.sort Stdlib.compare) lst

(* library test: see exercises_test.ml *)

(* library puzzle *)
let last_elem lst = (List.hd << List.rev) lst

(* take drop *)
let rec take n = function
  | [] -> []
  | _ when n<=0 -> []
  | x::xs -> x :: take (n-1) xs

let rec drop n = function
  | [] -> []
  | lst when n<=0 -> lst
  | x::xs -> drop (n-1) xs

(* take drop tail *)
let take_tr n lst =
  let rec iter n acc = function
    | [] -> acc
    | _ when n<=0 -> acc
    | x::xs -> iter (n-1) (x::acc) xs
  in iter n [] lst |> List.rev

let drop_tr =
  (* drop is already tail recursive *)
  drop

(* returns:  [from i j l] is the list containing the integers from
 *   [i] to [j], inclusive, followed by the list [l].
 * example:  [from 1 3 [0] = [1;2;3;0]] *)
let rec from i j l =
  if i > j then l
  else from i (j - 1) (j :: l)

(* returns:  [i -- j] is the list containing the integers from
 *   [i] to [j], inclusive. *) 
let (--) i j = from i j []

let longlist = 0 -- 1_000_000

(* the following don't crash the stack; regular
 * take does *)
let _ = take_tr 1_000_000 longlist
let _ = drop_tr 1_000_000 longlist

(* unimodal *)
let rec is_monotonic inc = function
  (* determines if a function is monotonically inc/dec *)
  | [] | [_] -> true
  | x1::x2::xs ->
    (if inc then (<=) else (>=)) x1 x2 && is_monotonic inc (x2::xs)

let rec is_unimodal = function
  | [] | [_] -> true
  | x1::x2::xs as lst ->
    x1<=x2 && is_unimodal (x2::xs) || is_monotonic false lst

(* powerset *)
let rec powerset = function
  | [] -> [[]]
  | x::xs ->
    powerset xs |> List.map (fun lst -> [lst;x::lst]) |> List.flatten

(* print int list rec *)
let rec print_int_list = function 
  | [] -> () 
  | h::t ->
    h |> string_of_int |> print_endline; 
    print_int_list t

(* print int list iter *)
let print_int_list' = print_endline << string_of_int |> List.iter

(* student *)
type student = { first_name: string
               ; last_name: string
               ; gpa: float
               }

let some_student = { first_name="Jon"; last_name="Lam"; gpa=5.9 }
let get_first_name { first_name } = first_name
let create_student first_name last_name gpa = { first_name; last_name; gpa }

(* pokerecord *)
type poketype = Normal | Fire | Water
type pokemon = { name: string
               ; hp: int
               ; ptype: poketype
               }

let charizard = { name="charizard"; hp=78; ptype=Fire }
let squirtle = { name="squirtle"; hp=44; ptype=Water }

(* safe hd and tl *)
let safe_hd = function
  | [] -> None
  | x::_ -> Some x

let rec safe_tl = function
  | [] -> None
  | x::[] -> Some x
  | _::xs -> safe_tl xs

(* pokefun *)
let max_hp lst =
  let max_hp' = List.fold_left (fun acc {hp} -> max hp acc) 0 lst in
  let rec iter = function
    | [] -> None
    | ({hp} as x)::xs -> if hp=max_hp' then Some x else iter xs
  in iter lst

(* date before *)
type date_like = int * int * int

let date_1 = 2013,2,1
let date_2 = 2021,10,27

let is_before (y1,m1,d1) (y2,m2,d2) =
  (* assumes valid date tuples *)
  y1 < y2 || m1 < m2 || d1 < d2

(* earliest date *)
let earliest =
  List.fold_left
    (fun date acc -> if is_before date acc then date else acc)
    (9999,12,31)

(* assoc list *)
let insert k v alst = (k,v) :: alst
let rec lookup k = function
  | [] -> None
  | (k',v)::xs -> if k'=k then Some v else lookup k xs

let alst = []
let alst = insert 1 "one" alst
let alst = insert 2 "two" alst
let alst = insert 3 "three" alst

let lookup2 = lookup 2 alst
let lookup4 = lookup 4 alst

(* cards *)
type suit =
  | Clubs
  | Diamonds
  | Hearts
  | Spades
type rank = int
type card = { suit: suit
            ; rank: rank
            }

let ace_of_spades = { rank=1; suit=Clubs }
let queen_of_hearts = { rank=12; suit=Hearts }
let two_of_diamonds = { rank=2; suit=Diamonds }
let seven_of_spades = { rank=7; suit=Spades }

(* matching
 * (Some x) :: tl --- [None]
 * [Some 3110; None] -- [None]
 * [Some x; _] -- [None]
 * h1::h2::tl -- [None]
 * h::tl -- irrefutable, every non-empty list is of this form *)

(* quadrant *)
type quad = I | II | III | IV
type sign = Neg | Zero | Pos

let sign = function
  | 0 -> Zero
  | n when n > 0 -> Pos
  | _ -> Neg

let quadrant (x,y) =
  match sign x, sign y with
  | Zero,_ | _,Zero -> None
  | Pos,Pos -> Some I
  | Neg,Pos -> Some II
  | Neg,Neg -> Some III
  | Pos,Neg -> Some IV

(* depth *)
type 'a tree = Leaf | Tree of 'a * 'a tree * 'a tree

let rec depth = function
  | Leaf -> 0
  | Tree (_,t1,t2) -> 1 + max (depth t1) (depth t2)

let t =
  Tree (4,
        Tree (2,
              Tree (1,Leaf,Leaf),
              Tree (3,Leaf,Leaf)),
        Tree (6,
              Tree (5,Leaf,Leaf),
              Tree (7,Leaf,Leaf)))

(* shape *)
let rec same_shape t1 = function
  | Leaf -> t1=Leaf
  | Tree (_,t21,t22) -> match t1 with
    | Leaf -> false
    | Tree (_,t11,t12) -> same_shape t11 t21 && same_shape t12 t22

(* list max exn *)
let list_max = function
  | [] -> failwith "list_max"
  | lst -> List.fold_left max 0 lst

(* list max exn string *)
let list_max_string = function
  | [] -> "empty"
  | lst -> List.fold_left max 0 lst |> string_of_int

(* list max exn ounit: see exercises_test.ml *)

(* is_bst *)
let is_bst t =
  let rec is_bst_rec = function
    | Leaf -> `Empty
    | Tree (v,t1,t2) -> match is_bst_rec t1,is_bst_rec t2 with
      | `NoInvariant,_ | _,`NoInvariant -> `NoInvariant
      | `Empty,`Empty -> `Invariant (v,v)    
      | `Empty,`Invariant (t2min,t2max) ->
        if v<t2min then `Invariant (v,t2max) else `NoInvariant
      | `Invariant (t1min,t1max),`Empty ->
        if v>t1max then `Invariant (t1min,v) else `NoInvariant
      | `Invariant (t1min,t1max),`Invariant (t2min,t2max) ->
        if v>t1max && t2min>v then `Invariant (t1min,t2max) else `NoInvariant
  in match is_bst_rec t with
  | `Invariant _ -> true
  | _ -> false

(* quadrant poly *)
let sign' = function
  | 0 -> `Zero
  | n when n > 0 -> `Pos
  | _ -> `Neg

let quadrant' (x,y) =
  match sign' x, sign' y with
  | `Zero,_ | _,`Zero -> None
  | `Pos,`Pos -> Some `I
  | `Neg,`Pos -> Some `II
  | `Neg,`Neg -> Some `III
  | `Pos,`Neg -> Some `IV
