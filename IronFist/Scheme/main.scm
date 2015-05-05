(import (rnrs) (ironscheme))

; Load factory plan
(include "Scheme/Floorplans/factory.scm")
(include "Scheme/log.scm")

; -- TESTING

(define count 1)

(define increment
  (lambda ()
    (let ((v count))
      (set! count (+ count 1))
      v)))


; To be store in robot
(define x 0)
(define y 8)
(define direction "east")

; Test functions of what it more or less should return. The robot's state should be kept in a different way
(define MOVE_FORWARD
  (lambda ()
	(log-directions 1 8 "east")))

(define MOVE_BACKWARD
  (lambda ()
	(log-directions 2 8 "east")))
	
(define TURN_LEFT
  (lambda ()
	(log-directions 3 8 "east")))

(define TURN_RIGHT
  (lambda ()
	(log-directions 4 8 "east")))
	
(define DROP_OBJECT
  (lambda ()
	(log-directions 5 8 "east")))
	
(define PICK_OBJECT
  (lambda ()
	(log-directions 6 8 "east")))



; ----------- Reimers old stuff
;#lang racket

;(require "factory.scm")
;(require "direction.scm")

;(define (call obj method args)
;  (apply (cdr (assq method obj)) args))

;(define direction (create-direction 2))

;(call direction 'turn_left '(1))
;(call direction 'turn_left '(1))
;(call direction 'turn_left '(1))
;(call direction 'turn_left '(1))