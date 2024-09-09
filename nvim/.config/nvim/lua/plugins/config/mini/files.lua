--
-- plugins/config/mini/files.lua - config for mini.files plugin
--

require("mini.files").setup {}

local minifiles_toggle = function(...)
    if not MiniFiles.close() then MiniFiles.open(...) end
end

vim.keymap.set("n", "<leader>F", minifiles_toggle)

