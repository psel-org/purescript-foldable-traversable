;; -*- lexical-binding: t; -*-

(defvar Test.Main.deferEff
  (lambda (f)
    (lambda ()
      (funcall f nil))))

(defvar Test.Main.arrayFrom1UpTo
  (lambda (n)
    (let ((vec (make-vector n nil))
          (i 1))
      (while (<= i n)
        (aset vec (1- i) i)
        (setq i (1+ i)))
      vec)))

(defvar Test.Main.arrayReplicate
  (lambda (n)
    (lambda (x)
      (make-vector n x))))

(defvar Test.Main.mkNEArray
  (lambda (nothing)
    (lambda (just)
      (lambda (arr)
        (if (> (length arr) 0)
            (funcall just arr)
          nothing)))))

(defvar Test.Main.foldMap1NEArray
  (lambda (append)
    (lambda (f)
      (lambda (arr)
        (let ((acc (funcall f (aref arr 0)))
              (i 1))
          (while (< i (length arr))
            (setq acc (psel/funcall append acc (funcall f (aref arr i))))
            (setq i (1+ i)))
          acc)))))
