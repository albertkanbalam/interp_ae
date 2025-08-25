#lang plai

(require (file "./grammars.rkt"))
(require (file "./parser.rkt"))


(define (subst-single bind s-exp)
  (type-case Binding bind
             [binding (id val)
                      (subst s-exp id val)]

             )
  )

(define (subst-list lst sub-id value)
  (match lst
    ['() lst]
    [(cons x xs) (cons
                  (subst x sub-id value)
                  (subst-list xs sub-id value))]
    )
  )

;; subst: AST symbol AST -> AST
(define (subst expr sub-id value)
  (type-case WAE expr
             [num (n)
                  expr]

             [op (f args)
                 (op f (subst-list args sub-id value))]
             
             [with (bindings w-body)
                   (display "with no permitido")]
             
             [id (v)
                 (if (symbol=? v sub-id)
                     value
                     expr)]
             )
  )

;; interp: AST -> number
 (define (interp expr)
  (type-case WAE expr
             [num (n)
                  n]
             
             [op (f args)
                 (if (or (equal? f +)
                         (equal? f -)
                         (equal? f *)
                         (equal? f /)
                         (equal? f modulo)
                         (equal? f expt)
                         (equal? f add1)
                         (equal? f sub1))
                     (apply f (map interp args))
                     (error 'interp "operador no permitido"))]

             [with (bindings body)
                   (interp (foldr subst-single body bindings))]

             [id (i)
                 (error 'interp "variable libre")]
             )
  )

