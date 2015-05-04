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

(define MOVE_FORWARD
  (lambda ()
    (increment)
	(thread-sleep 1000)))

(define MOVE_BACKWARD
  (lambda ()
    (increment)
	(thread-sleep 1000)))


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