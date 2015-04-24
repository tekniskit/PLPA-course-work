#lang racket

(require "direction.rkt")

(provice create-robot)

(define (create-robot x y direction)
 (let* (
        (move (lambda (distance)
                (if (= distance 0)
                    (cons x y))
                (else
                    (set! x )
                    (set! y )
                    (validPosition? x y)
                    (move (- 1 distance)))
        )
    (list
     (cons 'move_forward (lambda (turns) (turn turns) direction))
     (cons 'x (lambda () x))
     (cons 'y (lambda () y))
     (cons 'direction (lambda () direction))
     )
  ))