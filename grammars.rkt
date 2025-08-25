#lang plai

(define-type Binding
  
  ;; '{s-id s-value}
  (binding (id symbol?) (value WAE?))
  )

(define-type WAE
  
  ;; 's-id
  (id (i symbol?))

  ;; 's-num
  (num (n number?))

  ;; '{f s-arg1 s-arg2 s-arg3...}
  (op (f procedure?) (args (listof WAE?)))

  ;; '{with {{s-id1 s-v1} {s-id2 s-v2}...} s-body}
  (with (bindings (listof Binding?)) (body WAE?))

  )
