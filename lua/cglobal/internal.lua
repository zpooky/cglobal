local M = {}
-- local set = require('Module:Set')
local queries = require "nvim-treesitter.query"
local api = vim.api

local cglobal_state_table = {}

local function is_global(node)
  local res = true
  while node ~= nil do
    if node:type() == "function_definition" or node:type() == "ERROR" or node:type() == "compound_statement" then
      res = false
      break
    end
    node = node:parent()
  end
  return res
end

local function key_concat(tab, sep)
  local ctab = {}
  local n = 1
  for k, _ in pairs(tab) do
    ctab[n] = k
    n = n + 1
  end
  return table.concat(ctab, sep)
end

local callbackfn = function(bufnr)
  -- TODO? no need to do anything when pum is open
  if vim.fn.pumvisible() == 1 then return; end
  local globals = {}
  local dirty = false

  -- executes @id query from cglobal.scm??
  local matches = queries.get_capture_matches(bufnr, "@id", "cglobal")
  for _, node in ipairs(matches) do
    if is_global(node.node) then
      local txt = vim.treesitter.query.get_node_text(node.node, bufnr)
      if txt ~= nil then
        if not dirty and cglobal_state_table[bufnr].globals[txt] == nil then
          dirty = true
        end
        globals[txt] = true
      end
    end
  end

  if next(globals) == nil and next(cglobal_state_table[bufnr].globals) ~= nil then
    dirty = true
  end

  if dirty then
    if next(cglobal_state_table[bufnr].globals) ~= nil then
      -- print("clear")
      api.nvim_command('syntax clear cGlobalVariable');
    end
    cglobal_state_table[bufnr].globals = globals
    if next(globals) ~= nil then
      -- print("add")
      local keywords = key_concat(globals, " ")
      api.nvim_command('syntax keyword cGlobalVariable ' .. keywords);
    end
  end
end

local function try_async(f, bufnr)
  local cancel = false;
  local async_handle = vim.loop.new_async(
                           vim.schedule_wrap(function() f(bufnr) end));

  return function()
    if cancel then
      -- return true to detach
      return true
    end
    async_handle:send();
  end, function()
    if cancel == false then async_handle:close() end
    cancel = true
  end
end

function M.attach(bufnr, lang)
  local attachf, detachf = try_async(callbackfn, bufnr);
  cglobal_state_table[bufnr] = {detachf = detachf, globals = {}}

  callbackfn(bufnr);
  -- print("attach")
  api.nvim_buf_attach(bufnr, false, {on_lines = attachf, on_detach = detachf});
end

function M.detach(bufnr)
  local detachf = cglobal_state_table[bufnr]
  detachf()
  cglobal_state_table[bufnr] = nil
end

return M
