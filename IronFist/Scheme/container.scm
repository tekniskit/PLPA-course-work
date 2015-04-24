#lang racket

(provide pick_object)
(provide drop_object)

(define container -1)

(define (isEmpty?) (= container -1))
(define (atPickup?) #t)
(define (atDropoff?) #t)

(define (pick_object obj)
  (if (and (atPickup?) (isEmpty?))
        (set! container obj)
        (error "Can't pickup object")))

(define (drop_object)
  (if (and (atDropoff?) (not (isEmpty?)))
        (set! container -1)
        (error "Can't drop object")))
