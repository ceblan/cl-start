;;;; cl-start.asd

(asdf:defsystem #:cl-start
  :description "Common Lisp project to get started"
  :author "Dinesh Weerapurage <xydinesh@gmail.com>"
  :license  "Apache 2.0"
  :version "0.0.1"
  :serial t
  :depends-on (#:hunchentoot
			   #:cl-who
			   #:drakma)
  :components ((:file "package")
               (:file "cl-start")))
