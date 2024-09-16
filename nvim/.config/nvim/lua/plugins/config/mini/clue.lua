--
-- plugins/config/mini/clue.lua - config for mini.clue plugin
--

local miniclue = require("mini.clue")

miniclue.setup {
    triggers = {
        -- Leader key
        { mode = "n", keys = "<Leader>" },
        { mode = "x", keys = "<Leader>" },

        -- Built-in completion
        { mode = "i", keys = "<C-x>" },

        -- `g` key
        { mode = "n", keys = "g" },
        { mode = "x", keys = "g" },

        -- Marks
        { mode = "n", keys = "'" },
        { mode = "n", keys = "`" },
        { mode = "x", keys = "'" },
        { mode = "x", keys = "`" },

        -- Registers
        { mode = "n", keys = '"' },
        { mode = "x", keys = '"' },
        { mode = "i", keys = "<C-r>" },
        { mode = "c", keys = "<C-r>" },

        -- Window commands
        { mode = "n", keys = "<C-w>" },

        -- `s` key (mini.surround)
        { mode = "n", keys = "s" },
        { mode = "x", keys = "s" },

        -- `z` key
        { mode = "n", keys = "z" },
        { mode = "x", keys = "z" },
    },

    clues = {
        miniclue.gen_clues.builtin_completion(),
        miniclue.gen_clues.g(),
        miniclue.gen_clues.marks(),
        miniclue.gen_clues.registers(),
        miniclue.gen_clues.windows(),
        miniclue.gen_clues.z(),
        { mode = "n", keys = "<Leader>b", desc = "+Buffers" },
        { mode = "n", keys = "<Leader>c", desc = "+Refs" },
        { mode = "n", keys = "<Leader>d", desc = "+DAP" },
        { mode = "n", keys = "<Leader>f", desc = "+Pickers" },
        { mode = "n", keys = "<Leader>g", desc = "+Git" },
        { mode = "n", keys = "<Leader>l", desc = "+LSP" },
        { mode = "n", keys = "<Leader>s", desc = "+Sessions" },
        { mode = "n", keys = "<Leader>x", desc = "+Trouble" },
    },
}

