(import (ironscheme threading) (ironscheme linq))

(include "Scheme/Floorplans/factory.scm")
(include "Scheme/log.scm")
(include "Scheme/robot.scm")
(include "Scheme/move.scm")
(include "Scheme/turn.scm")
(include "Scheme/cargo.scm")

(define (exec-prg robot cmds prg-cnt)
  (if (empty? cmds)
      robot
      (let* ((cmd (car cmds))
             (fnc (car cmd))
             (params (cdr cmd)))
        (log-prg-cnt prg-cnt)
        (exec-prg (if (empty? params)
                      (fnc robot)
                      (fnc robot (car params)))
                  (cdr cmds)
                  (+ 1 prg-cnt)))))

(define (run robot cmds)
  (log robot)
  (exec-prg robot cmds 0))