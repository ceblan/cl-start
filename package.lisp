;;;; package.lisp
(ql:quickload '(:hunchentoot :cl-who))

(defpackage #:cl-start
  (:use #:cl
		#:hunchentoot
		#:cl-who)
    (:export :main))
