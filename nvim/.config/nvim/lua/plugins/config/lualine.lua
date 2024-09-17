--
-- plugins/config/lualine.lua - config for lualine.nvim plugin
--

require("lualine").setup {
    options = {
        icons_enabled = false,
        -- theme = "rose-pine",
        -- theme = "oxocarbon",
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
    sections = {
        lualine_x = {
            -- Note: configured to show only name and spinner
            function()
                return require("lsp-progress").progress()
            end,
            'encoding',
            'fileformat',
            'filetype',
        },
    },
}

-- Listen for lsp-progress events and refresh lualine.
vim.api.nvim_create_augroup("lualine_lsp_progress", { clear = true })
vim.api.nvim_create_autocmd("User", {
    group = "lualine_lsp_progress",
    pattern = "LspProgressStatusUpdated",
    callback = require("lualine").refresh,
})
