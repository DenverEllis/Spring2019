#lang racket
;-------------------------------------------------------------------------------
; Includes and required packages
;-------------------------------------------------------------------------------
(require 2htdp/batch-io) ;For parsing CSV File
(require plot)           ;For displaying data
(require math/array
         math/matrix)    ;For arithmetic


;-------------------------------------------------------------------------------
; Function Definitions
;-------------------------------------------------------------------------------

;; sqr: Number -> Number
;; Squares the given number
(define (sqr num)
  (* num num))

;; dot-product: [List lst1] -> [List lst2] -> Number
;; Takes the dot product of two lists
(define (dot-product lst1 lst2)
  (cond ((null? lst1) 0)
        (else
         (+ (* (caar lst1) (caar lst2))
            (dot-product (cdr lst1) (cdr lst2))))))


;; matmul: [List mat1] -> [List mat2] -> [List]
;; Designed to opperate like numpy matmul.
(define (matmul mat1 mat2)
  (map
   (lambda row
    (apply map
     (lambda col
      (apply + (map * row col)))
     mat2))
   mat1))

;; sum: [List lst] -> Number
;; Sums the numbers in a list of numbers
(define (sum lst)
  (if (null? lst) 0
      (+ (car lst) (sum (cdr lst)))))

;; sub-lst: [List lst1 -> [List lst2] -> [List] -> [List]
;; Maps subtraction on two lists
(define (sub-lst lst1 lst2)
  (map - lst1 lst2))

;; length : [Listof Element] -> Number
;; Produces the number of elements in the list
(define (length lst)
  (cond
    [(empty? lst)  0]
    [(cons? lst)   (+ 1 (length (rest lst)))]))

;; compute-cost : [List X] -> [List y] -> [List theta] -> Number
;; The cost function to evaluate the linear regression.
(define (compute-cost X y theta)
  (sqr (- (flatten (matmul X theta)) y)))



;; sigmoid : Number -> Number
(define (sigmoid x)
  (/ 1.0 (+ 1.0 (exp (- x)))))

;; linear : Number -> Number
(define (linear x) x)

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

;-------------------------------------------------------------------------------
; Code to be run
;-------------------------------------------------------------------------------

;;; Set constants
(define alpha 0.01)
(define step-limit 1500)


;;; Parse and display the data (proof of concept)
(define Data (read-csv-file "extdata1.csv"))

;;; Population from Data
(define in1 (for/list ([i Data])
            (string->number (car i))))
(define x (list->matrix (length in1) 1 in1))

;;; Profit from Data
(define in2 (for/list ([i Data])
            (string->number (first (rest i)))))
(define y (list->matrix (length in2) 1 in2))

;;; Plot data
(plot
    (points (for/list ([i (in-range (length Data))])
              (list (list-ref in1 i) (list-ref in2 i)))
            #:color "blue")
    #:x-min 0
    #:x-max 30
    #:y-min 0
    #:y-max 30
    #:title "Profits Distribution"
    #:x-label "Population of City (in 10,000s)" #:y-label "Profit (in $10,000s)" )



;-------------------------------------------------------------------------------
; Debug Code (Use for insight into thought process)
;-------------------------------------------------------------------------------

;(sqr 5)
;(sqr 3.14)

;(dot-product x y)

;(length Data)
;(length x)
;(length y)

;(matmul x y)