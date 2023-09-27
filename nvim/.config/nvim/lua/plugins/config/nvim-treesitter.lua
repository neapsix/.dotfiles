--
-- plugins/config/nvim-treesitter.lua - config for nvim-treesitter plugin
--

local treesitter_parser_config = require "nvim-treesitter.parsers".get_parser_configs()
treesitter_parser_config.templ = {
    install_info = {
        url = "https://github.com/vrischmann/tree-sitter-templ.git",
        files = { "src/parser.c", "src/scanner.c" },
        branch = "master",
    },
}

vim.treesitter.language.register('templ', 'templ')

require 'nvim-treesitter.configs'.setup {
    ensure_installed = "all",

    ignore_install = { "phpdoc" },

    sync_install = false,

    highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
    },

    incremental_selection = {
        enable = true,
    },

    indent = {
        enable = false,
    },
}
