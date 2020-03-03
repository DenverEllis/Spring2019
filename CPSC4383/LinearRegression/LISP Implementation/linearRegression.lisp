(ql:quickload :cl-plplot)
(ql:quickload :cl-csv)

;;Helper Functions
; https://github.com/HazenBabcock/cl-plplot/blob/master/src/examples/window-examples.lisp
(defun my-make-vector (dim init-fn)
  "simply makes a vector by incrementing. Gets used when making the axis for the plots"
  (let ((vec (make-array dim :initial-element 0.0 :element-type 'float)))
    (dotimes (i dim)
      (setf (aref vec i) (funcall init-fn i)))
    vec))

(defparameter *dataframe*
  '((1  1)
    (1  3)
    (10 1)
    (1  4)
    (11 -4)
    (1  34)))

(defun make-plot ()
  (let* ((x (my-make-vector 40 #'(lambda(x) (* 0.1 x))))
	 (y (my-make-vector 40 #'(lambda(x) (* (* 0.1 x) (* 0.1 x)))))
	 (p (new-x-y-plot x y))
	 (w (basic-window)))
    (add-plot-to-window w p)
    (render w g-dev)))
