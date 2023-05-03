; extends

(jsx_opening_element
  name: (identifier) @jsx.element.name
  (#set! "priority" 101)
)

(jsx_opening_element
  name: (identifier) @jsx.element.name.component
  (#set! "priority" 101)
  (#match? @jsx.element.name.component "^[A-Z]+.*$")
)


(jsx_closing_element
  name: (identifier) @jsx.element.name
  (#set! "priority" 101)
)

(jsx_closing_element
  name: (identifier) @jsx.element.name.component
  (#set! "priority" 101)
  (#match? @jsx.element.name.component "^[A-Z]+.*$")
)

(jsx_self_closing_element
  name: (identifier) @jsx.element.name
  (#set! "priority" 101)
)

(jsx_self_closing_element
  name: (identifier) @jsx.element.name.component
  (#set! "priority" 101)
  (#match? @jsx.element.name.component "^[A-Z]+.*$")
)

