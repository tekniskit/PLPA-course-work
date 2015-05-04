;#lang racket

;(provide factory)

(define factory (vector 
         (vector '- '- '- '- '- '- '- '- '- '- '- '- '- '- '- '- '- '- '- '- '- '- '- '- '- '- '- '- '0 '0 '0 '-)
         (vector '- '- '- '- '* '* 'v '* '* '* '* '* '* '- '- '- '- '- '- '- '- '- '- '- '- '- '- '- '0 '0 '0 '-)
         (vector '- '- '- '- '- '1 '1 '1 '* '- '- '- '- '- '- '- '- '- '- '- '- '- '- '- '- '- '- '- '- 'v '- '-)
         (vector '- '- '- '- '- '1 '1 '1 '* '- '- '- '- '- '- '- '- '- '- '- '- '- '- '- '- '- '- '- '- '* '- '-)
         (vector '- '- '- '- '- '1 '1 '1 '> '- '- '- '- '- '- '- '- '- '- '- '- '- '- '- '- '- '- '- '- '* '- '-)
         (vector '- '- '- '- '- '- '- '- '* '- '- '- '- '- '- '- '- '- '- '- '- '- '- '- '- '- '- '- '- '* '- '-)
         (vector '- '- '- '- '- '- '- '- '* '- '- '- '- '- '- '- '- '- '- '- '- '- '- '- '- '- '- '- '- '* '- '-)
         (vector '/ '/ '/ '- '- '- '- '- '* '- '- '- '- '- '- '- '- '- '- '- '- '- '- '- '- '- '- '- '- '* '- '-)
         (vector 's '* '* '* '* '* '* '* '* '* '* '* '* '* '* '* '* '* '* '* '* '* '* '* '* '* '* '* '* '* '- '-)
         (vector '! '* '* '* '- '- '- '- '- '- '- '- '- '- '- '- '- '- '- '- '* '- '- '- '- '- '* '- '- '* '- '-)
         (vector '! '* '* '* '- '- '- '- '- '- '- '- '- '- '- '- '- '- '- '- '* '- '- '- '- '- '* '- '- '* '- '-)
         (vector '! '* '* '* '- '- '- '- '- '- '- '- '- '- '- '- '- '- '- '- '> '2 '2 '2 '2 '2 '> '- '- '* '- '-)
         (vector '! '* '* '* '- '- '- '- '- '- '- '- '- '- '- '- '- '- '- '- '* '- '- '- '- '- '* '- '- '* '- '-)
         (vector '! '* '* '* '* '* '* '* '* '* '* '* '* '* '* '* '* '* '* '* '* '* '* '* '* '* '* '* '* '* '- '-)
         (vector '! '* '* '* '- '- '- '- '- '- '- '- '- '- '- '- '- '- '- '- '- '* '- '- '- '- '- '- '- '* '- '-)
         (vector '/ '/ '/ '- '- '- '- '- '- '- '- '- '- '- '- '- '- '- '3 '3 '3 '< '- '- '- '- '- '- '- '* '- '-)
         (vector '- '- '- '- '- '- '- '- '- '- '- '- '- '- '- '- '- '- '3 '3 '3 '* '- '- '- '- '- '- '- '* '- '-)
         (vector '- '- '- '- '- '- '- '- '- '- '- '- '- '- '- '- '- '- '3 '3 '3 '* '- '- '- '- '- '- '- '* '- '-)
         (vector '- '- '- '- '- '- '- '- '- '- '- '- '- '- '- '- '- '- '3 '3 '3 '* '- '- '- '- '- '- '- '* '- '-)
         (vector '- '- '- '- '- '- '- '- '- '- '- '- '- '- '- '- '- '- '3 '3 '3 '> '- '- '- '- '- '- '- '* '- '-)
         (vector '- '- '- '- '- '- '- '- '- '- '- '- '- '- '- '- '- '- '- '- '- '* '- '- '- '- '- '- '- '* '- '-)
         (vector '- '- '- '- '- '- '- '- '- '- '- '- '- '- '- '- '- '- '- '- '- '- '- '- '- '- '- '- '- 'v '- '-)
         (vector '- '- '- '- '- '- '- '- '- '- '- '- '- '- '- '- '- '- '- '- '- '- '- '- '- '- '- '- '4 '4 '4 '-)
         (vector '- '- '- '- '- '- '- '- '- '- '- '- '- '- '- '- '- '- '- '- '- '- '- '- '- '- '- '- '4 '4 '4 '-)
        ))
