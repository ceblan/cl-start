;;;; package.lisp
(ql:quickload '(:hunchentoot :cl-who :drakma ))

(defpackage #:cl-start
  (:use #:cl
		#:hunchentoot
		#:cl-who
		#:drakma)
    (:export :main))
