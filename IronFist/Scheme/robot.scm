(include "Scheme/log.scm")
(include "Scheme/Floorplans/factory.scm")

; Internal robot state
(define x 0)
(define y 8)
(define direction 0) ; 0 = east, 1 = north, 2 = west, 3 = south
(define cargo 0) ; Id of an object as a number. 0 = empty.


; Function: reset_robot!
; Description: Resets robot state.

(define (reset-robot!)
  (set! x 0)
  (set! y 8)
  (set! direction 0)
  (set! cargo 0)
  (log x y direction cargo))


(define (get-tile x y)
  (vector-ref (vector-ref factory y) x))

; Function: turn_left
; Description: Turns the robot to the left
; Params:
;   turns = number of 90deg left turns

(define (turn_left turns)
  (inc-program-counter!)
  (thread-sleep 250)
  (set! direction (modulo (+ direction turns) 4))
  (log x y direction cargo))


; Function: turn_right
; Description: Turns the robot to the right
; Params:
;   turns = number of 90deg right turns

(define (turn_right turns)
  (turn_left (- turns))) ; A right turn is a negative left turn


; Function: can-step?
; Description: Checks if the next space is free
; Params:
;   step: The length of the steps. A negative number means backward movement.

(define (allowed-tile? x y)
    (and (>= y 0) (< y (vector-length factory))
         (>= x 0) (< x (vector-length (vector-ref factory y)))
         (member (get-tile x y) '(* ! ^ v < >))))

(define (can-step? step)
  (if (even? direction)
    (allowed-tile? (+ (if (= 0 direction) step (- step)) x) y)
    (allowed-tile? x (+ (if (= 3 direction) step (- step)) y))))


; Function: step-loop
; Description: Tries to move the robot a distance while validating every step.
; Params:
;   distance = Total distance the robot should move.
;   step = The length of the steps. A negative number means backward movement.
;   do-step! = A function which shall update the robots state.

(define (step-loop distance step do-step!)
  (cond ((> distance 0)
    (cond ((can-step? step)
      (thread-sleep 500)
      (do-step!)
      (log x y direction cargo)
      (step-loop (- distance (abs step)) step do-step!))
      (else (log-error "Illegal move. Robot stopped."))))))


; Function: move
; Description: Tries to move the robot a distance in the direction it is pointing.
; Params:
;   distance = Total distance the robot should move.
;   step = The length of the steps. A negative number means backward movement.

(define (move distance step)
  (step-loop distance (abs step)
             (if (even? direction)
                  (lambda () (set! x (+ (if (= 0 direction) step (- step)) x)))
                  (lambda () (set! y (+ (if (= 3 direction) step (- step)) y))))))


; Function: move_forward
; Description: Moves the robot forward in steps of 1.
; Params:
;   distance = Total distance the robot should move.

(define (move_forward distance)
  (inc-program-counter!)
  (move distance 1))


; Function: move
; Description: Moves the robot backward in steps of 1.
; Params:
;   distance = Total distance the robot should move.
(define (move_backward distance)
  (move distance -1))


(define (nabour-check name xdir ydir)
  (let
    ((tile (get-tile x y)))
      (cond 
        ((eqv? tile 'v) (eqv? name (get-tile x (+ y (- ydir)))))
        ((eqv? tile '^) (eqv? name (get-tile x (+ y ydir))))
        ((eqv? tile '<) (eqv? name (get-tile (+ x xdir) y)))
        ((eqv? tile '>) (eqv? name (get-tile (+ x (- xdir)) y)))
        (else #f))))


; Function: can-pick?
; Description: Checks if the robot can pick up the given item.
; Params:
;   name: The item which the robot wants to pick up.

(define (can-pick? name)
  (nabour-check name 1 1))


; Function: can-drop?
; Description: Checks if the robot is at the dropoff point.
; Params:

(define (can-drop?)
  (nabour-check (+ cargo 1) -1 -1))



(define (set-cargo name)
  (inc-program-counter!)
  (thread-sleep 1000)
  (set! cargo name)
  (log x y direction cargo))


; Function: pick_object
; Description: Tries to pick up an object.
; Params:
;   name = Name of object as a string

(define (pick_object name)
  (cond
    ((and (= cargo 0) (can-pick? name))
      (set-cargo name))

    (else (log-error "The robot is not at the correct pick up point."))))


; Function: drop_object
; Description: Drops what ever object is in the cargo.
; Params:

(define (drop_object)
  (cond
    ((and (> cargo 0) (can-drop?))
      (set-cargo 0))

    (else (log-error "The robot is not at the correct drop point."))))