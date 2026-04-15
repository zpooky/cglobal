local M = {}
-- local set = require('Module:Set')
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

local function state_changed(old_state, new_state)
  if old_state == nil then
    return new_state ~= nil
  end

  if new_state == nil then
    return old_state ~= nil
  end

  for key, _ in pairs(old_state) do
    if not new_state[key] then
      return true
    end
  end

  for key, _ in pairs(new_state) do
    if not old_state[key] then
      return true
    end
  end

  return false
end

local function callbackfn(bufnr)
  -- TODO?
  -- print(bufnr)
  if vim.fn.pumvisible() == 1 then return; end
  local globals = {}
  local l_globals = 0
  local dirty = false

  local lang = vim.treesitter.language.get_lang(vim.bo[bufnr].ft)
  if not lang then
    return
  end

  local ok_query, query = pcall(vim.treesitter.query.get, lang, "cglobal")
  if not ok_query or not query then
    return
  end

  local ok_parser, parser = pcall(vim.treesitter.get_parser, bufnr, lang)
  if not ok_parser or not parser then
    return
  end

  for _, tree in ipairs(parser:parse()) do
    local root = tree:root()
    local start_row = root:start()
    local stop_row = select(1, root:end_())
    for capture_id, node in query:iter_captures(root, bufnr, start_row, stop_row) do
      if query.captures[capture_id] == "id" then
        local txt = vim.treesitter.get_node_text(node, bufnr)
        if is_global(node) then
          if txt ~= nil and string.len(txt) > 0 then
            if txt ~= "__packed" and txt ~= "struct" and txt ~= "typedef" then -- blacklist
              globals[txt] = true
              l_globals = l_globals + 1
            end
          end
        end
      end
    end
  end

  local next_globals = l_globals > 0 and globals or nil
  dirty = state_changed(cglobal_state_table[bufnr].globals, next_globals)

  if dirty then
    if cglobal_state_table[bufnr].globals ~= nil then
      -- print("clear")
      api.nvim_command('syntax clear cGlobalVariable');
    end
    cglobal_state_table[bufnr].globals = next_globals
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
