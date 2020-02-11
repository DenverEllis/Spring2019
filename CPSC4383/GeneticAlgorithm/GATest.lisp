(defparameter *target* (cadr *args*))
(defparameter *pop-size* (parse-integer (car *args*)))

(defvar population (append '() '())) ;initialize an empty array

; Based on the number of possible nodes to travel
(defvar *genes* '((0 (0 0 0 0))
                  (1 (0 0 0 1))
                  (2 (0 0 1 0))
                  (3 (0 0 1 1))
                  (4 (0 1 0 0))
                  (5 (0 1 0 1))
                  (6 (0 1 1 0))
                  (7 (0 1 1 1))
                  (8 (1 0 0 0))
                  (9 (1 0 0 1))
                  (+ (1 0 1 0))
                  (- (1 0 1 1))
                  (* (1 1 1 1))
                  (/ (1 1 0 1))))

(defparameter *cities* (list
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

(defvar *mutation-rate* 0.001)
(defvar *crossover-rate* 0.7)

(defun random-item (list)
  "Take a list and return one item from it at random"
  (nth (random (length list)) list))

(defun generate-random-chromosome (size)
  (loop for i from 1 to size
	append (cadr (random-item *genes*))))

(defun decode-gene (gene)
  (car (rassoc gene *genes* :key #'car :test #'equal)))

(defun decode-chromosome (chromosome)
  (remove nil (loop for (a b c d) on chromosome by #'cddddr
		    collect (decode-gene (list a b c d)))))

;FIX x / 0 is silently dropped and operator precedence is not correct
(defun find-answer (dc)
  "Find the answer given by a decoded chromosome"
  (cond ((not (consp dc)) dc)
	((< (list-length dc) 3) (car (remove-if-not 'numberp dc)))
	((not (numberp (car dc))) (find-answer (cdr dc)))
	((numberp (cadr dc)) (find-answer (cons (car dc) (cddr dc))))
	((not (numberp (caddr dc)))
	 (find-answer (append (subseq dc 0 2) (cdddr dc))))
	((and (eql '/ (cadr dc))
	      (eql 0 (caddr dc)))
	 (find-answer (cons (car dc) (cddr dc))))
	(t
	 (let ((simplified (eval (list (cadr dc) (car dc) (caddr dc)))))
	   (if (consp (cdddr dc))
	       (find-answer (cons simplified (cdddr dc)))
	     simplified)))))

;Evaluate necessity
(defun count-flaws (dc)
  "Return the number og items in a chromosome which are semantically wrong..."
  (let  ((should-be-number t)
	 (flaw-count 0))
    (loop for gene in dc
	  if (not (eql (numberp gene) should-be-number))
	  do (incf flaw-count)
	  do (setf should-be-number (if should-be-number nil t)))
    flaw-count))

;FIX -100 is given to all symbol chromosomes... bad idea
(defun fitness (chromosome goal)
  "Return a fitness based on the distance from the answer and the number of flaws"
  (let ((answer (find-answer (decode-chromosome chromosome))))
    (if (numberp answer)
	(let ((distance (abs (- goal answer)))
	      (flaws (count-flaws (decode-chromosome chromosome))))
	  (+ (if (eql distance 0) 0 (/ 1 distance))
	     (if (eql flaws 0) 0 (/ 1 flaws))))
      -100)))

(defun pool-fitness (pool goal)
  (loop for chromosome in pool
	collect (fitness chromosome goal)))

(defun mutate-bit (bit)
  "Take a bit and maybe flip it"
  (if (< (random 1.0) *mutation-rate*)
      (if (eql bit 0) 1 0)
    bit))

(defun mutate (chromosome)
  "Returns a possibly mutated version of chromosome"
  (loop for bit in chromosome
	collect (mutate-bit bit)))

(defun crossover (first second)
  "Returns a mix of two chromosomes. No change is a valid possibility"
  (if (< (random 1.0) *crossover-rate*)
      (let ((point (+ (random (- (length first) 1)) 1)))
	(append (subseq first 0 point)
		(subseq second point)))
    (random-item (list first second))))

(defun make-probability (fitness)
  (let* ((total-fitness (reduce #'+ fitness))
	 (total-probability 0.0))
    (append (loop for x in fitness
		  collect total-probability
		  do (incf total-probability (/ x total-fitness))) '(1.0))))

(defun assert-probability (pool probability-chart)
  (let ((ball (random 1.0)))
    (declare (type float picked))
    (loop for chromosome in pool
	  for (position next-pos) of-type (float float) on probability-chart
	  if (<= picked next-pos)
	  do (return chromosome))))

(defun re-populate (pool fitness)
  (let ((probability-chart (make-probability fitness)))
    (loop for i from 1 to (length pool)
       collect (mutate (crossover (assert-probability pool probability-chart)
				  (assert-probability pool probability-chart))))))

(defun create-initial-pool (pool-size chromosome-size)
  (loop for i from 1 to pool-size
     collect (generate-random-chromosome chromosome-size)))

(defun find-best-chromosome (pool fitness)
  "Returns the most fit chromosome in the pool."
  (let ((best-score) (best-chromosome))
    (loop for chromosome in pool
       for score in fitness
       do (when (or (equalp score 0) (not best-score) (> score best-score))
	    (setf best-score score)
	    (setf best-chromosome chromosome)))
    (values best-chromosome best-score)))

(defun return-answer (pool fitness)
  "If any of the chromosomes in the pool have the answer return the first one that does."
  (let ((answer (position 0 fitness)))
    (if answer (nth answer pool))))

(defun display-turn (pool fitness turn)
  (multiple-value-bind (chromosome score) (find-best-chromosome pool fitness)
    (let ((avg-fitness (/ (reduce #'+ fitness) (+ 1 (length pool))))
	  (*print-pretty* nil))
      (format t "~a - Average Fitness: ~F Best: ~w (fitness ~F)~%" turn avg-fitness
	      (decode-chromosome chromosome) score))))

(defun genetic-algorithm (goal pop-size chromosome-size tries)
  (let ((pool (create-initial-pool pop-size chromosome-size))
	(fitness))
    (loop for i from 1 to tries
       do (setf fitness (pool-fitness pool goal))
       if (there-is-answer pool fitness) return it
       do (display-turn pool fitness i)
       do (setf pool (re-populate pool fitness))
       finally (return (find-best-chromosome pool fitness)))))
