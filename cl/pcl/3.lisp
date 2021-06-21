;;; 3. Practical: A simple database

;;; list
(list 1 2 3)

;;; plist (property list)
(list :a 1 :b 2 :c 3)
(getf (list :a 1 :b 2 :c 3) :a)
(getf (list :a 1 :b 2 :c 3) :c)

(defun make-cd (title artist rating ripped)
  (list :title title :artist artist :rating rating :ripped ripped))

(make-cd "Roses" "Kathy Mattea" 7 t)

;;; *var* convention for globals
(defvar *db* nil)

(defun add-record (cd)
  (push cd *db*))

(add-record (make-cd "Roses" "Kathy Mattea" 7 t))
(add-record (make-cd "Fly" "Dixie Chicks" 8 t))
(add-record (make-cd "Home" "Dixie Chicks" 7 t))

(defun dump-db ()
  (dolist (cd *db*)
    (format t "~{~a:~10t~a~%~}~%" cd)))

;;; equivalent definition to the above
;; (defun dump-db ()
;;   (format t "~{~{~a:~10t~a~%~}~%~}" *db*))

(defun prompt-read (prompt)
  (format *query-io* "~a: " prompt)
  (force-output *query-io*)
  (read-line *query-io*))

(defun prompt-for-cd ()
  (make-cd
   (prompt-read "Title")
   (prompt-read "Artist")
   (or (parse-integer (prompt-read "Rating") :junk-allowed t) 0)
   (y-or-n-p "Ripped [y/n]: ")))

(defun add-cds ()
  (loop (add-record (prompt-for-cd))
	(if (not (y-or-n-p "Another? [y/n]: "))
	    (return))))

(defun save-db (filename)
  (with-open-file (out filename
		       :direction :output
		       :if-exists :supersede)
    (with-standard-io-syntax
      (print *db* out))))

(defun load-db (filename)
  (with-open-file (in filename)
    (with-standard-io-syntax
      (setf *db* (read in)))))

(defun select-by-artist (artist)
  (remove-if-not #'(lambda (cd) (equal (getf cd :artist) artist))
		 *db*))

;;; note: use #'fn when calling a function, don't need it when passing a
;;; function argument

(defun foo (a b c)
  (list a b c))

(defun foo-key (&key a (b 20) (c 20 c-p))
  ;; demonstrating keyword parameters, default parameter values, and the
  ;; supplied-p parameter
  (list a b c c-p))

(foo-key :a 4 :c 52)

(defun select (selector-fn)
  ;; function to query the database using a generic selector function
  (remove-if-not selector-fn *db*))

(defun where (&key title artist rating (ripped nil ripped-p))
  ;; generic selector function
  #'(lambda (cd)
      (and
       (if title (equal (getf cd :title) title) t)
       (if artist (equal (getf cd :artist) artist) t)
       (if rating (equal (getf cd :rating) rating) t)
       (if ripped-p (equal (getf cd :ripped) ripped) t))))
