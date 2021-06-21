;;; 2: Lather, Rinse, and Repeat: A Tour of the REPL

;;; SLIME shortcuts:
;;; cheat sheet: http://www.neil.dantam.name/extra/slime-refcard.pdf
;;; - C-c C-c	compile defun
;;; - C-c C-k	compile and load file
;;; - C-c C-z	switch to output buffer
;;; - C-c C-l	load file
;;; - C-M-x	eval defun
;;; - C-c M-d	disassemble definition

(defun hello-world ()
  (format t "Hello, world!"))

;;; compiling and fast loading a file
;;; (load (compile-file "2.lisp"))
