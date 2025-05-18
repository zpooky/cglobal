if vim.g.loaded_cglobal then
  return
end

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
    local lang = vim.treesitter.language.get_lang(args.match)
    if not lib.is_supported(lang) then return end

    lib.detach(args.buf)
  end
})

vim.g.loaded_cglobal = true
