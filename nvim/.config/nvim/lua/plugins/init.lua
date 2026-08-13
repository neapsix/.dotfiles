--
-- plugins/init.lua - Plugins for Neovim
--

-- Commands to update, view, and autoremove plugins
vim.api.nvim_create_user_command("PackUpdate", function() vim.pack.update() end, {})
vim.api.nvim_create_user_command(
    "PackInfo",
    function() vim.pack.update(nil, { offline = true }) end,
    {}
)
vim.api.nvim_create_user_command("PackClean", function()
    local inactive = vim.iter(vim.pack.get())
        :filter(function(x) return not x.active end)
        :map(function(x) return x.spec.name end)
        :totable()
    vim.pack.del(inactive)
end, {})

-- Update nvim-treesitter if it changes.
vim.api.nvim_create_autocmd("PackChanged", {
    callback = function(ev)
        local name, kind = ev.data.spec.name, ev.data.kind
        if name == "nvim-treesitter" and kind == "update" then
            if not ev.data.active then vim.cmd.packadd "nvim-treesitter" end
            vim.cmd "TSUpdate"
        end
    end,
})

local gh = function(x) return "https://github.com/" .. x end
vim.pack.add {
    -- Package manager
    gh "williamboman/mason.nvim",
    gh "WhoIsSethDaniel/mason-tool-installer.nvim",

    -- Basic editor features
    -- NOTE: Prefer Comment.nvim to built-in commenting and mini.comment
    -- for block comments and horizontal motions, e.g. gc$.
    gh "numToStr/Comment.nvim",
    gh "nvim-mini/mini.nvim",

    -- Syntax features
    gh "nvim-treesitter/nvim-treesitter",
    gh "windwp/nvim-ts-autotag",
    gh "abecodes/tabout.nvim",

    -- LSP, linting, and formatting
    gh "neovim/nvim-lspconfig",
    gh "mfussenegger/nvim-lint",
    gh "stevearc/conform.nvim",
    gh "folke/trouble.nvim",

    -- DAP UI
    gh "nvim-neotest/nvim-nio",
    gh "mfussenegger/nvim-dap",
    gh "rcarriga/nvim-dap-ui",

    -- DAP language support
    gh "leoluz/nvim-dap-go",

    -- UI features
    gh "linrongbin16/lsp-progress.nvim",
    gh "neapsix/glow.nvim", -- My patched version of glow.nvim

    -- Theme
    gh "rose-pine/neovim",
    -- gh "shaunsingh/nord.nvim";
    -- gh "catppuccin/nvim",
    -- gh "folke/tokyonight.nvim",
    -- gh "nyoom-engineering/oxocarbon.nvim",

    -- Language/filetype support
    gh "mfussenegger/nvim-ansible",
    gh "SCJangra/table-nvim",
}

require("rose-pine").setup {
    highlight_groups = {
        Comment = { fg = "muted" },
    },
}

-- require("catppuccin").setup {
--     flavour = "macchiato",
-- }

-- require("tokyonight").setup {
--     style = "storm",
-- }

-- Select a color scheme
-- Note: Do this before setting up plugins that need to be themed
vim.cmd [[colorscheme rose-pine]]
-- vim.cmd [[colorscheme nord]]
-- vim.cmd [[colorscheme catppuccin]]
-- vim.cmd [[colorscheme tokyonight]]
-- vim.cmd [[colorscheme oxocarbon]]

-- Run after-install setup for plugins that need it
require("mason").setup {}
require "plugins.config.mason-tool-installer"

-- Load mini.pairs before mini.completion
require "plugins.config.mini.pairs"
require("Comment").setup {}
require("mini.ai").setup {}
require("mini.align").setup {}
-- require("mini.bracketed").setup {} -- Replaces next/prev buffer with [b ]b
require "plugins.config.mini.bufremove"
require "plugins.config.mini.clue"
-- Load mini.completion after mini.pairs
require "plugins.config.mini.completion"
require "plugins.config.mini.diff"
require "plugins.config.mini.files"
-- Load mini.git before custom statusline or mini.statusline.
require("mini.git").setup {}
require "plugins.config.mini.hipatterns"
require("mini.icons").setup {} -- Works as drop-in for nvim-web-devicons
-- Set up mini.indentscope to get the text objects, but disable visuals.
-- Note: snacks.nvim splits out text objects in scope module
vim.g.miniindentscope_disable = true
require("mini.indentscope").setup {}
require "plugins.config.mini.map"
require("mini.operators").setup {}
require "plugins.config.mini.pick"
require "plugins.config.mini.sessions"
require("mini.splitjoin").setup {}
-- Load mini.statusline after mini.git and mini.diff.
-- require "plugins.config.mini.statusline"
require("mini.surround").setup {}
require("mini.trailspace").setup {}

require "plugins.config.nvim-treesitter"
require("nvim-ts-autotag").setup {}

require "plugins.config.nvim-lint"
require "plugins.config.conform"
require "plugins.config.nvim-lspconfig"
require "plugins.config.trouble"

-- If a completion plugin uses the tab key, load tabout after.
require("tabout").setup {}

require "plugins.config.nvim-dap"
require "plugins.config.nvim-dap-ui"
require("dap-go").setup {}
require("table-nvim").setup {}

require "plugins.config.lsp-progress"
-- Load statusline after lsp-progress, mini.git, and mini.diff.
require("plugins.config.statusline").setup {}
vim.g.glow_no_install = true -- Config for patched glow.nvim
