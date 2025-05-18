local queries = require "nvim-treesitter.query"

local M = {}

function M.is_supported(lang)
  return queries.get_query(lang, 'cglobal') ~= nil
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
