;;;; cl-start.lisp

(in-package #:cl-start)

;; Add a simple prefix dispatcher to the *dispatch-table*
(setq *dispatch-table*
	  (list (create-prefix-dispatcher "/hello" 'hello)
			(create-prefix-dispatcher "/bye" 'bye)))

;;
;; Handler functions either return generated Web pages as strings,
;; or write to the output stream returned by write-headers
(defun hello()
  "Hello !")

(defun bye()
  "Bye !")


(defun stop-server ()
	"Terminates the thread that executes the listener"
	(sb-thread:terminate-thread (find-if
													(lambda (th)
														(string= (sb-thread:thread-name th)
																		 "hunchentoot-listener-*:8080"))
													(sb-thread:list-all-threads))))

(defun main ()
	"Starts the thread that executes the listener"
  (start (make-instance 'easy-acceptor :port 8080))
  (sb-thread:join-thread (find-if
						  (lambda (th)
							(string= (sb-thread:thread-name th)
									 "hunchentoot-listener-*:8080"))
						  (sb-thread:list-all-threads))))

;;(main)
