;;;; starcl.asd

(asdf:defsystem #:starcl
  :description "Describe starcl here"
  :author "Your Name <your.name@example.com>"
  :license  "Specify license here"
  :version "0.0.1"
  :serial t
  :depends-on (#:sketch #:temporal-functions)
  :components ((:file "package")
               (:file "world")
               (:file "starcl")
               (:file "turtles")))
