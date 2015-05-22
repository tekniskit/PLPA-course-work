(it-should "pick up object 1 at workstation 1" (lambda ()
	(= (get-cargo (pick_object '(29 2 0 0) 1)) 1)))

(it-should "not pick up object 2 at workstation 1" (lambda ()
	(= (get-cargo (pick_object '(29 2 0 0) 2)) 0)))

(it-should "not pick up object 1 outside pick up point" (lambda ()
	(= (get-cargo (pick_object '(0 8 0 0) 1)) 0)))

(it-should "drop object 1 at workstation 2" (lambda ()
	(= (get-cargo (drop_object '(6 1 0 1))) 0)))

(it-should "not drop object 2 at workstation 2" (lambda ()
	(= (get-cargo (drop_object '(6 1 0 2))) 2)))

(it-should "not drop object outside drop off point" (lambda ()
	(= (get-cargo (drop_object '(0 8 0 2))) 2)))