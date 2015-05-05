#lang racket

; Debug funcs
(define (state) (display x) (display ",") (display y) (display ",") (display direction) (display "\n"))
(define (show x) (display x) (display "\n"))
; END


(define x 0)
(define y 0)
(define direction 0)
(define cargo 0)

; Turn
(define (turn_left turns)
  (set! direction (modulo (+ direction turns) 4)))

(define (turn_right turns)
  (turn_left (- turns)))


; Move
(define (move_up distance step)
  (cond
    ((= 0 distance) distance)
    ((set! y (+ step y))
     (move_up (- distance (abs step)) step))))


(define (move_right distance step)
  (cond
    ((= 0 distance) distance)
    (else
     (set! x (+ step x))
     (move_right (- distance (abs step)) step))))

(define (move distance step)
  (if 
    (even? direction)
    (move_right distance (if (= 0 direction) step (- step)))
    (move_up distance (if (= 3 direction) step (- step)))))

(define (move_forward distance)
  (if 
    (even? direction)
    (move_right distance (if (= 0 direction) 1 -1))
    (move_up distance (if (= 3 direction) 1 -1))))

(define (move_backward distance)
  (if 
    (even? direction)
    (move_right distance (if (= 0 direction) -1 1))
    (move_up distance (if (= 3 direction) -1 1))))

; Cargo
(define (pick_object name)
  (set! cargo name))

(define (drop_object)
  (pick_object ""))


; Tests
(move_forward 10) (state)
(turn_right 1) (state)
(move_forward 5) (state)
(turn_right 1) (state)
(move_backward 7) (state)
















