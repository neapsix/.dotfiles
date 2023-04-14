--
-- plugins/config/null-ls.lua - config for null-ls plugin
--
local nls = require("null-ls")

local sources = {
    -- javascript and friends
    nls.builtins.formatting.prettierd,
    -- lua
    nls.builtins.formatting.stylua,
    -- markdown
    nls.builtins.diagnostics.markdownlint,
    -- python
    nls.builtins.formatting.black,
    -- shell
    nls.builtins.diagnostics.shellcheck,
    nls.builtins.code_actions.shellcheck,
    -- yaml
    nls.builtins.formatting.yamlfmt.with({
        command = "yamlfix",
    }),
    -- go
    nls.builtins.formatting.gofmt,
}

local on_attach = require 'plugins.config.handlers'.on_attach

nls.setup({
    sources = sources,
    on_attach = on_attach,
})
