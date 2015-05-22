(it-should "move 0 steps forward on path" (lambda ()
	(= (get-x (move_forward '(0 8 0 0) 0)) 0)))

(it-should "move 1 step forward on path" (lambda ()
	(= (get-x (move_forward '(0 8 0 0) 1)) 1)))

(it-should "move 10 steps forward on path" (lambda ()
	(= (get-x (move_forward '(0 8 0 0) 10)) 10)))

(it-should "not leave designated paths while moving forward" (lambda ()
	(= (get-x (move_forward '(0 9 0 0) 10)) 3)))

(it-should "be able to cross pick up points" (lambda ()
	(= (get-x (move_forward '(5 1 0 0) 2)) 7)))

(it-should "be able to cross drop off points" (lambda ()
	(= (get-y (move_forward '(8 3 3 0) 2)) 5)))

(it-should "not be able to move into workstation" (lambda ()
	(= (get-y (move_forward '(7 1 3 0) 1)) 1)))

(it-should "move 0 steps backward on path" (lambda ()
	(= (get-x (move_backward '(0 8 0 0) 0)) 0)))

(it-should "move 1 step backward on path" (lambda ()
	(= (get-x (move_backward '(0 8 2 0) 1)) 1)))

(it-should "move 10 steps backward on path" (lambda ()
	(= (get-x (move_backward '(0 8 2 0) 10)) 10)))

(it-should "not leave designated paths while moving backward" (lambda ()
	(= (get-x (move_backward '(0 9 2 0) 10)) 3)))

(it-should "be able to cross pick up points" (lambda ()
	(= (get-x (move_backward '(5 1 2 0) 2)) 7)))

(it-should "be able to cross drop off points" (lambda ()
	(= (get-y (move_backward '(8 3 1 0) 2)) 5)))

(it-should "not be able to move into workstation" (lambda ()
	(= (get-y (move_backward '(7 1 1 0) 1)) 1)))