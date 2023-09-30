--
-- plugins/config/guard.lua - config for guard plugin
--

local ft = require 'guard.filetype'

-- Built-in configurations from guard-collection
ft('javascript,typescript,typescriptreact,html'):fmt 'prettier'
-- TODO: maybe add json to the list for prettier.
ft('lua'):fmt 'stylua'
ft('python'):fmt 'black'
ft('sh'):lint 'shellcheck'
-- Note: shellcheck can do code actions, not available in guard.

-- Custom definitions

-- go: run LSP formatting first, then run LSP organize imports using
-- a function defined in the file with my lspconfig plugin options.
ft('go'):fmt('lsp'):append {
    fn = function()
        require 'plugins.config.nvim-lspconfig'.gopls_organize_imports()
    end,
}
-- TODO: add golines

-- yamlfix
-- Note: yamlfix uses - argument to read from stdin.
ft('yaml,yml,yaml.ansible'):fmt {
    cmd = 'yamlfix',
    args = {
        '-',
    },
    stdin = true,
}

-- TODO: add markdownlint

require('guard').setup {
    fmt_on_save = false,
    lsp_as_default_formatter = true,
}

-- Key mapping for format command
vim.keymap.set('n', '<Space>f', ':GuardFmt<CR>', { silent = true })
