; (declaration (identifier) @id)
(declaration type: (primitive_type) declarator: (identifier) @id)
(declaration type: (type_identifier) declarator: (identifier) @id)
declarator: (array_declarator declarator: (identifier) @id)
declarator: (init_declarator declarator: (identifier) @id)
declarator: (parenthesized_declarator (pointer_declarator declarator: (identifier) @id))
declarator: (init_declarator declarator: (pointer_declarator declarator: (identifier) @id) value: (string_literal))
(declaration (storage_class_specifier) type: (type_identifier) declarator: (pointer_declarator declarator: (identifier) @id))
(declaration type: (type_identifier) declarator: (pointer_declarator declarator: (identifier) @id))
(declaration (storage_class_specifier) type: (primitive_type) declarator: (pointer_declarator declarator: (identifier) @id))
(declaration (storage_class_specifier) type: (primitive_type) declarator: (init_declarator declarator: (pointer_declarator declarator: (identifier) @id)))
(declaration (storage_class_specifier) type: (type_identifier) declarator: (init_declarator declarator: (pointer_declarator declarator: (identifier) @id)))
(declaration type: (type_identifier) declarator: (init_declarator declarator: (pointer_declarator declarator: (identifier) @id)))
(declaration (storage_class_specifier) type: (struct_specifier name: (type_identifier)) declarator: (pointer_declarator declarator: (identifier) @id))
(declaration type: (struct_specifier name: (type_identifier)) declarator: (pointer_declarator declarator: (identifier) @id))
(declaration (storage_class_specifier) (type_qualifier) type: (struct_specifier name: (type_identifier)) declarator: (init_declarator declarator: (pointer_declarator declarator: (identifier) @id)))
(declaration (storage_class_specifier) type: (sized_type_specifier type: (primitive_type)) declarator: (identifier) @id)
(declaration type: (struct_specifier name: (type_identifier)) declarator: (identifier) @id)
(declaration (storage_class_specifier) type: (primitive_type) declarator: (identifier) @id)
(declaration (storage_class_specifier) type: (struct_specifier name: (type_identifier)) declarator: (init_declarator declarator: (pointer_declarator declarator: (identifier) @id)))
(declaration (storage_class_specifier) type: (sized_type_specifier) declarator: (identifier) @id)
(declaration type: (primitive_type) declarator: (init_declarator declarator: (pointer_declarator declarator: (pointer_declarator declarator: (identifier) @id)) value: (null)))
(declaration (type_qualifier) type: (primitive_type) declarator: (init_declarator declarator: (pointer_declarator declarator: (identifier) @id) value: (null)))
(declaration type: (primitive_type) declarator: (init_declarator declarator: (pointer_declarator declarator: (identifier) @id) value: (null)))
