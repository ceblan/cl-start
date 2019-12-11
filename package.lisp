;;;; package.lisp
(ql:quickload '(:hunchentoot))

(defpackage #:cl-start
  (:use #:cl #:hunchentoot)
    (:export :main))
