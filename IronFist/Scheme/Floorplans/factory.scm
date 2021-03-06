(define factory (vector 
         (vector '- '- '- '- '- '- '- '- '- '- '- '- '- '- '- '- '- '- '- '- '- '- '- '- '- '- '- '- '1 '1 '1 '-)
         (vector '- '- '- '- '* '* 'v '* '* '* '* '* '* '- '- '- '- '- '- '- '- '- '- '- '- '- '- '- '1 '1 '1 '-)
         (vector '- '- '- '- '- '2 '2 '2 '* '- '- '- '- '- '- '- '- '- '- '- '- '- '- '- '- '- '- '- '- 'v '- '-)
         (vector '- '- '- '- '- '2 '2 '2 '* '- '- '- '- '- '- '- '- '- '- '- '- '- '- '- '- '- '- '- '- '* '- '-)
         (vector '- '- '- '- '- '2 '2 '2 '> '- '- '- '- '- '- '- '- '- '- '- '- '- '- '- '- '- '- '- '- '* '- '-)
         (vector '- '- '- '- '- '- '- '- '* '- '- '- '- '- '- '- '- '- '- '- '- '- '- '- '- '- '- '- '- '* '- '-)
         (vector '- '- '- '- '- '- '- '- '* '- '- '- '- '- '- '- '- '- '- '- '- '- '- '- '- '- '- '- '- '* '- '-)
         (vector '/ '/ '/ '- '- '- '- '- '* '- '- '- '- '- '- '- '- '- '- '- '- '- '- '- '- '- '- '- '- '* '- '-)
         (vector '! '* '* '* '* '* '* '* '* '* '* '* '* '* '* '* '* '* '* '* '* '* '* '* '* '* '* '* '* '* '- '-)
         (vector '! '* '* '* '- '- '- '- '- '- '- '- '- '- '- '- '- '- '- '- '* '- '- '- '- '- '* '- '- '* '- '-)
         (vector '! '* '* '* '- '- '- '- '- '- '- '- '- '- '- '- '- '- '- '- '* '- '- '- '- '- '* '- '- '* '- '-)
         (vector '! '* '* '* '- '- '- '- '- '- '- '- '- '- '- '- '- '- '- '- '> '3 '3 '3 '3 '3 '> '- '- '* '- '-)
         (vector '! '* '* '* '- '- '- '- '- '- '- '- '- '- '- '- '- '- '- '- '* '- '- '- '- '- '* '- '- '* '- '-)
         (vector '! '* '* '* '* '* '* '* '* '* '* '* '* '* '* '* '* '* '* '* '* '* '* '* '* '* '* '* '* '* '- '-)
         (vector '! '* '* '* '- '- '- '- '- '- '- '- '- '- '- '- '- '- '- '- '- '* '- '- '- '- '- '- '- '* '- '-)
         (vector '/ '/ '/ '- '- '- '- '- '- '- '- '- '- '- '- '- '- '- '4 '4 '4 '< '- '- '- '- '- '- '- '* '- '-)
         (vector '- '- '- '- '- '- '- '- '- '- '- '- '- '- '- '- '- '- '4 '4 '4 '* '- '- '- '- '- '- '- '* '- '-)
         (vector '- '- '- '- '- '- '- '- '- '- '- '- '- '- '- '- '- '- '4 '4 '4 '* '- '- '- '- '- '- '- '* '- '-)
         (vector '- '- '- '- '- '- '- '- '- '- '- '- '- '- '- '- '- '- '4 '4 '4 '* '- '- '- '- '- '- '- '* '- '-)
         (vector '- '- '- '- '- '- '- '- '- '- '- '- '- '- '- '- '- '- '4 '4 '4 '> '- '- '- '- '- '- '- '* '- '-)
         (vector '- '- '- '- '- '- '- '- '- '- '- '- '- '- '- '- '- '- '- '- '- '* '- '- '- '- '- '- '- '* '- '-)
         (vector '- '- '- '- '- '- '- '- '- '- '- '- '- '- '- '- '- '- '- '- '- '- '- '- '- '- '- '- '- 'v '- '-)
         (vector '- '- '- '- '- '- '- '- '- '- '- '- '- '- '- '- '- '- '- '- '- '- '- '- '- '- '- '- '5 '5 '5 '-)
         (vector '- '- '- '- '- '- '- '- '- '- '- '- '- '- '- '- '- '- '- '- '- '- '- '- '- '- '- '- '5 '5 '5 '-)
        ))

(define (workstation-num id)
	(cond
		((= id 1) '(29 0))
		((= id 2) '(6 3))
		((= id 3) '(23 11))
		((= id 4) '(19 17))
		((= id 5) '(29 23))
	))

(define (get-tile x y)
  (vector-ref (vector-ref factory y) x))
