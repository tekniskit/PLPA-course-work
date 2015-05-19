#lang racket

;(import (ironscheme threading) (ironscheme linq))
(include "Floorplans/factory.scm")

(define (get-x robot)
  (car robot))

(define (get-y robot)
  (car (cdr robot)))

(define (set-robot robot)
  (displayln robot)
  robot)

(define (set-pos robot x y)  
    (thread-sleep 500)
    (set-robot (list x y (get-dir robot) (get-cargo robot))))

(define (get-dir robot)
  (car (cdr (cdr robot))))

(define (set-dir robot dir)
    (thread-sleep 250)
    (set-robot (list (get-x robot) (get-y robot) dir (get-cargo robot))))

(define (get-cargo robot)
  (car (cdr (cdr (cdr robot)))))

(define (set-cargo robot cargo)
    (thread-sleep 1000)
    (set-robot (list (get-x robot) (get-y robot) (get-dir robot) cargo)))

(define (get-tile x y)
  (vector-ref (vector-ref factory y) x))

(define (log-error msg)
  (displayln msg))

(define (inc-program-counter!)
  (write "inc"))

(define (thread-sleep ms)
  (write "sleep"))

(define (move robot distance forward?)
  (let* ((x (get-x robot))
         (y (get-y robot))
         (dir (get-dir robot))
         (next-x (if (even? dir) (+ x (* forward? (if (= 0 dir) 1 -1))) x))
         (next-y (if (odd? dir) (+ y (* forward? (if (= 3 dir) 1 -1))) y)))
    
    (if (> distance 0)  
           (if (and (>= next-y 0) (< next-y (vector-length factory))
                    (>= next-x 0) (< next-x (vector-length (vector-ref factory next-y)))
                    (member (get-tile next-x next-y) '(* ! ^ v < >)))
               
               (move (set-pos robot next-x next-y) (- distance 1) forward?)
               (log-error "Illegal move. Robot stopped."))
           robot)))

(define (move_forward robot distance)
  (move robot distance 1))

(define (move_backward robot distance)
  (move robot distance -1))

(define (turn_left robot turns)
  (set-dir robot (modulo (+ (get-dir robot) turns) 4)))

(define (turn_right robot turns)
  (turn_left robot (- turns)))

(define (at-workstation? x y id dir)
  (let
    ((tile (get-tile x y)))
      (cond
        ((eqv? tile 'v) (eqv? id (get-tile x (- y dir))))
        ((eqv? tile '^) (eqv? id (get-tile x (+ y dir))))
        ((eqv? tile '<) (eqv? id (get-tile (+ x dir) y)))
        ((eqv? tile '>) (eqv? id (get-tile (- x dir) y)))
        (else #f))))

(define (pick_object robot id)    
    (if (and (= (get-cargo robot) 0) (at-workstation? (get-x robot) (get-y robot) id 1))
      (set-cargo robot id)
      (log-error "The robot is not at the correct pick up point.")))

(define (drop_object robot)
  (if (and (> (get-cargo robot) 0) (at-workstation? (get-x robot) (get-y robot) (+ (get-cargo robot) 1) -1))
      (set-cargo robot 0)
      (log-error "The robot is not at the correct drop off point.")))

(define (exec-cmd robot cmd)
  (let (
        (fnc (car cmd))
        (params (cdr cmd)))
    
    (if (empty? params)
        (fnc robot)
        (fnc robot (car params)))))

(define (run robot cmds)
  (cond 
    ((empty? cmds) robot)
    (else
     (inc-program-counter!)
     (run (exec-cmd robot (car cmds)) (cdr cmds)))))

(run (list 0 8 0 0) (list
	(list move_forward 29)
	(list turn_left 1)
	(list move_forward 6)
	(list pick_object 1)
	(list turn_right 2)
	(list move_forward 6)
	(list turn_right 1)
	(list move_forward 21)
	(list turn_right 1)
	(list move_forward 7)
	(list turn_left 1)
	(list move_forward 2)
	(list drop_object)
	(list turn_left 2)
	(list move_forward 2)
	(list turn_right 1)
	(list move_forward 3)
	(list pick_object 2)
	(list move_forward 4)
	(list turn_left 1)
	(list move_forward 12)
	(list turn_right 1)
	(list move_forward 3)
	(list drop_object)
	(list move_forward 2)
	(list turn_left 1)
	(list move_forward 6)
	(list turn_left 1)
	(list move_forward 2)
	(list pick_object 3)
	(list turn_left 2)
	(list move_forward 2)
	(list turn_right 1)
	(list move_forward 5)
	(list turn_left 1)
	(list move_forward 2)
	(list drop_object)
	(list move_forward 4)
	(list pick_object 4)
	(list turn_left 2)
	(list move_forward 6)
	(list turn_right 1)
	(list move_forward 8)
	(list turn_right 1)
	(list move_forward 8)
	(list drop_object)))