;; -*- lexical-binding: t; -*-

(require 'seq)

(defvar Data.FunctorWithIndex.mapWithIndexArray
  (lambda (f)
    (lambda (xs)
      (seq-map-indexed (lambda (x i) (funcall (funcall f i) x))
                       xs))))
