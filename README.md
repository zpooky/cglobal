# cglobal
the plugin adds a syntax keyword `cGlobalVariable` which can be used to
highlight global variables differently than local variables.

## installation
```vim
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'zpooky/cglobal'

lua <<EOF
require'nvim-treesitter.configs'.setup {
  cglobal = {
    enable = true
  }
}
EOF
```
