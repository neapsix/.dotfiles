--
-- plugins/config/mini/pick.lua - config for mini.pick plugin
--

require("mini.pick").setup {}
vim.ui.select = MiniPick.ui_select

-- rg, fd, git, or vim.fs (slow)
vim.keymap.set("n", "<leader>ff", MiniPick.builtin.files)
-- Requires rg or git
vim.keymap.set("n", "<leader>fg", MiniPick.builtin.grep_live)
-- rg, git, or vim.fs (slow)
vim.keymap.set("n", "<leader>fG", MiniPick.builtin.grep)
vim.keymap.set("n", "<leader>fb", MiniPick.builtin.buffers)
vim.keymap.set("n", "<leader>fh", MiniPick.builtin.help)

