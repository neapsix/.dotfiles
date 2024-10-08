--
-- plugins/config/nvim-treesitter.lua - config for nvim-treesitter plugin
--

require("nvim-treesitter.configs").setup {
    ensure_installed = {
        "beancount",
        "c",
        "html",
        "lua",
        "query",
        "templ",
        "vim",
        "vimdoc",
    },

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
