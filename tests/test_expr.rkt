#lang plai

(require (file "../grammars.rkt"))
(require (file "../parser.rkt"))
(require (file "../interp.rkt"))

(display "   >>> Test sintaxis abstracta...\n")
(op add1 (list (num 1) (num 2) (num 3) ))
(op expt (list (num 1) (num 2) (num 3) ))
(op + (list (num 1) (num 2) (num 3) (num 4) (num 5)))

(display "\n   >>> Test parse...\n")
(parse '{+ {- 2 1} {- 3 2}})
(parse '{+ {+ 1 2} 3 4 5})
(parse '{add1 4})
(parse '{modulo 10 2 3 4 5})
(parse '{with {{a 5}} {+ a a}})
(parse '{with {{a 5} {b 6}} {+ a b}})

(display "\n   >>> Test interp...\n")
(interp (num 5))
(interp (parse '{+ 1 1 1}))
(interp (parse '{modulo 10 2}))
(interp (parse '{with {{a 1} {b 2} {c 3}} {+ {- c b} a b c}}))
(interp (parse '{with {{a {+ 1 1}} {b 2} {c 3}} {expt {- c b} {+ a b c}}}))








