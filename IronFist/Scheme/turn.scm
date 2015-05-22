(define (turn_left robot turns)
  (set-dir robot (modulo (+ (get-dir robot) turns) 4)))

(define (turn_right robot turns)
  (turn_left robot (- turns)))