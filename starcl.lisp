;;;; starcl.lisp

(in-package #:starcl)

(defparameter *world-width* 400)
(defparameter *world-height* 400)

(define-application-frame world ()
  ((turtles :accessor turtles
            :initform (loop repeat 10 collect (make-instance 'turtle))))
  (:panes
   (canvas :application :display-function #'display-world)
   (int :interactor)
   (point-doc :pointer-documentation))
  (:layouts
   (default (vertically ()
              (5/8 canvas)
              (2/8 int)
              (1/8 point-doc))))
  (:pretty-name "CLIM")
  (:geometry :width 800 :height 600))

(define-world-command (com-quit :name t :menu t) ()
  (loop for turtle in (turtles *application-frame*)
        do (kill-program turtle))
  (frame-exit *application-frame*))

(define-world-command (com-add-turtle :name t :menu t) ()
  (push (make-instance 'turtle) (turtles *application-frame*)))

(define-world-command (com-forward-turtle :name "Forward" :menu t)
    ((turtle 'turtle :prompt "Select a turtle:")
     (steps 'number :prompt "Number of steps:"))
  (forward turtle steps))

(define-world-command (com-run :name "Run" :menu t) ()
  (loop for turtle in (turtles *application-frame*)
        do (run-program turtle)))

(defun display-world (frame pane)
  (loop for turtle in (turtles frame)
        do (display pane turtle)))

(defclass redisplay-event (window-manager-event) ())

(defmethod handle-event ((frame world) (event redisplay-event))
  (redisplay-frame-pane frame 'canvas)
  (when (member (frame-state frame) '(:enabled :shrunk))
    (schedule-event (frame-top-level-sheet frame)
                    (make-instance 'redisplay-event
                                   :sheet frame)
                    0.1)))

(defmethod run-frame-top-level :before ((world world) &key)
  (let* ((sheet (frame-top-level-sheet world))
         (event (make-instance 'redisplay-event :sheet world)))
    (queue-event sheet event)))

(defun run ()
  (run-frame-top-level (make-application-frame 'world)))
