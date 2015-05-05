
(provide log)

(define (log x y direction cargo)
  (define test-file (open-output-file "log.txt"))
  (display (string-append (number->string x) ";" (number->string y) ";" (number->string direction) ";" cargo "\n\r") test-file)
  (close-output-port test-file))