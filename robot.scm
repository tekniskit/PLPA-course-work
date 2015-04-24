#lang racket

(require "factory.rkt")
(require "turn.rkt")

(define (call obj method args)
  (apply (cdr (assq method obj)) args))

(define direction (create-direction 2))

(call direction 'turn_left '(1))
(call direction 'turn_left '(1))
(call direction 'turn_left '(1))
(call direction 'turn_left '(1))