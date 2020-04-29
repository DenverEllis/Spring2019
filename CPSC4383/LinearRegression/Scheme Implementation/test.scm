#lang racket
;-------------------------------------------------------------------------------
; Includes and required packages
;-------------------------------------------------------------------------------
(require 2htdp/batch-io)
(require plot)           ;For displaying data
(require math/array
         math/matrix)    ;For arithmetic

;;; Parse and display the data (proof of concept)
(define Data (read-csv-file "extdata1.csv"))

;;; Population from Data
(define in1 (for/list ([i Data])
            (string->number (car i))))


;;; Profit from Data
(define in2 (for/list ([i Data])
            (string->number (first (rest i)))))


(define (compute-cost X y theta)
  (sqr (- (flatten (matmul X theta)) y))




;;; Set constants
(define alpha 0.01)
(define step-limit 1500)

;; sigmoid : Number -> Number
(define (sigmoid x)
  (/ 1.0 (+ 1.0 (exp (- x)))))

;; linear : Number -> Number
(define (linear x) x)

(define (insert-bias-col mat)
  (let ([bias-col (make-matrix (matrix-num-rows mat) 1 1.0)])
	(matrix-augment (list bias-col mat))))


(define (batch-descent hypothesis features targets params)
  (define (batch-update params)
	(let* ([prod (matrix* features (matrix-transpose params))]
		   [hyp (matrix-map hypothesis prod)])
	  (matrix+ params
			   (matrix-scale 
				 (matrix-transpose 
				   (matrix* 
					 (matrix-transpose features) 
					 (matrix- targets hyp)))
				 (/ alpha (matrix-num-rows targets))))))

  (define (iter steps theta)
	(if (eq? 0 steps) 
	  theta
	  (iter (sub1 steps) (batch-update theta))))

  (iter step-limit params))



(define features (insert-bias-col (matrix-transpose (matrix [[1. 2. 3. 4. 5. 6. 7. 8. 9. 10.]]))))

(define targets (matrix-transpose (matrix [[1. 2. 3. 4. 5. 6. 7. 8. 9. 10.]])))

(define params (make-matrix 1 2 0.0))

(define x (insert-bias-col (list->matrix (length in1) 1 in1)))
(define y (list->matrix (length in2) 1 in2))
x



; Tests
(define results (matrix->list (batch-descent linear x y params)))


;;; Plot data
(plot (list (axes)
            (points (for/list ([i (in-range (length Data))])
                      (list (list-ref in1 i) (list-ref in2 i)))
                    #:color "blue")
            (function (λ (t1) t1)
                      #:label "y = x"
                      #:color 0
                      #:style 'dot))

    #:x-min 0
    #:x-max 30
    #:y-min 0
    #:y-max 30
    #:title "Profits Distribution"
    #:x-label "Population of City (in 10,000s)" #:y-label "Profit (in $10,000s)" )