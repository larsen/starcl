;;;; starcl.lisp

(in-package #:starcl)

(defparameter *world-width* 400)
(defparameter *world-height* 400)


;; World monitor

(defsketch world-monitor ((width *world-width*)
                          (height *world-height*)
                          (world (ensure-world)))
  (background (rgb 0 0 0))
  (with-font (make-font :color +white+ :size 30)
    (text (format nil "~a" (length
                            (turtles world))) 10 10))
  (loop for turtle in (turtles world)
        do (display sketch::instance turtle)))
