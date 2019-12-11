all: build
build:
	sbcl --load cl-start.asd \
	--eval '(ql:quickload :cl-start)' \
       	--eval "(sb-ext:save-lisp-and-die #p\"cl-start\" :toplevel #'cl-start:main :executable t)"
clean:
	rm -f cl-start

