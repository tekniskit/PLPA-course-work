(include "Scheme/Floorplans/factory.scm")
(include "Scheme/log.scm")
(include "Scheme/move.scm")
(include "Scheme/turn.scm")
(include "Scheme/cargo.scm")

(define (get-x robot)
  (car robot))

(define (get-y robot)
  (car (cdr robot)))

(define (get-dir robot)
  (car (cdr (cdr robot))))

(define (get-cargo robot)
  (car (cdr (cdr (cdr robot)))))

(define (set-robot robot)
  (log robot)
  robot)

(define (set-pos robot x y)  
    (thread-sleep 500)
    (set-robot (list x y (get-dir robot) (get-cargo robot))))

(define (set-dir robot dir)
    (thread-sleep 250)
    (set-robot (list (get-x robot) (get-y robot) dir (get-cargo robot))))

(define (set-cargo robot cargo)
    (thread-sleep 1000)
    (set-robot (list (get-x robot) (get-y robot) (get-dir robot) cargo)))