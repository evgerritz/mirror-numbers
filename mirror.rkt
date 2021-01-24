#!/usr/bin/env racket

#lang racket
(require plot)
(plot-new-window? #t)

(define (mirror n)
    (define (mirror-helper n result)
      (if (> n 0)
        (mirror-helper (quotient n 10)
                       (+ (* result 10) (remainder n 10)))
        result))
    (mirror-helper n 0))

(define (parseargs argv)
  (let ((args (vector->list argv)))
      (cond
          ((= (length args) 0) '(0 1000))
          ((= (length args) 1) (cons 0 (list (string->number (first args)))))
          (else (cons (string->number (first args))
                      (list (string->number (first (rest args)))))))))

(define (listMirrors n)
    (mirror n)
    (if (equal? n 1000)
        0
        (listMirrors (+ n 1))))

(define (plotMirrors lower upper)
    (plot
      (points (for/list ([i (in-range lower upper)])
                  (list i (mirror i))))))

(let ((args (parseargs (current-command-line-arguments))))
    (plotMirrors (first args) (second args)))

