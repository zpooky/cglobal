# cglobal
the plugin adds a syntax keyword `cGlobalVariable` which can be used to
highlight global variables differently than local variables.

## installation
```vim
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'zpooky/cglobal'
```

`cglobal` loads itself on C filetypes and does not require a
`nvim-treesitter` module configuration block.
