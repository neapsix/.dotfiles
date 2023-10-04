--
-- plugins/config/trouble.lua - config for trouble.nvim plugin
--

local t = require "trouble"

t.setup {
    icons = false,
}

vim.keymap.set("n", "<leader>xx", t.open)

vim.keymap.set("n", "<leader>xw", function()
    t.open "workspace_diagnostics"
end)

vim.keymap.set("n", "<leader>xd", function()
    t.open "document_diagnostics"
end)

vim.keymap.set("n", "<leader>xq", function()
    t.open "quickfix"
end)

vim.keymap.set("n", "<leader>xl", function()
    t.open "loclist"
end)

vim.keymap.set("n", "gR", function()
    t.open "lsp_references"
end)
