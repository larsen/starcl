;;;; starcl.lisp

(in-package #:starcl)

(defparameter *world-width* 400)
(defparameter *world-height* 400)

(defparameter *fps* 0)
(defparameter *fps-counter* 0)
(defparameter *ticker* (make-stepper (seconds 1)))

;; World monitor

(defsketch world-monitor ((width *world-width*)
                          (height *world-height*)
                          (world (ensure-world))
                          (font-stats (make-font :color +white+ :size 30))
                          (font-fps (make-font :color +yellow+ :size 24)))

  (incf *fps-counter*)
  (when (funcall *ticker*)
    (setf *fps* *fps-counter*)
    (setf *fps-counter* 0))

  (background (rgb 0 0 0))
  (loop for turtle in (turtles world)
        do (display sketch::instance turtle))
  ;; Display some simulation and system stats
  (with-font font-stats
    (text (format nil "~a" (length (turtles world))) 10 10))
  (with-font font-fps
    (text (format nil "~a" *fps*) 10 360)))

(defun add-turtle ()
  (%add-turtle (ensure-world)))


(defmacro broadcasting (method &rest args)
  `(loop for turtle in (turtles (ensure-world))
         do (funcall ,method turtle ,@args)))

(defmacro forward (n)
  `(broadcasting #'%forward ,n))

(defmacro left (n)
  `(broadcasting #'%left ,n))

(defmacro right (n)
  `(broadcasting #'%right ,n))


(defun run ()
  (make-instance 'world-monitor))


;; example "script"

(defun example ()
  ;; Setup
  (clearall (ensure-world))
  (loop repeat 100
        do (add-turtle))
  ;; Main loop
  (loop do (left (random 15))
           (forward 0.50)))
