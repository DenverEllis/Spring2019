;;;; Martin Kersner, m.kersner@gmail.com
;;;; 2017/04/19 

(push (namestring (uiop:run-program "cd")) asdf:*central-registry*)
(asdf:load-system :cl-plot)
