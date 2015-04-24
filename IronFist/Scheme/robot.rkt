;(define ns (make-base-namespace))

;(include "factory.rkt")
;(include "turn.rkt")
(include "Scheme/move.rkt")

;; Write to a text file test
(call-with-output-file "log.txt"
  (lambda (output-port)
    (display "hello, world" output-port))) ;; or (write "hello, world" output-port)