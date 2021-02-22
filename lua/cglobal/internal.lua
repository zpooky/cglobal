local M = {}
-- local set = require('Module:Set')
local utils = require "nvim-treesitter.ts_utils"
local queries = require "nvim-treesitter.query"
local api = vim.api

local cglobal_state_table = {}
local cglobal_state_globals = {}

local function is_global(node)
  local res = true
  while node:parent() ~= nil do
    if node:type() == "function_definition" then
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
  if vim.fn.pumvisible() == 1 then
    return;
  end
  local globals = {}
  local dirty = false

  -- executes @id query from cglobal.scm??
  local matches = queries.get_capture_matches(bufnr, "@id", "cglobal")
  for _, node in ipairs(matches) do
    if is_global(node.node) then
      local txt = utils.get_node_text(node.node)[1]
      if txt ~= nil then
        if not dirty and cglobal_state_globals[bufnr][txt] == nil then
          dirty = true
        end
        globals[txt] = true
      end
    end
  end

  if next(globals) == nil and next(cglobal_state_globals[bufnr]) ~= nil then
    dirty = true
  end

  if dirty then
    if next(cglobal_state_globals[bufnr]) ~= nil then
      api.nvim_command('syntax clear cGlobalVariable');
    end
    cglobal_state_globals[bufnr] = globals
    if next(globals) ~= nil then
      local keywords = key_concat(globals, " ")
      api.nvim_command('syntax keyword cGlobalVariable '..keywords);
    end
  end
end

local function try_async (f, bufnr)
  local cancel = false;

  return function()
    if cancel then return true end
    local async_handle;

    -- TODO here we emit a background job for every change
    async_handle = vim.loop.new_async(
                    vim.schedule_wrap(
                      function()
                        f(bufnr)
                        async_handle:close()
                      end
                    )
                  );
    async_handle:send();
  end,
  function() cancel = true end
end

function M.attach(bufnr, lang)
  cglobal_state_globals[bufnr] = {};
  local attachf, detachf = try_async(callbackfn, bufnr);
  cglobal_state_table[bufnr] = detachf;
  callbackfn(bufnr);
  -- on every change:

-- TODO ~/sources/neovim/runtime/doc/treesitter.txt
-- #1.
-- <Create a parser for_ a buffer and a given language (if_ another plugin uses the
-- same buffer/language combination, it will be safely reused) Use >
--     parser = vim.treesitter.get_parser(bufnr, lang)
--
-- NB: to use the parser directly inside a |nvim_buf_attach| Lua callback, you must
-- call get_parser() before you register your callback. But preferably parsing
-- shouldnt be done directly in_ the change callback anyway as they will be very
-- frequent. Rather a plugin that does any kind of analysis on a tree should use
-- a timer to throttle too frequent updates.
-- #2.
--- Registers callbacks for the parser
-- @param cbs An `nvim_buf_attach`-like table argument with the following keys :
--  `on_bytes` : see `nvim_buf_attach`, but this will be called _after_ the parsers callback.
--  !! `on_changedtree` : a callback that will be called every time the tree has syntactical changes.  it will only be passed one argument, that is a table of the ranges (as node ranges) that changed.
--  `on_child_added` : emitted when a child is added to the tree.
--  `on_child_removed` : emitted when a child is removed from the tree.
--  function LanguageTree:register_cbs(cbs)

  api.nvim_buf_attach(bufnr, false, {on_lines = attachf});
end

function M.detach(bufnr)
  local detachf = cglobal_state_table[bufnr]
  detachf()
end

return M
