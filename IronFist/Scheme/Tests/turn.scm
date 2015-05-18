(it-should "turn -90 deg left" (lambda ()
	(turn_left -1)
	(= direction 3)))

(it-should "turn 0 deg left" (lambda ()
	(turn_left 0)
	(= direction 0)))

(it-should "turn 90 deg left" (lambda ()
	(turn_left 1)
	(= direction 1)))

(it-should "turn 180 deg left" (lambda ()
	(turn_left 2)
	(= direction 2)))

(it-should "turn 900 deg left" (lambda ()
	(turn_left 10)
	(= direction 2)))

(it-should "turn -90 deg right" (lambda ()
	(turn_right -1)
	(= direction 1)))

(it-should "turn 0 deg right" (lambda ()
	(turn_right 0)
	(= direction 0)))

(it-should "turn 90 deg right" (lambda ()
	(turn_right 1)
	(= direction 3)))

(it-should "turn 180 deg right" (lambda ()
	(turn_right 2)
	(= direction 2)))

(it-should "turn 900 deg right" (lambda ()
	(turn_right 10)
	(= direction 2)))