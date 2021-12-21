;; -*- lexical-binding: t; -*-

;; シンプルな実装で再帰呼出しが深すぎて耐えられない(Lisp nesting exceeds ‘max-lisp-eval-depth’エラーが発生)。
;; JSの実装を倣って分割統治を使う。
;;
;; (defvar Data.Traversable.traverseArrayImpl
;;   (lambda (apply)
;;     (lambda (map)
;;       (lambda (pure)
;;         (lambda (f)
;;           (lambda (xs)
;;             (let ((cons_ (lambda (a) (lambda (b) (cons a b))))
;;                   (init (funcall pure '())))
;;               (psel/funcall map
;;                             (lambda (ys) (apply 'vector (reverse ys)))
;;                             (seq-reduce (lambda (b a)
;;                                           (let* ((mb (funcall f a))
;;                                                  (mc (psel/funcall map cons_ mb)))
;;                                             (psel/funcall apply mc b)))
;;                                         xs
;;                                         init)))))))))

(defvar Data.Traversable.traverseArrayImpl
  (let ((array1 (lambda (a) (vector a)))
        (array2 (lambda (a) (lambda (b) (vector a b))))
        (array3 (lambda (a) (lambda (b) (lambda (c) (vector a b c)))))
        (concat2 (lambda (xs) (lambda (ys) (vconcat xs ys)))))
    (lambda (apply)
      (lambda (map)
        (lambda (pure)
          (lambda (f)
            (lambda (xs)
              (letrec ((go (lambda (bot top)
                             (pcase (- top bot)
                               (0 (psel/funcall pure []))
                               (1 (psel/funcall map array1 (psel/funcall f (aref xs bot))))
                               (2 (psel/funcall apply
                                                (psel/funcall map array2 (psel/funcall f (aref xs bot)))
                                                (psel/funcall f (aref xs (1+ bot)))))
                               (3 (psel/funcall apply
                                                (psel/funcall apply
                                                              (psel/funcall map array3 (psel/funcall f (aref xs bot)))
                                                              (psel/funcall f (aref xs (1+ bot))))
                                                (psel/funcall f (aref xs (+ 2 bot)))))
                               (_
                                (let ((pivot (+ bot (* 2 (floor (/ (- top bot) 4.0))))))
                                  (psel/funcall apply
                                                (psel/funcall map concat2 (funcall go bot pivot))
                                                (funcall go pivot top))))))))
                (funcall go 0 (length xs))))))))))
