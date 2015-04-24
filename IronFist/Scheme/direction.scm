#lang racket

(provide create-direction)

(define (create-direction direction)
  (let* (
         (turn (lambda (turns)
                 (set! direction (modulo (+ direction turns) 4))))
        )
    (list
     (cons 'turn_left (lambda (turns) (turn turns) direction))
     (cons 'turn_right (lambda (turns) (turn (- turns)) direction))
     (cons 'value (lambda () direction))
     )
  ))