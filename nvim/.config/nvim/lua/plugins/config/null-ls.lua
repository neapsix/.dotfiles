--
-- plugins/config/null-ls.lua - config for null-ls plugin
--
local nls = require("null-ls")

local sources = {
    -- nls.builtins.formatting.stylua,
    nls.builtins.code_actions.shellcheck,
}

nls.setup({
    sources = sources
})
