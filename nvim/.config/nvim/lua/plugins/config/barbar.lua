--
-- plugins/config/nvim-tree.lua - config for nvim-tree plugin
--

require("barbar").setup {
    animation = false,
    auto_hide = 1,
    exclude_ft = { "neo-tree" },
    sidebar_filetypes = {
        NvimTree = true,
        -- ['neo-tree'] = {event = 'BufWipeout'},
    },
}

-- Next/previous buffer
vim.keymap.set("n", "<A-,>", ":BufferPrevious<CR>", { silent = true })
vim.keymap.set("n", "<A-.>", ":BufferNext<CR>", { silent = true })

-- Close/restore buffer
vim.keymap.set("n", "<A-c>", ":BufferClose<CR>", { silent = true })
vim.keymap.set("n", "<A-s-c>", ":BufferRestore<CR>", { silent = true })

-- Buffer picking mode
vim.keymap.set("n", "<leader>bb", ":BufferPick<CR>", { silent = true })

-- Go to buffer in position...
vim.keymap.set("n", "<A-1>", ":BufferGoto 1<CR>", { silent = true })
vim.keymap.set("n", "<A-2>", ":BufferGoto 2<CR>", { silent = true })
vim.keymap.set("n", "<A-3>", ":BufferGoto 3<CR>", { silent = true })
vim.keymap.set("n", "<A-4>", ":BufferGoto 4<CR>", { silent = true })
vim.keymap.set("n", "<A-5>", ":BufferGoto 5<CR>", { silent = true })
vim.keymap.set("n", "<A-6>", ":BufferGoto 6<CR>", { silent = true })
vim.keymap.set("n", "<A-7>", ":BufferGoto 7<CR>", { silent = true })
vim.keymap.set("n", "<A-8>", ":BufferGoto 8<CR>", { silent = true })
vim.keymap.set("n", "<A-9>", ":BufferGoto 9<CR>", { silent = true })
vim.keymap.set("n", "<A-0>", ":BufferLast<CR>", { silent = true })
