--
-- plugins/config/null-ls.lua - config for null-ls plugin
--
local nls = require("null-ls")

local sources = {
    -- lua
    nls.builtins.formatting.stylua,
    -- markdown
    nls.builtins.diagnostics.markdownlint,
    -- python
    nls.builtins.formatting.black,
    -- javascript and friends
    nls.builtins.formatting.prettierd,
    -- shell
    nls.builtins.diagnostics.shellcheck,
    nls.builtins.code_actions.shellcheck,
}

local on_attach = require 'plugins.config.handlers'.on_attach

nls.setup({
    sources = sources,
    on_attach = on_attach,
})
