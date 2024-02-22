--
-- plugins/config/nvim-qwahl.lua - config for nvim-qwahl plugin
--

local q = require "qwahl"

vim.keymap.set("n", "<leader>fb", q.buffers)

-- see :help qwahl for other possibilities
