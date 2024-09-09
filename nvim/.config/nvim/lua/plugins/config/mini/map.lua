--
-- plugins/config/mini/map.lua - config for mini.map plugin
--

local map = require "mini.map"

map.setup {
    integrations = {
        -- Color areas on the map for find results, LSP diagnostics,
        -- and lines with a git diff using integrations.

        -- Note: integrations are listed in priority order and colors
        -- don't stack. If a line has a diff, a diagnostic, and a find
        -- match, it appears in the map as the 'find' color only.
        map.gen_integration.builtin_search(),
        map.gen_integration.diagnostic {
            error = "DiagnosticFloatingError",
            warn = "DiagnosticFloatingWarn",
            info = "DiagnosticFloatingInfo",
            hint = "DiagnosticFloatingHint",
        },
        require("mini.map").gen_integration.diff(),
        -- require("mini.map").gen_integration.gitsigns(),
    },
    symbols = {
        -- Make the map out of dots instead of blocks.
        encode = map.gen_encode_symbols.dot "4x2",
        -- Don't show cursor location on the scroll bar.
        scroll_line = "",
    },
    window = {
        -- Don't add a number if a line has e.g.  diff and diagnostic.
        show_integration_count = false,
    },
}

vim.keymap.set("n", "<leader>mm", map.toggle)
