(define msgs "")

(define (clear-test-log)
  (define file-handle (open-output-file "test-results.txt"))
  (display "")
  (close-output-port file-handle))

(define (log-results msgs)
  (define file-handle (open-output-file "test-results.txt"))
  (display msgs file-handle)
  (close-output-port file-handle))

(define (log-result msg)
	(set! msgs (string-append msgs msg "\n")))

(define (it-should description test)
	(reset-robot!)
	(if (test)
		(log-result (string-append "Passed - It should " description))
		(log-result (string-append "Failed - It should " description))))


(clear-test-log)

(include "Scheme/Tests/turn.scm")
(include "Scheme/Tests/move.scm")
(include "Scheme/Tests/cargo.scm")

(reset-robot!)
(log-results msgs)