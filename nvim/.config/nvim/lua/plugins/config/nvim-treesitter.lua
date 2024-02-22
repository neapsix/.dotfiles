--
-- plugins/config/nvim-treesitter.lua - config for nvim-treesitter plugin
--

local parser_config = require("nvim-treesitter.parsers").get_parser_configs()
parser_config.templ = {
    install_info = {
        url = "https://github.com/vrischmann/tree-sitter-templ.git",
        files = { "src/parser.c", "src/scanner.c" },
        branch = "master",
    },
}

vim.treesitter.language.register("templ", "templ")

require("nvim-treesitter.configs").setup {
    ensure_installed = { "c", "lua", "vim", "vimdoc", "query" },

    auto_install = false,

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

vim.treesitter.query.set("lua", "injections", "")
