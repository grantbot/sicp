;;; Answers to exercises in Ch 1

;;; Ch1 Section1: The Elements of Programming
;; ex 1.3
;; Define a procedure that takes 3 numbers and returns the sum of squares of
;; the larger two.
(define (square x) (* x x))


(define (sum-of-squares x y) 
  (+ (square x) (square y)))


(define (square-largest-two x y z)
  (if (>= x y)
    (sum-of-squares x (if (>= y z) y z))
    (sum-of-squares y (if (>= x z) x z))))

;; tests
(square-largest-two 1 2 3)  ; 13
(square-largest-two 1 2 2)  ; 8
(square-largest-two 2 2 2)  ; 8


;; ex 1.4
;; Operators can be compound expressions!
(define (a-plus-abs-b a b)
  ((if (> b 0) + -) a b))

;; tests
(a-plus-abs-b 1 2)   ; 3
(a-plus-abs-b 1 -2)  ; 3

;; ex 1.6
;; Redefining 'if'
;; 'if' is a special form--it first evaluates the predicate, and then
;; decides from there whether to evaluate the consequent or alternative
;; expression. Thus, if we re-define if like so:
(define (new-if predicate then-clause else-clause)
  (cond (predicate then-clause)
        (else else-clause)))
;; ...and try it in the recursive sqrt function:
(define (sqr-iter guess x)
  (new-if (good-enough? guess x)
          guess
          (sqrt-iter (improve guess x) x)))
;; ...new-if is a normal procedure, which means both arguments are evaled
;; before anything else, which means infinite loop on the recursive 
;; sqrt-iter call, infinitely improving the guess with no end condition.
;; Thus, 'if' is a special form for a really good reason. It MUST be
;; if one of the predicates is a recursive call. 


;; ex 1.7

