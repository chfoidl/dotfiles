; extends

(tag_name) @comment.tag
(named_type) @comment.type
(variable_name (#set! "priority" 101)) @comment.variable
(description (#set! "priority" 101))  @comment.description

(inline_tag
  (tag_name ) @comment.inline.tag
  (#set! "priority" 101)
)

; Types
(namespace_name_as_prefix) @comment.type.fqdn

(qualified_name
  (name) @comment.type.name
)
