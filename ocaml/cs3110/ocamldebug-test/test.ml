(* testing whether the debugger can undo side effects like
 * assigning to a ref; is it really a mutable reference?
 * It seems that ocamldebug does successfully undo the
 * mutable assignment, so I'm not sure how this works unless
 * it stores the history *)
let setx x = x := 3 in
let x = ref 0 in
setx x;
print_int !x
