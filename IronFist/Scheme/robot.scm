(include "Scheme/log.scm")

; Internal robot state
(define x 0)
(define y 0)
(define direction 0) ; 0 = east, 1 = north, 2 = west, 3 = south
(define cargo "") ; Name of an object as a string


; Function: turn_left
; Description: Turns the robot to the left
; Params:
;   turns = number of 90deg left turns

(define (turn_left turns) 
  (set! direction (modulo (+ direction turns) 4))
  (log x y direction cargo))


; Function: turn_right
; Description: Turns the robot to the right
; Params:
;   turns = number of 90deg right turns

(define (turn_right turns)
  (turn_left (- turns))) ; A right turn is a negative left turn


; Function: step_loop
; Description: Tries to move the robot a distance while validating every step.
; Params:
;   distance = Total distance the robot should move.
;   step = The length of the steps. Must be a non-zero positive integer.
;   do-step! = A function which shall update the robots state.

(define (step_loop distance step-length do-step!)
  (cond ((> distance 0)
         (do-step!)
         (log x y direction cargo)
         (step_loop (- distance step-length) step-length do-step!))))


; Function: move
; Description: Tries to move the robot a distance in the direction it is pointing.
; Params:
;   distance = Total distance the robot should move.
;   step = The length of the steps. A negative number means backward movement.

(define (move distance step)
  (step_loop distance (abs step)
             (if (even? direction)
                  (lambda () (set! x (+ (if (= 0 direction) step (- step)) x)))
                  (lambda () (set! y (+ (if (= 3 direction) step (- step)) y))))))


; Function: move_forward
; Description: Moves the robot forward in steps of 1.
; Params:
;   distance = Total distance the robot should move.

(define (move_forward distance)
  (move distance 1))


; Function: move
; Description: Moves the robot backward in steps of 1.
; Params:
;   distance = Total distance the robot should move.
(define (move_backward distance)
  (move distance -1))


; Function: pick_object
; Description: Tries to pick up an object.
; Params:
;   name = Name of object as a string

(define (pick_object name)
  (set! cargo name)
  (log x y direction cargo))


; Function: drop_object
; Description: Drops what ever object is in the cargo.
; Params:

(define (drop_object)
  (pick_object ""))


