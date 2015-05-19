(import (ironscheme threading) (ironscheme linq))

(include "Scheme/Floorplans/factory.scm")
(include "Scheme/log.scm")
(include "Scheme/robot.scm")
(include "Scheme/move.scm")
(include "Scheme/turn.scm")
(include "Scheme/cargo.scm")

(define (exec-prg robot cmds prg-cnt)
  (let ((cmd (car cmds))
        (fnc (car cmd))
        (params (cdr cmd)))
    
    (if (empty? cmds)
        robot
        (exec-prg (if (empty? params)
                      (fnc robot)
                      (fnc robot (car params))) (cdr cmds)))
    
    (log-prg-cnt (+ 1 prg-cnt))))

(define (run robot cmds)
  (exec-prg robot cmds 0))