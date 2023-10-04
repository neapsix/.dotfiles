--
-- mappings.lua - Key mappings for Neovim
--

-- Snippet for easier key mapping syntax
local function map(mode, lhs, rhs, opts)
    local options = { noremap = true, silent = true }
    if opts then
        options = vim.tbl_extend("force", options, opts)
    end
    vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

-- Clear highlighting with Esc
map("n", "<Esc>", "<cmd> noh <CR>")

-- Move around splits using Ctrl + {h,j,k,l}
map("n", "<C-h>", "<C-w>h")
map("n", "<C-j>", "<C-w>j")
map("n", "<C-k>", "<C-w>k")
map("n", "<C-l>", "<C-w>l")

-- Toggle diagnostic text with <leader>ll
vim.keymap.set("n", "<Leader>ll", function()
    vim.diagnostic.config {
        virtual_text = not vim.diagnostic.config().virtual_text,
    }
    print("virtual_text = " .. tostring(vim.diagnostic.config().virtual_text))
end, { noremap = true, silent = true })
