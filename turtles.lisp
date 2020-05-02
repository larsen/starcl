(in-package #:starcl)

(defclass turtle ()
  ((pos-x :initarg :x :initform (random *world-width*) :accessor x)
   (pos-y :initarg :y :initform (random *world-height*) :accessor y)
   (heading :initarg :heading :initform (random 360) :accessor heading)
   (program-thread :initform nil :accessor program-thread)
   (program :initarg :program
            :accessor program
            :initform (lambda (turtle)
                        (loop (progn
                                (left turtle (random 10))
                                (right turtle (random 10))
                                (forward turtle 10)))))))

(defun deg->rad (degree)
  (* degree (/ pi 180)))

(defgeneric display (canvas entity))
(defmethod display (canvas (turtle turtle))
  ;; TODO fix glitch in representation
  (with-output-as-presentation (canvas turtle 'turtle)
    (let* ((heading (deg->rad (heading turtle)))
           (heading-length 10)
           (heading-x (+ (x turtle) (* heading-length (cos heading))))
           (heading-y (+ (y turtle) (* heading-length (sin heading)))))
      (draw-circle* canvas (x turtle) (y turtle) 3 :ink +brown+)
      (draw-line* canvas (x turtle) (y turtle) heading-x heading-y :ink +brown+))))

(defun within-boundaries-p (x y)
  (and (> x 0) (< x *world-width*)
       (> y 0) (< y *world-height*)))

(defgeneric forward (turtle steps))
(defmethod forward ((turtle turtle) steps)
  (let* ((heading (deg->rad (heading turtle)))
         (dest-x (+ (x turtle) (* steps (cos heading))))
         (dest-y (+ (y turtle) (* steps (sin heading)))))
    (when (within-boundaries-p dest-x dest-y)
      (setf (x turtle) dest-x)
      (setf (y turtle) dest-y))))

(defgeneric left (turtle degree))
(defmethod left ((turtle turtle) degree)
  (incf (heading turtle) (* degree -1)))

(defgeneric right (turtle degree))
(defmethod right ((turtle turtle) degree)
  (incf (heading turtle) degree))

(defgeneric run-program (entity))
(defmethod run-program ((turtle turtle))
  (setf (program-thread turtle)
        (bt:make-thread
         (lambda ()
           (funcall (program turtle) turtle)))))

(defgeneric kill-program (entity))
(defmethod kill-program ((turtle turtle))
  (bt:destroy-thread (program-thread turtle)))
