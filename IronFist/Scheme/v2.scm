#lang racket

; Debug funcs
(define (log) (display x) (display ",") (display y) (display ",") (display direction) (display "\n"))
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
(define (step_loop distance step do-step!)
  (cond ((> distance 0)
         (do-step!)
         (log)
         (step_loop (- distance (abs step)) step do-step!))))

(define (move distance step)
  (step_loop distance step
             (if (even? direction)
                  (lambda () (set! x (+ (if (= 0 direction) step (- step)) x)))
                  (lambda () (set! y (+ (if (= 3 direction) step (- step)) y))))))  

(define (move_forward distance)
  (move distance 1))

(define (move_backward distance)
  (move distance -1))


; Cargo
(define (pick_object name)
  (set! cargo name))

(define (drop_object)
  (pick_object ""))


; Tests
(move_forward 10)
(turn_right 1)
(move_forward 5)
(turn_right 1)
(move_backward 7)


