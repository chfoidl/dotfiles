; extends

(php_tag) @opening_tag

; Make sure variable names are highlighted including the $ sign
"$"(variable_name (#set! "priority" 101)) @fullvariable

; Use Statements
(namespace_use_declaration
  (namespace_use_clause
    (qualified_name) @use.fqdn
    (#set! "priority" 110)
  )
)

(namespace_use_declaration
  (namespace_use_clause
    (qualified_name
      (name) @use.name
      (#set! "priority" 110)
    )
  )
)


; Constructor Method
(method_declaration
  name: (name) @method.constructor
  (#eq? @method.constructor "__construct")
)

; $this
(_
  (variable_name) @ref.self
  (#eq? @ref.self "$this")
  (#set! "priority" 105)
)

"->" @operator.method

; e.g. instanceof type highlight
(binary_expression
  (name) @type
)

