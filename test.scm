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



;; Notes from Ch 1.2
;; Define a recursive factorial function
;; n! = n * (n-1)!
;; (factorial 3)
;; (* 3 (factorial 2))
;; (* 3 (* 2 (factorial 1)))
;; (* 3 (* 2 1))
;; (* 3 2)
;; 6
;; The length of the chain of deferred computations grows linearly with n, so we
;; say it's a linear recursive process. 
(define (factorial n)
  (if (= n 1)
    1  ; Need to use this in a deferred computation
    (* n (factorial (- n 1)))))

(factorial 6)  ; 720

;; Define an iterative factorial function (via a recursive procedure that generates an
;; iterative process)
;; Based on idea that n! can be calculated by iteratively doing 1*2*3*4...*n
;; (factorial-iter 3)
;; (fact-iter 3)
;; (fact-iter 1 1)
;; (fact-iter 1 2)
;; (fact-iter 2 3)
;; (fact-iter 6 4)
;; 6
;; This is linear iterative process, even though it's a recursive function. The
;; interpreter need only keep track of what variales are being passed to each
;; successive call. No stack needed. No deferred computations.

(define (factorial-iter n)
  (define (fact-iter product count)
    (if (> count n)
      product  ; Don't need to compute with this.
      (fact-iter (* product count)
                 (+ count 1))))
  (fact-iter 1 1))

(factorial-iter 6)


;; Exercise 1.9
;; Two procedures, one iterative and one recursive (in terms of process) for
;; adding two positive integers. Based on inc and dec which increment and
;; decrement by 1. Describe their processes.
;; RECURSIVE
(define (+ a b)
  (if (= a 0)
    b
    (inc (+ (dec a) b))))
;; (+ 3 4)
;; (inc (+ 2 4))
;; (inc (inc (+ 1 4)))
;; (inc (inc (inc (+ 0 4))))
;; (inc (inc (inc (4))))
;; (inc (inc 5))
;; (inc 6)
;; 7
;; ITERATIVE
(define (+ a b)
  (if (= a 0)
    b
    (+ (dec a) (inc b))))
;; (+ 3 4)
;; (+ 2 5)
;; (+ 1 6)
;; (+ 0 7)
;; 7



