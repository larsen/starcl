(in-package #:starcl)

(defclass world ()
  ((turtles :initform '() :accessor turtles)))

(defgeneric %add-turtle (world))
(defmethod %add-turtle ((w world))
  (push (make-instance 'turtle) (turtles w)))

(let ((+world+ nil))
  (defun ensure-world ()
    (when (not +world+)
      (setf +world+ (make-instance 'world)))
    +world+))


;; (loop for turtle in (turtles (ensure-world))
;;       do (run-program turtle))

;; (loop for turtle in (turtles (ensure-world))
;;       do (kill-program turtle))
