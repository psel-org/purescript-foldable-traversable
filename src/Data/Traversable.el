;; -*- lexical-binding: t; -*-

(defvar Data.Traversable.traverseArrayImpl
  (lambda (apply)
    (lambda (map)
      (lambda (pure)
        (lambda (f)
          (lambda (xs)
            (let ((cons_ (lambda (a) (lambda (b) (cons a b))))
                  (init (funcall pure '())))
              (psel/funcall map
                            (lambda (ys) (apply 'vector (reverse ys)))
                            (seq-reduce (lambda (b a)
                                          (let* ((mb (funcall f a))
                                                 (mc (psel/funcall map cons_ mb)))
                                            (psel/funcall apply mc b)))
                                        xs
                                        init)))))))))
