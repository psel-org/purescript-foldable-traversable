;; -*- lexical-binding: t; -*-

(require 'seq)

(defvar Data.FunctorWithIndex.mapWithIndexArray
  (lambda (f)
    (lambda (xs)
      (apply 'vector
             (seq-map-indexed (lambda (x i) (psel/funcall f i x))
                              xs)))))
