--
-- plugins/config/toggle-lsp-diagnostics.lua - config for
--   toggle-lsp-diagnostics.nvim plugin
--

local t = require "toggle_lsp_diagnostics"

t.init()

vim.keymap.set("n", "<Leader>lsp", t.toggle_diagnostics)
