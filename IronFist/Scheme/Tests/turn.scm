(it-should "turn -90 deg left" (lambda ()
	(= (get-dir (turn_left '(0 8 0 0) -1)) 3)))

(it-should "turn 0 deg left" (lambda ()
	(= (get-dir (turn_left '(0 8 0 0) 0)) 0)))

(it-should "turn 90 deg left" (lambda ()
	(= (get-dir (turn_left '(0 8 0 0) 1)) 1)))

(it-should "turn 180 deg left" (lambda ()
	(= (get-dir (turn_left '(0 8 0 0) 2)) 2)))

(it-should "turn 900 deg left" (lambda ()
	(= (get-dir (turn_left '(0 8 0 0) 10)) 2)))

(it-should "turn -90 deg right" (lambda ()
	(= (get-dir (turn_right '(0 8 0 0) -1)) 1)))

(it-should "turn 0 deg right" (lambda ()
	(= (get-dir (turn_right '(0 8 0 0) 0)) 0)))

(it-should "turn 90 deg right" (lambda ()
	(= (get-dir (turn_right '(0 8 0 0) 1)) 3)))

(it-should "turn 180 deg right" (lambda ()
	(= (get-dir (turn_right '(0 8 0 0) 2)) 2)))

(it-should "turn 900 deg right" (lambda ()
	(= (get-dir (turn_right '(0 8 0 0) 10)) 2)))