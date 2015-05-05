(include "Scheme/log.scm")

; Robot state
(define x 0)
(define y 0)
(define direction 0)
(define cargo "")


; Turn
(define (turn_left turns)
  (set! direction (modulo (+ direction turns) 4))
  (log x y direction cargo))

(define (turn_right turns)
  (turn_left (- turns)))


; Move
(define (step_loop distance step do-step!)
  (cond ((> distance 0)
         (do-step!)
         (log x y direction cargo)
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
  (set! cargo name)
  (log x y direction cargo))

(define (drop_object)
  (pick_object ""))


