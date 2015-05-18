(it-should "turn 90 deg left" (lambda ()
	(turn_left 1)
	(= direction 1)))

(it-should "turn 90 deg right" (lambda ()
	(turn_right 1)
	(= direction 3)))