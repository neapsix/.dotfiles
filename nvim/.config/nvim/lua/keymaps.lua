-- 
-- keymaps.lua - Key mappings for Neovim
--

local function map(mode, lhs, rhs, opts)
    local options = { noremap = true, silent = true }
    
    if opts then
        options = vim.tbl_extend('force', options, opts)
    end
    
    vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

-- Move around splits usign Ctrl + {h,j,k,l}
map('n', '<C-h>', '<C-w>h')
map('n', '<C-j>', '<C-w>j')
map('n', '<C-k>', '<C-w>k')
map('n', '<C-l>', '<C-w>l')
