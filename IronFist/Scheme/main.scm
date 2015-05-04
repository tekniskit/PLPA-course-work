; Load factory plan
(include "Scheme/Floorplans/factory.scm")
(include "Scheme/log.scm")


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