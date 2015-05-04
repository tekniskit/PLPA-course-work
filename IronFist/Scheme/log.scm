; Logging
(define log-filename "log.txt")
(define log-message
  (lambda (message)
    (define test-file (open-output-file log-filename))
    (display message test-file)
    (close-output-port test-file)
    ))