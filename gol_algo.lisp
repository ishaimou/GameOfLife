(defparameter w 7)
(defparameter h 7)
(defparameter matrix nil)
(defparameter density nil)
(defparameter nb 0)

;(setq matrix (make-array (list w h) :initial-element 0))

(setq matrix #2A(
 (0 0 0 0 0 0 0)
 (0 0 0 1 0 0 0)
 (0 0 0 0 1 0 0)
 (0 0 1 1 1 0 0)
 (0 0 0 0 0 0 0)
 (0 0 0 0 0 0 0)
 (0 0 0 0 0 0 0)))

(setq density (make-array (list w h) :initial-element 0))

(defun random-matrix ()
  (dotimes (i h)
    (dotimes (j w)
      (setf (aref matrix i j) (random 2))))
  matrix)

(defun is-alive (i j)
  (equal (aref matrix i j) 1))

(defun is-neighbor (i j)
  (if (AND (>= i 0) (< i h) (>= j 0) (< j w))
      (if (equal (aref matrix i j) 1) 1 0) 0))

(defun get-neighbors (row column)
  (setf nb 0)
  (loop for i from (- row 1) to (+ row 1)
        do (loop for j from (- column 1) to (+ column 1)
                 do (setf nb (+ nb (is-neighbor i j)))))
  (if (equal (aref matrix row column) 1)
      (decf nb))
  nb)

(defun calculate-density ()
  (dotimes (i h)
    (dotimes (j w)
      (setf (aref density i j) (get-neighbors i j))))
  density)

(defun rule1 (i j)
  (if (AND (is-alive i j) (< (aref density i j) 2)) t nil))

(defun rule2 (i j)
  (if (AND (is-alive i j) (OR (equal (aref density i j) 2) (equal (aref density i j) 3))) t nil))

(defun rule3 (i j)
  (if (AND (is-alive i j) (> (aref density i j) 3)) t nil))

(defun rule4 (i j)
  (if (AND (NOT(is-alive i j)) (equal (aref density i j) 3)) t nil))

(defun update-matrix ()
  (dotimes (i h)
    (dotimes (j h)
      (if (rule1 i j) (setf (aref matrix i j) 0))
      (if (rule2 i j) (setf (aref matrix i j) 1))
      (if (rule3 i j) (setf (aref matrix i j) 0))
      (if (rule4 i j) (setf (aref matrix i j) 1))))
  matrix)

;(setq matrix (random-matrix))

#|
(dotimes (x 20)
    (print matrix)
    (format t "Generation ~d~%" (1+ x))
    (setq density (calculate-density))
    (setq matrix (update-matrix)))
|#
