; Function: log
; Description: Logs x, y, direction and cargo to log.txt in the format: {x};{y};{direction};{cargo}\n\r

(define (log x y direction cargo) 
  (define file-handle (open-output-file "log.txt"))
  (display (string-append (number->string x) ";" (number->string y) ";" (number->string direction) ";" cargo "\n\r") file-handle)
  (close-output-port file-handle))



(define counter 0)

(define (inc-program-counter!)
  (define file-handle (open-output-file "program-counter.txt"))
  (set! counter (+ 1 counter))
  (display counter file-handle)
  (close-output-port file-handle))