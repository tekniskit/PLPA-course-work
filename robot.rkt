#lang racket

(define ns (make-base-namespace))

;(include "factory.rkt")
(include "turn.rkt")
(include "move.rkt")

(define direction 0)
(define position 94)

(define (move_forward x) x)

(define (run cmds)
  (map (lambda (cmd) (eval cmd ns)) cmds))
 
(run '(
 (turn_left 2)
 (move_forward 14)
 (turn_right 1)
 (move_backward 4)
 (pick_object "p1")
 (turn_right 3)
 (move_forward 7)
 (turn_right 1)
 (drop_object "p1")
 ))
 