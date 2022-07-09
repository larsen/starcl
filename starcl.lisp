;;;; starcl.lisp

(in-package #:starcl)

(defparameter *world-width* 400)
(defparameter *world-height* 400)

(defclass world ()
  ((turtles :initform '() :accessor turtles)))

(defgeneric add-turtle (world))
(defmethod add-turtle ((w world))
  (push (make-instance 'turtle) (turtles w)))

(let ((+world+ nil))
  (defun ensure-world ()
    (when (not +world+)
      (setf +world+ (make-instance 'world)))
    +world+))

(defsketch world-monitor ((width *world-width*)
                          (height *world-height*)
                          (world (ensure-world)))
  (background (rgb 0 0 0))
  (with-font (make-font :color +white+ :size 30)
    (text (format nil "~a" (length
                            (turtles world))) 10 10))
  (loop for turtle in (turtles world)
        do (display sketch::instance turtle)))

(defun display-world (frame pane)
  (loop for turtle in (turtles frame)
        do (display pane turtle)))
