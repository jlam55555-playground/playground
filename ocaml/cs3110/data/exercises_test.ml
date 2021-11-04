open OUnit2
open Exercises

(* the setup for these test cases and compilation is very tedious w/o
 * dune, so I will use dune for building most things from now on *)

let tests_product_test = "product test" >::: [
    "1..10" >:: (fun _ -> assert_equal (prod (1--10)) 3628800)
  ; "empty list" >:: (fun _ -> assert_equal (prod []) 1)
  ]

let tests_library_test = "library test" >::: [
    "get_fifth" >::: [
      "1..10" >:: (fun _ -> assert_equal (get_fifth (1--10)) 5)
    ; "shorter than 5" >:: (fun _ -> assert_equal (get_fifth [1]) 0)
    ]
  ; "sort_desc_list" >::: [
      "[1;5;2;3;4;-2]" >:: (fun _ -> assert_equal
                               (sort_desc_list [1;5;2;3;4;-2])
                               [-2;1;2;3;4;5])
    ]
  ]

let tests_max_exn_ounit = "max exn ounit" >::: [
    "list_max []" >::
    (fun _ -> assert_raises (Failure "list_max") (fun _ -> list_max []))
  ; "list_max [1;5;2;3;4;-2]" >::
    (fun _ -> assert_equal (list_max [1;5;2;3;4;-2]) 5)
  ]

let tests = "cs3110 ch3" >::: [
    tests_product_test
  ; tests_library_test
  ; tests_max_exn_ounit  
  ]

let _ = run_test_tt_main tests
