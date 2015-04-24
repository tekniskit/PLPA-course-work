#lang racket

(define width 32)
(define direction 0)
(define position 94)

; Move right
(define (move_right position distance)
  (+ position distance))

; Move right
(define (move_left position distance)
  (- position distance))

; Move up
(define (move_up position distance)
  (- position (* width distance)))

; Move down
(define (move_down position distance)
  (+ position (* width distance)))

; Move
(define (move direction position distance)
    (cond ((= direction 0) (move_right position distance))
          ((= direction 1) (move_up position distance))
          ((= direction 2) (move_left position distance))
          ((= direction 3) (move_down position distance))))

(define (move_forward distance)
  (move direction position distance))

(define (move_backward distance)
  (move direction position (- distance)))