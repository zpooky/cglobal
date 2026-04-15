local M = {}

function M.is_supported(lang)
  if not lang then
    return false
  end

  local ok, query_files = pcall(vim.treesitter.query.get_files, lang, 'cglobal')
  return ok and query_files ~= nil and #query_files > 0
end

function M.attach(bufnr)
  local lib = require 'cglobal.internal'
  lib.attach(bufnr)
end

function M.detach(bufnr)
  local lib = require 'cglobal.internal'
  lib.detach(bufnr)
end

return M
