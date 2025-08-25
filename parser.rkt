#lang plai

(require (file "./grammars.rkt"))


(define (bind s-exp)
  (if (list? s-exp)
      (binding (first s-exp) (parse (second s-exp)))
      (error 'parse "expresión mal formada"))
  )


;; parse: s-expression -> AE
(define (parse s-exp)
  (cond

    ;; Expresión (num s-num) a partir de s-num
    [(number? s-exp)
     (num s-exp)]
    
    ;; Expresión (id s-id) a partir de s-id
    [(symbol? s-exp)
     (id s-exp)]
    
    [(list? s-exp)
     (case (car s-exp)

       ;; Expresión (op s-op (list s-arg1 s-arg2...))
       ;; a partir de '{s-op s-arg1 s-arg2...}
       ;;
       ;; Map entre nuestra sintaxis concreta y los
       ;; operadores de Racket para los símbolos:
       ;; +, -, *, /, add1, sub1, expt, modulo

       ;; '{+ n1 n2 n3...}
       ['+
        (op + (parse (cdr s-exp)))]

       ;; '{- n1 n2 n3...}
       ['-
        (op - (parse (cdr s-exp)))]

       ;; '{* n1 n2 n3...}
       ['*
        (op * (parse (cdr s-exp)))]

       ;; '{/ n1 n2 n3...}
       ['/
        (op / (parse (cdr s-exp)))]

       ;; '{expt n1 n2}
       ['expt
        (op expt (parse (cdr s-exp)))]

       ;; '{modulo n1 n2}
       ['modulo
        (op modulo (parse (cdr s-exp)))]

       ;; '{add1 n1}
       ['add1
        (op add1 (parse (cdr s-exp)))]

       ;; '{sub1 n1}
       ['sub1
        (op sub1 (parse (cdr s-exp)))]

       ;; Expresión (with (list (binding s-id1 s-v1)
       ;;                       (binding s-id2 s-v2)... )
       ;;                  s-body)
       ;; a partir de
       ;; '{with {{s-id1 s-v1} {s-id2 s-v2}...} s-body}
       ['with
        (with (map bind (second s-exp)) (parse (third s-exp)))]

       [else
         (map parse s-exp)]
       )
     ]
    )
  )
