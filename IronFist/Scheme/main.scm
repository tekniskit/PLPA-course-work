(import (ironscheme threading) (ironscheme linq))

(include "Scheme/robot.scm")

(define (exec-prg robot cmds prg-cnt)
  (if (empty? cmds)
      robot
      (let ((fnc (caar cmds))
             (params (cdar cmds)))
        (log-prg-cnt prg-cnt)
        (exec-prg (if (empty? params)
                      (fnc robot)
                      (fnc robot (car params)))
                  (cdr cmds)
                  (+ 1 prg-cnt)))))

(define (run robot cmds)
  (log robot)
  (exec-prg robot cmds 0))