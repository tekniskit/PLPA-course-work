(include "Scheme/log.scm")
(include "Scheme/Floorplans/factory.scm")

; Internal robot state
(define x 0)
(define y 8)
(define direction 0) ; 0 = east, 1 = north, 2 = west, 3 = south
(define cargo "") ; Name of an object as a string


; Function: turn_left
; Description: Turns the robot to the left
; Params:
;   turns = number of 90deg left turns

(define (turn_left turns)
  (set! direction (modulo (+ direction turns) 4))
  (thread-sleep 250)
  (log x y direction cargo)
  (inc-program-counter!))


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

(define (can-step? step)
  (let ((allowed-tiles '(* ! ^ v < >)))
  (if (even? direction)
    (let* (
      (next-x (+ (if (= 0 direction) step (- step)) x))
      (tile (vector-ref (vector-ref factory y) next-x)))
      (member tile allowed-tiles))

    (let* (
      (next-y (+ (if (= 3 direction) step (- step)) y))
      (tile (vector-ref (vector-ref factory next-y) x)))
      (member tile allowed-tiles)))))


; Function: step-loop
; Description: Tries to move the robot a distance while validating every step.
; Params:
;   distance = Total distance the robot should move.
;   step = The length of the steps. A negative number means backward movement.
;   do-step! = A function which shall update the robots state.

(define (step-loop distance step do-step!)
  (cond ((> distance 0)
    (cond ((can-step? step)
      (do-step!)
      (thread-sleep 500)
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
  (move distance 1)
  (inc-program-counter!))


; Function: move
; Description: Moves the robot backward in steps of 1.
; Params:
;   distance = Total distance the robot should move.
(define (move_backward distance)
  (move distance -1))


; Function: can-pick?
; Description: Checks if the robot can pick up the given item.
; Params:
;   name: The item which the robot wants to pick up.

(define (can-pick? name)
  (let
    ((tile (vector-ref (vector-ref factory y) x)))
      (cond 
        ((equal? tile 'v) (equal? name (vector-ref (vector-ref factory (- y 1)) x)))
        ((equal? tile '^) (equal? name (vector-ref (vector-ref factory (+ y 1)) x)))
        ((equal? tile '<) (equal? name (vector-ref (vector-ref factory (+ x 1)) x)))
        ((equal? tile '>) (equal? name (vector-ref (vector-ref factory (- x 1)) x)))
        (else #f))))


; Function: can-drop?
; Description: Checks if the robot is at the dropoff point.
; Params:

(define (can-drop?)
  (let
    ((tile (vector-ref (vector-ref factory y) x)))
      (cond
        ((equal? tile 'v) (equal? (- cargo 1) (vector-ref (vector-ref factory (+ y 1)) x)))
        ((equal? tile '^) (equal? (- cargo 1) (vector-ref (vector-ref factory (- y 1)) x)))
        ((equal? tile '<) (equal? (- cargo 1) (vector-ref (vector-ref factory (- x 1)) x)))
        ((equal? tile '>) (equal? (- cargo 1) (vector-ref (vector-ref factory (+ x 1)) x)))
        (else #f))))


; Function: pick_object
; Description: Tries to pick up an object.
; Params:
;   name = Name of object as a string

(define (pick_object name)
  (cond
    ((not (can-pick? name)) (log-error "The robot is not at the correct pick up point."))

    (else
      (set! cargo name)
      (thread-sleep 1000)
      (log x y direction cargo)
      (inc-program-counter!))))


; Function: drop_object
; Description: Drops what ever object is in the cargo.
; Params:

(define (drop_object)
  (cond
    ((not (can-drop?)) (log-error "The robot is not at the correct drop point."))

    (else
      (pick_object ""))))