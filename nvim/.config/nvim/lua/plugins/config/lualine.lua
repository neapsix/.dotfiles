--
-- plugins/config/lualine.lua - config for lualine.nvim plugin
--

require("lualine").setup {
    options = {
        icons_enabled = false,
        theme = "rose-pine",
        component_separators = { left = "|", right = "|" },
        section_separators = { left = "", right = "" },
        disabled_filetypes = {
            statusline = {
                "NvimTree",
                "neo-tree",
                "dap-repl",
                "dapui_console",
                "dapui_watches",
                "dapui_stacks",
                "dapui_breakpoints",
                "dapui_scopes",
            },
        },
    },
}
