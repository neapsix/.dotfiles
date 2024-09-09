--
-- plugins/config/mini/diff.lua - config for mini.diff plugin
--

local diff = require "mini.diff"

diff.setup {
    view = {
        style = "sign",
        signs = { add = "│", change = "│", delete = "_" },
    },
    -- TODO: consider using leader gh instead of just gh to stage.
    -- mappings = {
    --     apply = "<Leader>gh",
    --     reset = "<Leader>gH",
    -- },
    options = {
        -- next/prev hunk keys ([h and ]h) wrap at end/start of file.
        wrap_goto = true,
    },
}

vim.keymap.set("n", "<leader>gd", diff.toggle_overlay)
