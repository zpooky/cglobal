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

local function callbackfn(bufnr)
  -- TODO?
  -- print(bufnr)
  if vim.fn.pumvisible() == 1 then return; end
  local globals = {}
  local l_globals = 0
  local dirty = false

  -- print("callbackfn")
  -- queries.invalidate_query_cache("c", "cglobal")
  -- print("has_query_files: ", queries.has_query_files("c", "cglobal"))
  -- print("queries:",queries.available_query_groups())
  -- for key, value in ipairs(queries.available_query_groups()) do
  --   print(key, ":", value)
  -- end
  -- print("get_capture_matches: ")
  -- for key, value in ipairs(queries.get_capture_matches(bufnr, "@id", "cglobal", nil, "c")) do
  --   print(key, ":", value)
  -- end
  local lang = vim.treesitter.language.get_lang(vim.bo[bufnr].ft)
  local parser = vim.treesitter.get_parser(bufnr, lang)
  -- print(type(parser))
  -- for key, value in pairs(parser) do
  --   print("-",key, ":", value)
  -- end
  parser:invalidate(true)
  parser:parse()

  -- print("wasd:", vim.treesitter.query.get("c", "cglobal"))
  -- for key, value in pairs(vim.treesitter.query.get("c", "cglobal")) do
  --   print("-",key, ":", value)
  -- end
  -- for _, match in query:iter_matches(nil, bufnr, start_row, end_row, {all=true}) do
  --   print("-- ",match)
  -- end


  -- executes @id query from cglobal.scm??
  local matches = queries.get_capture_matches(bufnr, "@id", "cglobal")
  -- print(type(matches))
  for _, node in ipairs(matches) do
    -- local txt = vim.treesitter.query.get_node_text(node.node, bufnr)
    local txt = vim.treesitter.get_node_text(node.node, bufnr)
    -- print("- "..txt)
    if is_global(node.node) then
      if txt ~= nil and string.len(txt) > 0 then
        if txt ~= "__packed" and txt ~= "struct" and  txt ~= "typedef" then -- blacklist
          -- print(": "..txt)
          if cglobal_state_table[bufnr].globals == nil then
            dirty = true
          elseif not dirty and cglobal_state_table[bufnr].globals[txt] == nil then
            dirty = true
          end
          -- print("- "..txt)
          globals[txt] = true
          l_globals = l_globals + 1
        end
      end
    end
  end

  if dirty then
    if cglobal_state_table[bufnr].globals ~= nil then
      -- print("clear")
      api.nvim_command('syntax clear cGlobalVariable');
    end
    if l_globals > 0 then
      cglobal_state_table[bufnr].globals = globals
    else
      cglobal_state_table[bufnr].globals = nil
    end
    if l_globals > 0 then
      -- print("add")
      local keywords = key_concat(globals, " ")
      -- print(globals)
      -- print(l_globals)
      -- print('syntax keyword cGlobalVariable ' .. keywords)
      if api.nvim_command('syntax keyword cGlobalVariable ' .. keywords) then
      else
        -- print('ERROR: syntax keyword cGlobalVariable ' .. keywords)
      end
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

function M.attach(bufnr)
  if cglobal_state_table[bufnr] ~= nil then
    M.detach(bufnr)
  end

  local attachf, detachf = try_async(callbackfn, bufnr);
  cglobal_state_table[bufnr] = {detachf = detachf, globals = {}}

  callbackfn(bufnr);
  -- print("attach")
  api.nvim_buf_attach(bufnr, false, {on_lines = attachf, on_reload=attachf, on_detach = detachf});
end

function M.detach(bufnr)
  local entry = cglobal_state_table[bufnr]
  if entry ~= nil then
    entry.detachf()
  end
  cglobal_state_table[bufnr] = nil
end

return M
