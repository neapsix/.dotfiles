--
-- plugins/config/guard.lua - config for guard plugin
--

local ft = require 'guard.filetype'

-- Built-in configurations from guard-collection
ft('go'):fmt 'gofmt'
-- TODO: add golines
ft('javascript,typescript,typescriptreact'):fmt 'prettier'
-- TODO: maybe add json to the list for prettier.
ft('lua'):fmt 'stylua'
ft('python'):fmt 'black'
ft('sh'):lint 'shellcheck'
-- Note: shellcheck can do code actions, not available in guard.

-- Custom definitions

-- go templ (https://templ.guide)
-- Note: linting for templ is through lspconfig.
ft('templ'):fmt {
    cmd = 'templ',
    args = {
        'fmt',
    },
    stdin = true,
}

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
