--
-- plugins/config/conform.lua - config for conform.nvim plugin
--
--     Note: guard.nvim seems to profile better than conform.nvim at about
--     0.0006ms to run stylua from guard vs. 0.0016ms with conform. I chose
--     conform for the option to ignore exit code with custom formatters. It
--     also has great docs and seems to be a superior implementation.
--

require("conform").setup {
    formatters_by_ft = {
        -- c = { "indent" },
        c = { "clang_format" },
        lua = { "stylua" },
        python = { "black" },
        -- Note: go and templ are formatted with LSP
        -- go = { "golines" },
        -- templ = { "templ" },

        -- javascript and friends
        -- TODO: use { {"prettierd", "prettier" } }
        css = { "prettier" },
        html = { "prettier" },
        less = { "prettier" },
        javascript = { "prettier" },
        javascriptreact = { "prettier" },
        json = { "prettier" },
        markdown = { "prettier" },
        scss = { "prettier" },
        svelte = { "prettier" },
        typescript = { "prettier" },
        typescriptreact = { "prettier" },
        yaml = { "prettier" },
        -- TODO: check wth filetypes yaml.ansible and yml.
        -- yaml = { "yamlfix" },
    },
    formatters = {
        clang_format = {
            prepend_args = {
                "--style={BasedOnStyle: LLVM, UseTab: Always, IndentWidth: 8, TabWidth: 8, BreakBeforeBraces: Linux, ColumnLimit: 120}",
            },
        },
    },
}

-- Callback function to fun after formatting. For filetypes not listed above
-- where we fall back to LSP formatting, use this function to run additional
-- commands after LSP formatting.
local function after_format()
    if vim.o.filetype == "go" then
        require("plugins.config.nvim-lspconfig").gopls_organize_imports()
    end
end

-- Recipe from conform.nvim docs, but adds the callback arg when calling format.
vim.api.nvim_create_user_command("Format", function(args)
    local range = nil
    if args.count ~= -1 then
        local end_line =
            vim.api.nvim_buf_get_lines(0, args.line2 - 1, args.line2, true)[1]
        range = {
            start = { args.line1, 0 },
            ["end"] = { args.line2, end_line:len() },
        }
    end
    require("conform").format(
        { async = true, lsp_fallback = true, range = range },
        after_format
    )
end, { range = true })

-- Key mapping for the command above.
vim.keymap.set({ "n", "v" }, "<Space>f", ":Format<CR>")
