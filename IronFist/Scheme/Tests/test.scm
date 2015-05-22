(include "Scheme/main.scm")

(define msgs "")

(define (log-results msgs)
  (define file-handle (open-output-file "test-results.txt"))
  (display msgs file-handle)
  (close-output-port file-handle))

(define (save-result msg)
	(displayln msg)
	(set! msgs (string-append msgs msg "\n")))

(define (it-should description test)
	(if (test)
		(save-result (string-append "Passed - It should " description))
		(save-result (string-append "Failed - It should " description))))


(log-results "")

(include "Scheme/Tests/turn.scm")
(include "Scheme/Tests/move.scm")
(include "Scheme/Tests/cargo.scm")

(log-results msgs)