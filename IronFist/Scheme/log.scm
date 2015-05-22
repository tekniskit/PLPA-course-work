(define (write-file name content)
  (define file-handle (open-output-file name))
  (display content file-handle)
  (close-output-port file-handle))

(define (log robot)
  (write-file "log.txt" robot))

(define (log-prg-cnt prg-cnt)
  (write-file "program-counter.txt" prg-cnt))

(define (error robot msg)
  (write-file "error.txt" msg)
  robot)