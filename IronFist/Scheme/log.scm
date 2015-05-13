; Function: log
; Description: Logs x, y, direction and cargo to log.txt in the format: {x};{y};{direction};{cargo}\n\r

(define (log x y direction cargo) 
  (define file-handle (open-output-file "log.txt"))
  (display (string-append (number->string x) ";" (number->string y) ";" (number->string direction) ";" cargo "\n\r") file-handle)
  (close-output-port file-handle))


; Function: inc-program-counter!
; Description: Increments and logs an integer to program-counter.txt.
;              First time the function is called it logs 1. Second time it logs 2.

(define counter -1)

(define (inc-program-counter!)
  (define file-handle (open-output-file "program-counter.txt"))
  (set! counter (+ 1 counter))
  (display counter file-handle)
  (close-output-port file-handle))


; Function: reset-program-counter!
; Description: Resets the program counter.

(define (reset-program-counter!)
  (set! counter -1))

; Function: log-error
; Description: Logs an error message to error.txt.

(define (log-error msg)
  (define file-handle (open-output-file "error.txt"))
  (display msg file-handle)
  (close-output-port file-handle))