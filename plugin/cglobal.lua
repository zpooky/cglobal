if vim.g.loaded_cglobal then
  return
end

local function define_hlgroups()
  vim.api.nvim_set_hl(0, 'cGlobalVariable', {default = true, fg = '#cc241c', ctermfg= 'Red'})
end

define_hlgroups()

local hl_augroup = vim.api.nvim_create_augroup('AugroupCGlobalHL', {})
vim.api.nvim_create_autocmd('ColorScheme', {
  desc = 'cglobal ColorScheme',
  group = hl_augroup,
  callback = define_hlgroups
})

local augroup = vim.api.nvim_create_augroup('AugroupCGlobal', {})
vim.api.nvim_create_autocmd('FileType', {
  desc = 'cglobal Attach',
  group = augroup,
  callback = function(args)
    local lib = require 'cglobal'

    -- print("Attach")
    local lang = vim.treesitter.language.get_lang(args.match)
    if not lib.is_supported(lang) then return end

    lib.attach(args.buf)
  end,
})
vim.api.nvim_create_autocmd('BufUnload', {
  desc = 'cgloabl BufUnload',
  group = augroup,
  callback = function(args)
    local lib = require 'cglobal'

    -- print("BufUnload")
    -- local lang = vim.treesitter.language.get_lang(args.match)
    -- if not lib.is_supported(lang) then return end

    lib.detach(args.buf)
  end
})

vim.g.loaded_cglobal = true
