;; -*- lexical-binding: t; -*-

(require 'seq)

(defvar Data.Foldable.foldrArray
  (lambda (f)
    (lambda (init)
      (lambda (xs)
        (let ((b init)
              (i (1- (length xs))))
          (while (>= i 0)
            (setq b (funcall (funcall f (aref xs i)) b))
            (setq i (1- i)))
          b)))))

(defvar Data.Foldable.foldlArray
  (lambda (f)
    (lambda (init)
      (lambda (xs)
        (seq-reduce (lambda (b a) (funcall (funcall f b) a))
                    xs
                    init)))))
