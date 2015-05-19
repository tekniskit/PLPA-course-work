#lang racket

;(import (ironscheme threading) (ironscheme linq))
(include "Floorplans/factory.scm")

(define (get-tile x y)
  (vector-ref (vector-ref factory y) x))

(define (allowed-move? x y)
    (and (>= y 0) (< y (vector-length factory))
         (>= x 0) (< x (vector-length (vector-ref factory y)))
         (member (get-tile x y) '(* ! ^ v < >))))

(define (move x y dir cargo distance forward?)
  (let (
        (next-x (if (even? dir) (+ x (* forward? (if (= 0 dir) 1 -1))) x))
        (next-y (if (odd? dir) (+ y (* forward? (if (= 3 dir) 1 -1))) y))
    )
  (if (> distance 0)
      (if (allowed-move? next-x next-y)
          (move next-x next-y dir cargo (- distance 1))
          (log-error "Illegal move. Robot stopped."))
      '(x y dir cargo))))

(define (move_forward x y dir cargo distance)
  (move x y dir cargo distance 1))

(define (move_backward x y dir cargo distance)
  (move x y dir cargo distance -1))

(define (turn_left x y dir cargo turns)
  (list x y (modulo (+ dir turns) 4) cargo))

(define (turn_right x y dir cargo turns)
  (turn_left x y dir cargo (- turns)))


(define (pick_object x y dir cargo id)
  (if (and (= cargo 0) (can-pick? id))
      '(x y dir id)
      (log-error "The robot is not at the correct pick up point.")))

(define (drop_object robot)
  robot)

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
     (thread-sleep 500)
     (log robot)
     (run (exec-cmd robot (car cmds)) (cdr cmds)))))

(run (vector 0 8 0 0) (list
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