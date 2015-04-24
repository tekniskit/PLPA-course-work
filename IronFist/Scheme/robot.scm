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
        ))
    (list
     (cons 'turn_left (lambda (turns) turns))
     (cons 'turn_right (lambda (turns) turns))
     
     (cons 'move_backward (lambda (distance) distance))
     (cons 'move_forward (lambda (distance) distance))
     
     (cons 'pick_object (lambda (name) name))
     (cons 'drop_object (lambda (name) name))

     (cons 'x (lambda () x))
     (cons 'y (lambda () y))
     (cons 'direction (lambda () direction))
     )
  ))