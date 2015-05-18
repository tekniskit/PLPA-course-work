(it-should "move 0 steps forward on path" (lambda ()
	(move_forward 0)
	(= x 0)))

(it-should "move 1 step forward on path" (lambda ()
	(move_forward 1)
	(= x 1)))

(it-should "move 10 steps forward on path" (lambda ()
	(move_forward 10)
	(= x 10)))

(it-should "not leave designated paths while moving forward" (lambda ()
	(set! y 9)
	(move_forward 10)
	(= x 3)))

(it-should "be able to cross pick up points" (lambda ()
	(set! x 5)
	(set! y 1)
	(move_forward 2)
	(= x 7)))

(it-should "be able to cross drop off points" (lambda ()
	(set! x 8)
	(set! y 3)
	(set! direction 3)
	(move_forward 2)
	(= y 5)))

(it-should "not be able to move into workstation" (lambda ()
	(set! x 7)
	(set! y 1)
	(set! direction 3)
	(move_forward 1)
	(= y 1)))



(it-should "move 0 steps forward on path" (lambda ()
	(move_backward 0)
	(= x 0)))

(it-should "move 1 step forward on path" (lambda ()
	(set! direction 2)
	(move_backward 1)
	(= x 1)))

(it-should "move 10 steps forward on path" (lambda ()
	(set! direction 2)
	(move_backward 10)
	(= x 10)))

(it-should "not leave designated paths while moving forward" (lambda ()
	(set! direction 2)
	(set! y 9)
	(move_backward 10)
	(= x 3)))

(it-should "be able to cross pick up points" (lambda ()
	(set! x 5)
	(set! y 1)
	(set! direction 2)
	(move_backward 2)
	(= x 7)))

(it-should "be able to cross drop off points" (lambda ()
	(set! x 8)
	(set! y 3)
	(set! direction 1)
	(move_backward 2)
	(= y 5)))

(it-should "not be able to move into workstation" (lambda ()
	(set! x 7)
	(set! y 1)
	(set! direction 1)
	(move_backward 1)
	(= y 1)))