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

(defun add-turtle ()
  (%add-turtle (ensure-world)))

(defun forward (n)
  (loop for turtle in (turtles (ensure-world))
        do (%forward turtle n)))

(defun left (n)
  (loop for turtle in (turtles (ensure-world))
        do (%left turtle n)))

(defun right (n)
  (loop for turtle in (turtles (ensure-world))
        do (%right turtle n)))



(defun run ()
  (make-instance 'world-monitor))
