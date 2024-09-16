--
-- plugins/config/mini/pick.lua - config for mini.pick plugin
--

require("mini.pick").setup {}
vim.ui.select = MiniPick.ui_select

-- rg, fd, git, or vim.fs (slow)
vim.keymap.set("n", "<leader>ff", MiniPick.builtin.files, { desc = "Pick files (mini.pick)" })
-- Requires rg or git
vim.keymap.set("n", "<leader>fg", MiniPick.builtin.grep_live, { desc = "Live grep (mini.pick) "})
-- rg, git, or vim.fs (slow)
vim.keymap.set("n", "<leader>fG", MiniPick.builtin.grep, { desc = "Grep (mini.pick)" })
vim.keymap.set("n", "<leader>fb", MiniPick.builtin.buffers, { desc = "Pick buffers (mini.pick)" })
vim.keymap.set("n", "<leader>fh", MiniPick.builtin.help, { desc = "Pick help tags (mini.pick)" })

-- Lo-fi alternative to trouble.nvim
-- require("mini.extra").setup {}
--
-- vim.keymap.set("n", "<leader>fd", MiniExtra.pickers.diagnostic)
