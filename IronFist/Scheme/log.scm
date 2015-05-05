; Function: log
; Description: Logs x, y, direction and cargo to log.txt in the format: {x};{y};{direction};{cargo}\n\r

(define (log x y direction cargo) 
  (define test-file (open-output-file "log.txt"))
  (display (string-append (number->string x) ";" (number->string y) ";" (number->string direction) ";" cargo "\n\r"))
  (display (string-append (number->string x) ";" (number->string y) ";" (number->string direction) ";" cargo "\n\r") test-file)
  (close-output-port test-file))
