; int a;
(declaration type: (primitive_type) declarator: (identifier) @id)
; int a = ...;
(declaration type: (primitive_type) declarator: (init_declarator declarator: (identifier) @id value: (_)))
; int *a;
(declaration type: (primitive_type) declarator: (pointer_declarator declarator: (identifier) @id))
; int *a = &b;
(declaration type: (primitive_type) declarator: (init_declarator declarator: (pointer_declarator declarator: (identifier) @id) value: (_)))

(declaration type: (type_identifier) declarator: (identifier) @id)
declarator: (array_declarator declarator: (identifier) @id)
; ↓ this is problematic: int idx = 0;
; declarator: (init_declarator declarator: (identifier) @id)
(declaration (storage_class_specifier) type: (type_identifier) declarator: (init_declarator declarator: (identifier) @id value: (_)))
(declaration (storage_class_specifier) type: (type_identifier) declarator: (init_declarator declarator: (identifier) @id))
declarator: (parenthesized_declarator (pointer_declarator declarator: (identifier) @id))
declarator: (init_declarator declarator: (pointer_declarator declarator: (identifier) @id) value: (_))
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
(declaration type: (primitive_type) declarator: (init_declarator declarator: (pointer_declarator declarator: (pointer_declarator declarator: (identifier) @id)) value: (_)))
(declaration (type_qualifier) type: (primitive_type) declarator: (init_declarator declarator: (pointer_declarator declarator: (identifier) @id) value: (_)))
(declaration (storage_class_specifier) type: (primitive_type) declarator: (pointer_declarator declarator: (pointer_declarator declarator: (identifier) @id)))
(declaration (storage_class_specifier) type: (type_identifier) declarator: (pointer_declarator declarator: (pointer_declarator declarator: (identifier) @id)))
; enum type { VALUE0 } name;
(declaration type: (enum_specifier name: (type_identifier) body: (enumerator_list (enumerator name: (identifier)))) declarator: (identifier) @id)
; static uint8_t name = STATE;
(declaration (storage_class_specifier) type: (primitive_type) declarator: (init_declarator declarator: (identifier) @id value: (_)))
; static const int name = CALL(ARG);
(declaration (storage_class_specifier) (type_qualifier) type: (primitive_type) declarator: (init_declarator declarator: (identifier) @id value: (_)))
; static const type name = CALL(ARG);
(declaration (storage_class_specifier) (type_qualifier) type: (type_identifier) declarator: (init_declarator declarator: (identifier) @id value: (_)))
; static char **name = NULL;
(declaration (storage_class_specifier) type: (type_identifier) declarator: (init_declarator declarator: (pointer_declarator declarator: (pointer_declarator declarator: (identifier) @id)) value: (null)))
; static struct Struct var = { };
(declaration (storage_class_specifier) type: (struct_specifier name: (type_identifier)) declarator: (init_declarator declarator: (identifier) @id value: (_)))
; const struct Struct var = { };
(declaration (type_qualifier) type: (struct_specifier name: (type_identifier)) declarator: (init_declarator declarator: (identifier) @id value: (_)))
; typedef int/struct Struct (*var)(...);
(type_definition type: (_) declarator: (function_declarator declarator: (parenthesized_declarator (pointer_declarator declarator: (type_identifier) @id)) parameters: (_)))
; struct Struct b2 = {...};
(declaration type: (struct_specifier name: (type_identifier)) declarator: (init_declarator declarator: (identifier) @id value: (_)))
; struct Struct *f2 = ...;
(declaration type: (struct_specifier name: (type_identifier)) declarator: (init_declarator declarator: (pointer_declarator declarator: (identifier) @id) value: (_)))
