#lang racket

(define (turn turns)
    (modulo turns 4))

; Turn left
(define (turn_left turns) (turn turns))

; Turn right
(define (turn_right turns) (turn (- turns)))