--
-- plugins/config/mini/pick.lua - config for mini.pick plugin
--
local pick = require "mini.pick"

pick.setup {}
-- Currently not replacing vim.ui.select because some things use it awkwardly.
-- vim.ui.select = MiniPick.ui_select

-- Modify built-in buffers picker with mapping to delete buffers.
pick.registry.buffers = function(local_opts)
    local wipeout_func = function()
        vim.api.nvim_buf_delete(pick.get_picker_matches().current.bufnr, {})
    end
    pick.builtin.buffers(
        local_opts,
        { mappings = { wipeout = { char = "<C-d>", func = wipeout_func } } }
    )
end

-- rg, fd, git, or vim.fs (slow)
vim.keymap.set("n", "<leader>ff", MiniPick.builtin.files, { desc = "Pick files (mini.pick)" })
-- Requires rg or git
vim.keymap.set("n", "<leader>fg", MiniPick.builtin.grep_live, { desc = "Live grep (mini.pick) "})
-- rg, git, or vim.fs (slow)
vim.keymap.set("n", "<leader>fG", MiniPick.builtin.grep, { desc = "Grep (mini.pick)" })
-- Use modified buffer picker above instead of MiniPick.builtin.buffers
vim.keymap.set("n", "<leader>fb", pick.registry.buffers, { desc = "Pick buffers (mini.pick)" })
vim.keymap.set("n", "<leader>fh", MiniPick.builtin.help, { desc = "Pick help tags (mini.pick)" })

-- Lo-fi alternative to trouble.nvim
-- require("mini.extra").setup {}
--
-- vim.keymap.set("n", "<leader>fd", MiniExtra.pickers.diagnostic)
