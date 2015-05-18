(define msgs '())

(define (set-up)
	(reset-robot!))

(define (clear-test-log)
  (define file-handle (open-output-file "test-results.txt"))
  (display "")
  (close-output-port file-handle))

(define (log-results msgs)
  (define file-handle (open-output-file "test-results.txt"))
  (display (string-join msgs "\n") file-handle)
  (close-output-port file-handle))

(define (log-result msg)
	(set! msgs (append msgs '(msg))))

(define (it-should description test)
	(set-up)
	(if (test)
		(log-result (string-append "Passed - " description))
		(log-result (string-append "Failed - " description))))


(clear-test-log)

(include "Scheme/Tests/turn.scm")
(include "Scheme/Tests/move.scm")
(include "Scheme/Tests/cargo.scm")

(log-results msgs)