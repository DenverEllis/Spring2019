(require "asdf")
(load "init")



(defparameter *dataframe*
  '((1  1)
    (1  3)
    (10 1)
    (1  4)
    (11 -4)
    (1  34)))

(defparameter *fig* (make-instance 'figure))
