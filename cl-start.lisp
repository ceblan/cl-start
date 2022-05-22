;;;; cl-start.lisp
;;(ql:quickload :cl-start)
(in-package #:cl-start)

;; (setq *dispatch-table*
;; 	  (list (create-prefix-dispatcher "/hello2" 'hello2)
;; 	  		;; add more dispatchers below this line
;; 			(create-prefix-dispatcher "/test" 'test-page)
;; 			(create-prefix-dispatcher "/page" 'page-one)
;; 			(create-prefix-dispatcher "/bye" 'bye)))

;; (defun hello()
;;   "Hello !")

;; (defun hello2()
;;   "Hello 2!")

;; (defun bye()
;;   "Bye !")

;; (hunchentoot:define-easy-handler (say-yo :uri "/yo") (name)
;;   (setf (hunchentoot:content-type*) "text/plain")
;;   (format nil "Hey~@[ ~A~]!" name))


;;
;; Handler functions either return generated Web pages as strings,
;; or write to the output stream returned by write-headers

(defmacro standard-page ((&key title script) &body body)
  "All pages on the Retro Games site will use the following macro;
   less to type and a uniform look of the pages (defines the header
   and the stylesheet).
   The macro also accepts an optional script argument. When present, the
   script form is expected to expand into valid JavaScript."
  `(with-html-output-to-string
    (*standard-output* nil :prologue t :indent t)
    (:html :lang "en"
           (:head
            (:meta :charset "utf-8")
            (:title ,title)
            (:link :type "text/css"
                   :rel "stylesheet"
                   :href "retro.css")
            ,(when script
               `(:script :type "text/javascript"
                         (str ,script))))
           (:body
            (:div :id "header" ; Retro games header
                  (:img :src "logo.jpg"
                        :alt "Commodore 64"
                        :class "logo")
                  (:span :class "strapline"
                         "Vote on your favourite Retro Game"))
            ,@body))))

(defmacro standard-rest (&body body)
  "All services on the reat api will use the following macro;"
  `(format nil "~s" ,@body))

(setf (html-mode) :html5) ; output in html5

(defun test-page ()
  (with-html-output (*standard-output* nil :prologue t :indent t)
	(:html5
	 (:head
	  (:title "test page"))
	 (:body
	  (:p "CL-WHO is really easy to use.")))))


(defun page-one ()
  (standard-page (:title "Standard Page 1"
				  :script nil)
	(:body
	 (:p "LOLAILO LOLAILO"))))


(defun publish-static-content ()
  (push (create-static-file-dispatcher-and-handler
         "/logo.jpg" "static/Commodore64.jpg") *dispatch-table*)
  (push (create-static-file-dispatcher-and-handler
         "/retro.css" "static/retro.css") *dispatch-table*))


;; (flexi-streams:octets-to-string (first (list (drakma:http-request "https://servicios.ine.es/wstempus/js/ES/VARIABLES?page=1"))) :external-format :utf-8)


(define-easy-handler (hello :uri "/hello") ()
  (standard-page (:title "hola que ase")
	(:h1 "tralari")))

(define-easy-handler (bye :uri "/bye") ()
   (flexi-streams:octets-to-string (first (list (drakma:http-request "https://servicios.ine.es/wstempus/js/ES/VARIABLES?page=1"))) :external-format :utf-8))

(define-easy-handler (bye :uri "/test") ()
   (test-page))


(publish-static-content)

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
