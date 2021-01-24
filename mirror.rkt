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

(define (list-mirrors start end)
    (let ((n start))
        (if (equal? n end )
            '() 
            (cons (mirror n) (list-mirrors (+ n 1) end)))))

(define (plot-mirrors lower upper)
    (plot
      (points (for/list ([i (in-range lower upper)])
                  (list i (mirror i))))))

(let ((args (parseargs (current-command-line-arguments))))
    (plot-mirrors (first args) (second args)))

