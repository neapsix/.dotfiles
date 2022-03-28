--
-- plugins/config/snap.lua - config for snap plugin
--

local snap = require 'snap'

--[[ snap.maps {
    {"<Leader><Leader>", snap.config.file {producer = "ripgrep.file"}},
    {"<Leader>fb", snap.config.file {producer = "vim.buffer"}},
    {"<Leader>fo", snap.config.file {producer = "vim.oldfile"}},
    {"<Leader>ff", snap.config.vimgrep {}},
} ]]
snap.maps {
    {"<Leader><Leader>", snap.config.file {producer = "ripgrep.file"}},
    {"<Leader>sb", snap.config.file {producer = "vim.buffer"}},
    {"<Leader>so", snap.config.file {producer = "vim.oldfile"}},
    {"<Leader>sf", snap.config.vimgrep {}},
}
