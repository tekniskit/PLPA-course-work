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
    (if (and
	      (= (get-cargo robot) 0)
		  (at-workstation? (get-x robot) (get-y robot) id 1))
      (set-cargo robot id)
      (error robot "The robot is not at the correct pick up point.")))

(define (drop_object robot)
  (if (and
        (> (get-cargo robot) 0)
        (at-workstation? (get-x robot) (get-y robot) (+ (get-cargo robot) 1) -1))
          (set-cargo robot 0)
          (error robot "The robot is not at the correct drop off point.")))