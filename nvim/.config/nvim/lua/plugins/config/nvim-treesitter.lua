--
-- plugins/config/nvim-treesitter.lua - config for nvim-treesitter plugin
--

require 'nvim-treesitter.configs'.setup {
    ensure_installed = "all",

    sync_install = false,

    highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
    },

    incremental_selection = {
        enable = true,
    },
}
