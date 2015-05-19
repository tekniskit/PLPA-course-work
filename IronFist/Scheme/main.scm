(import (ironscheme threading) (ironscheme linq))

(include "Scheme/Floorplans/factory.scm")
(include "Scheme/log.scm")
(include "Scheme/robot.scm")
(include "Scheme/move.scm")
(include "Scheme/turn.scm")
(include "Scheme/cargo.scm")

(define (exec-cmd robot cmd)
  (let ((fnc (car cmd))
        (params (cdr cmd)))
    
    (if (empty? params)
        (fnc robot)
        (fnc robot (car params)))))

(define (exec-cmds robot cmds prg-cnt)
  (cond
    ((empty? cmds) robot)
    (else
     (log-prg-cnt (+ 1 prg-cnt))
     (run (exec-cmd robot (car cmds)) (cdr cmds)))))

(define (run robot cmds)
  (exec-cmds robot cmds 0))