; int a;
(declaration type: (_) declarator: (identifier) @id)
; int a = ...;
(declaration type: (_) declarator: (init_declarator declarator: (identifier) @id value: (_)))
; int *a;
(declaration type: (_) declarator: (pointer_declarator declarator: (identifier) @id))
; int *a = &b;
(declaration type: (_) declarator: (init_declarator declarator: (pointer_declarator declarator: (identifier) @id) value: (_)))
; enum type { VALUE0 } name;
(declaration type: (enum_specifier name: (type_identifier) body: (enumerator_list (enumerator name: (identifier)))) declarator: (identifier) @id)
; static uint8_t var = STATE;
; static struct Struct var = { };
(declaration (storage_class_specifier) type: (_) declarator: (init_declarator declarator: (identifier) @id value: (_)))
; static char **var = NULL;
(declaration (storage_class_specifier) type: (_) declarator: (init_declarator declarator: (pointer_declarator declarator: (pointer_declarator declarator: (identifier) @id)) value: (null)))
; const struct Struct var = { };
(declaration (type_qualifier) type: (struct_specifier name: (type_identifier)) declarator: (init_declarator declarator: (identifier) @id value: (_)))
; struct Struct b2 = {...};
(declaration type: (struct_specifier name: (type_identifier)) declarator: (init_declarator declarator: (identifier) @id value: (_)))
; struct Struct *f2 = ...;
(declaration type: (struct_specifier name: (type_identifier)) declarator: (init_declarator declarator: (pointer_declarator declarator: (identifier) @id) value: (_)))
; char var[] = ...;
(declaration type: (_) declarator: (init_declarator declarator: (array_declarator declarator: (identifier) @id) value: (_)))
; char var[];
(declaration type: (_) declarator: (array_declarator declarator: (identifier) @id))
; static struct Struct var;
(declaration (storage_class_specifier) type: (_) declarator: (identifier) @id)
; static struct Struct *var;
(declaration (storage_class_specifier) type: (_) declarator: (pointer_declarator declarator: (identifier) @id))
; static struct Struct **var;
(declaration (storage_class_specifier) type: (_) declarator: (pointer_declarator declarator: (pointer_declarator declarator: (identifier) @id)))
; const struct Struct var;
(declaration (type_qualifier) type: (struct_specifier name: (type_identifier)) declarator: (identifier) @id)
; const struct Struct *var;
(declaration (type_qualifier) type: (struct_specifier name: (type_identifier)) declarator: (pointer_declarator declarator: (identifier) @id))
; const struct Struct **var;
(declaration (type_qualifier) type: (struct_specifier name: (type_identifier)) declarator: (pointer_declarator declarator: (pointer_declarator declarator: (identifier) @id)))
; struct Struct var;
(declaration type: (struct_specifier name: (type_identifier)) declarator: (identifier) @id)
; struct Struct *var;
(declaration type: (struct_specifier name: (type_identifier)) declarator: (pointer_declarator declarator: (identifier) @id))
; struct Struct **var;
(declaration type: (struct_specifier name: (type_identifier)) declarator: (pointer_declarator declarator: (pointer_declarator declarator: (identifier) @id)))
; Struct_t var;
(declaration type: (type_identifier) declarator: (identifier) @id)
; Struct_t var = ...;
(declaration type: (type_identifier) declarator: (init_declarator declarator: (identifier) @id value: (initializer_list (initializer_pair designator: (field_designator (field_identifier)) value: (_)))))
; Struct_t *var;
(declaration type: (type_identifier) declarator: (pointer_declarator declarator: (identifier) @id))
; Struct_t *var = ...;
(declaration type: (type_identifier) declarator: (init_declarator declarator: (pointer_declarator declarator: (identifier) @id) value: (_)))
; int (*var)(...);
(declaration type: (_) declarator: (function_declarator declarator: (parenthesized_declarator (pointer_declarator declarator: (identifier) @id)) parameters: (_)))
; int* (*var)(...);
(declaration type: (_) declarator: (pointer_declarator declarator: (function_declarator declarator: (parenthesized_declarator (pointer_declarator declarator: (identifier) @id)) parameters: (_))))
; struct Struct var[...];
(declaration type: (struct_specifier name: (type_identifier)) declarator: (array_declarator declarator: (identifier) @id size: (_)))
; struct Struct var[...] = {...};
(declaration type: (struct_specifier name: (type_identifier)) declarator: (init_declarator declarator: (array_declarator declarator: (identifier) @id size: (_)) value: (_)))
; struct Struct *var[...];
(declaration type: (struct_specifier name: (type_identifier)) declarator: (pointer_declarator declarator: (array_declarator declarator: (identifier) @id size: (_))))
; struct Struct **var[...];
(declaration type: (struct_specifier name: (type_identifier)) declarator: (pointer_declarator declarator: (pointer_declarator declarator: (array_declarator declarator: (identifier) @id size: (_)))))
; struct Struct var[...] = {...};
(declaration type: (struct_specifier name: (type_identifier)) declarator: (init_declarator declarator: (pointer_declarator declarator: (array_declarator declarator: (identifier) @id size: (_))) value: (_)))
; char *var[....] = {...};
(declaration type: (_) declarator: (init_declarator declarator: (pointer_declarator declarator: (array_declarator declarator: (identifier) @id size: (_))) value: (_)))
; int *var[_];
(declaration type: (_) declarator: (pointer_declarator declarator: (array_declarator declarator: (identifier) @id size: (_))))
; static _ *var[] = { ... };
(declaration (storage_class_specifier) type: (_) declarator: (init_declarator declarator: (pointer_declarator declarator: (array_declarator declarator: (identifier) @id )) value: (_)))
; _ *var[] = { ... };
(declaration type: (_) declarator: (init_declarator declarator: (pointer_declarator declarator: (array_declarator declarator: (identifier) @id)) value: (_)))
; wasd_t (*var0)(void);
(expression_statement (call_expression function: (call_expression function: (identifier) arguments: (argument_list (pointer_expression argument: (identifier) @id))) arguments: (_)))
; extern gpio_pin_t a[];
; extern int *b[];
(declaration (storage_class_specifier) type: (_) declarator: (pointer_declarator declarator: (array_declarator declarator: (identifier) @id)))
; static const uint8_t b28[2][4] = {...};
(declaration (storage_class_specifier) (type_qualifier) type: (_) declarator: (init_declarator declarator: (array_declarator declarator: (array_declarator declarator: (identifier) @id size: (_)) size: (_)) value: (_)))
; struct resolution_config **a[MAX_NUMBER_OF_SETS];
(declaration type: (_) declarator: (pointer_declarator declarator: (pointer_declarator declarator: (array_declarator declarator: (identifier) @id size: (_)))))
; enum type a[...][...];
(declaration type: (enum_specifier name: (type_identifier)) declarator: (array_declarator declarator: (array_declarator declarator: (identifier) @id size: (_)) size: (_)))
; static char a[...][...];
(declaration (_) type: (_) declarator: (pointer_declarator declarator: (array_declarator declarator: (array_declarator declarator: (identifier) @id size: (_)) size: (_))))
; char a[...][...];
(declaration type: (_) declarator: (pointer_declarator declarator: (array_declarator declarator: (array_declarator declarator: (identifier) @id size: (_)) size: (_))))
; int (*a)(...) = ...;
(declaration type: (_) declarator: (init_declarator declarator: (function_declarator declarator: (parenthesized_declarator (pointer_declarator declarator: (identifier) @id)) parameters: (_)) value: (_)))
; int *(*a)(...) = ...;
(declaration type: (_) declarator: (init_declarator declarator: (pointer_declarator declarator: (function_declarator declarator: (parenthesized_declarator (pointer_declarator declarator: (identifier) @id)) parameters: (_))) value: (_)))
; static double (*a)(void) = ...;
(declaration (_) type: (_) declarator: (init_declarator declarator: (function_declarator declarator: (parenthesized_declarator (pointer_declarator declarator: (identifier) @id)) parameters: (_)) value: (_)))

; TODO maybe change (type_identifier) to (_)
