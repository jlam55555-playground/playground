open OUnit2
open Hop.Exercises

let invalid_mat_1 = []
let invalid_mat_2 = [[]]
let invalid_mat_3 = [[3;4];[4]]

let a = [[1;2;3];[4;5;6]]
let b = [[7;8];[9;10];[11;12]]
let c = [[1; 2];[3;4];[5;6]]
let d = [[1];[2]]

let tests = "hw3" >::: [
    "is_valid_matrix" >::: [
      "[]" >::
      (fun _ -> assert_equal (is_valid_matrix invalid_mat_1) false) ;

      "[[]]" >::
      (fun _ -> assert_equal (is_valid_matrix invalid_mat_2) false) ;

      "[3,4;4]" >::
      (fun _ -> assert_equal (is_valid_matrix invalid_mat_3) false) ;

      "[[1;2;3];[4;5;6]]" >::
      (fun _ -> assert_equal (is_valid_matrix a) true) ;

      "[[7;8];[9;10];[11;12]]" >::
      (fun _ -> assert_equal (is_valid_matrix b) true) ;

      "[[1; 2];[3;4];[5;6]]" >::
      (fun _ -> assert_equal (is_valid_matrix c) true) ;

      "[[1];[2]]" >::
      (fun _ -> assert_equal (is_valid_matrix d) true) ;
    ] ;

    "row_vector_add" >::: [
      "[1;2;3] + [4;5;6]" >:: (fun _ -> assert_equal (add_row_vectors [1;2;3] [4;5;6]) [5;7;9])
    ] ;

    (* i got tired of doing more unit tests *)    
  ]

let _ = run_test_tt_main tests
