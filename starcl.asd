;;;; starcl.asd

(asdf:defsystem #:starcl
  :description "Describe starcl here"
  :author "Your Name <your.name@example.com>"
  :license  "Specify license here"
  :version "0.0.1"
  :serial t
  :depends-on (#:sketch)
  :components ((:file "package")
               (:file "starcl")
               (:file "turtles")))
