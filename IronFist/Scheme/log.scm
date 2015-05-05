; Logging
(define log-filename "log.txt")
(define log-message
  (lambda (message)
    (define test-file (open-output-file log-filename))
    (display message test-file)
    (close-output-port test-file)
    ))

(define log-directions
  (lambda (x y d)
    (define test-file (open-output-file log-filename))
    (display (string-append  (number->string x) ";" (number->string y) ";" d ";") test-file)
    (close-output-port test-file)
    ))
