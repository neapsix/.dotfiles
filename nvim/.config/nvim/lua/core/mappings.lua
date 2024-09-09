--
-- mappings.lua - Key mappings for Neovim
--

-- Clear highlighting with Esc
vim.keymap.set("n", "<Esc>", "<cmd>noh<CR>")

-- Move around splits using Ctrl + {h,j,k,l}
vim.keymap.set("n", "<C-h>", "<C-w>h")
vim.keymap.set("n", "<C-j>", "<C-w>j")
vim.keymap.set("n", "<C-k>", "<C-w>k")
vim.keymap.set("n", "<C-l>", "<C-w>l")

-- Close buffers with <leader>bd
vim.keymap.set("n", "<leader>bd", "<cmd>BufferClose<CR>")

-- Toggle diagnostic text with <leader>ll
vim.keymap.set("n", "<Leader>ll", function()
    vim.diagnostic.config {
        virtual_text = not vim.diagnostic.config().virtual_text,
    }
    print("virtual_text = " .. tostring(vim.diagnostic.config().virtual_text))
end)

-- Toggle diagnostics altogether with <leader>lsp
vim.keymap.set("n", "<Leader>lsp", function()
    vim.diagnostic.enable(not vim.diagnostic.is_enabled())
    print("vim.diagnostic.is_enabled() = " .. tostring(vim.diagnostic.is_enabled()))
end)
