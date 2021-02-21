local queries = require "nvim-treesitter.query"

local M = {}

function M.init()
  require "nvim-treesitter".define_modules {
    cglobal = {
      module_path = "cglobal.internal",
      is_supported = function(lang)
        -- /queries/$lang/cglobal.scm
        return queries.get_query(lang, 'cglobal') ~= nil
      end
    }
  }
end

return M
