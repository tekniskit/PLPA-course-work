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