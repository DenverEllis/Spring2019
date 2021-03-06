;;; readCoords.lisp
;;  THIS IS SOLEY A TEST FILE. IT DOES NOT CONTRIBUTE TO THE PROJECT. IT WAS
;;  ONLY USED FOR TESTING LISP CONCEPTS. This file can be considered scratch
;;  work. The file name holds no meaning to the contents.

;;Author: Denver Ellis <dsellis@ualr.edu>
;;Maintained By: Denver Ellis <dsellis@ualr.edu>
;;Created: 10 Feb 2020
;;Last Updated: 23 Feb 2020

(defparameter *s* (open "./cities.txt"))

(defparameter *cities* (list
			'(6734 1453)
			'(2233 10)
			'(5530 1424)
			'(401 841)
			'(3082 1644)
			'(7608 4458)
			'(7573 3716)
			'(7265 1268)
			'(6898 1885)
			'(1112 2049)
			'(5468 2606)
			'(5989 2873)
			'(4706 2674)
			'(4612 2035)
			'(6347 2683)
			'(6107 669)
			'(7611 5184)
			'(7462 3590)
			'(7732 4723)
			'(5900 3561)
			'(4483 3369)
			'(6101 1110)
			'(5199 2182)
			'(1633 2809)
			'(4307 2322)
			'(675 1006)
			'(7555 4819)
			'(7541 3981)
			'(3177 756)
			'(7352 4506)
			'(7545 2801)
			'(3245 3305)
			'(6426 3173)
			'(4608 1198)
			'(23 2216)
			'(7248 3779)
			'(7762 4595)
			'(7392 2244)
			'(3484 2829)
			'(6271 2135)
			'(4985 140)
			'(1916 1569)
			'(7280 4899)
			'(7509 3239)
			'(10 2676)
			'(6807 2993)
			'(5185 3258)
			'(3023 1942)))


(defparameter *cities2* (list
			'(A 6734 1453)
			'(B 2233 10)
			'(C 5530 1424)
			'(D 401 841)
			'(E 3082 1644)
			'(F 7608 4458)
			'(G 7573 3716)
			'(H 7265 1268)
			'(I 6898 1885)
			'(J 1112 2049)
			'(K 5468 2606)
			'(L 5989 2873)
			'(M 4706 2674)
			'(N 4612 2035)
			'(O 6347 2683)
			'(P 6107 669)
			'(Q 7611 5184)
			'(R 7462 3590)
			'(S 7732 4723)
			'(T 5900 3561)
			'(U 4483 3369)
			'(V 6101 1110)
			'(W 5199 2182)
			'(X 1633 2809)
			'(Y 4307 2322)
			'(Z 675 1006)
			'(AA 7555 4819)
			'(AB 7541 3981)
			'(AC 3177 756)
			'(AD 7352 4506)
			'(AE 7545 2801)
			'(AF 3245 3305)
			'(AG 6426 3173)
			'(AH 4608 1198)
			'(AI 23 2216)
			'(AJ 7248 3779)
			'(AK 7762 4595)
			'(AL 7392 2244)
			'(AM 3484 2829)
			'(AN 6271 2135)
			'(AO 4985 140)
			'(AP 1916 1569)
			'(AQ 7280 4899)
			'(AR 7509 3239)
			'(AS 10 2676)
			'(AT 6807 2993)
			'(AU 5185 3258)
			'(AV 3023 1942)))

;; a tail-call recursive version:
(defun encode-chromosome (cities city-sequence
                                   &key (acc-cities '())
                                        (acc-positions '())
                                        (pos-counter 0)
                                        (test #'eql))
  "Helper function for crossover"
    (cond ((or (null city-sequence) (null cities)) (nreverse acc-positions))
          ((funcall test (car city-sequence) (car cities))
           (encode-chromosome (append (nreverse acc-cities) (cdr cities))
			      (cdr city-sequence)
			      :acc-cities '()
			      :acc-positions (cons pos-counter acc-positions)
			      :pos-counter 0
			      :test test))
          (t (encode-chromosome (cdr cities)
				city-sequence
				:acc-cities (cons (car cities) acc-cities)
				:acc-positions acc-positions
				:pos-counter (1+ pos-counter)
				:test test))))


(defparameter *test* (list
		      '(A (6734 1453))
		      '(B (2233 10))
		      '(C (5530 1424))
		      '(D (401 841))
		      '(E (3082 1644))))

(defparameter *test2* (list 0 2 2 0 0))

(defparameter *test3* (list
		       '(A (6734 1453))
		       '(D (401 841))
		       '(E (3082 1644))
		       '(B (2233 10))
		       '(C (5530 1424))))


(defun generate-random-chromosome (list)
  "Make a chromosome from the list at random. To do this, copy list and shuffle"
  (loop for i from (length list) downto 2
     do (rotatef (elt list (random i))
		 (elt list (1- i))))
  list)


(defun encode-gene (chromosome gene)
  "Helper function for crossover"
  (list (position gene chromosome :key #'car :test #'eql)
        (remove gene chromosome :key #'car :test #'eql)))

(defun encode-chromosome (city-list city-sequence)
  "Helper function for crossover"
  (let ((current-cities city-list))
    (loop for current-city in city-sequence
          for (idx updated-cities) = (encode-gene current-cities current-city)
          collect (progn (setf current-cities updated-cities)
                         idx)
	  into index-positions
          finally (return index-positions))))
