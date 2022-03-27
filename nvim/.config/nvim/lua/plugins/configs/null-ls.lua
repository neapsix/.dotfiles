--
-- plugins/configs/null-ls.lua - config for null-ls plugin
--
local nullls = require("null-ls")

nullls.setup({
	sources = {
        -- nullls.builtins.formatting.stylua,
        -- nullls.builtins.code_actions.shellcheck,
	},
})
