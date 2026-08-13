--
-- options.lua - General Neovim settings
--

-- API aliases for declaring settings below
local opt = vim.opt
local g = vim.g

-- stylua: ignore start
-- General
opt.mouse = 'a'                     -- Enable the mouse
opt.clipboard = 'unnamedplus'       -- Use the system clipboard
opt.cot = 'menuone,noselect'        -- Enable completion (ignored with nvim-cmp)
opt.hidden = true                   -- Enable hidden buffers

-- Editing
opt.virtualedit = "block"           -- Visual block selection past end of line

-- UI
opt.number = true                   -- Enable line numbers
-- opt.colorcolumn = '80'           -- Add a ruler at column 80
opt.showmatch = true                -- Show matching parentheses
opt.linebreak = true                -- Wrap lines on words
-- NOTE: neovim 0.10+ can detect termguicolors support, so might not be needed.
opt.termguicolors = true            -- Use 24-bit GUI colors
opt.splitbelow = true               -- Open horizontal splits more naturally
opt.splitright = true               -- Open vertical splits more naturally
opt.showmode = false		    -- Hide the mode when using a status plugin
opt.pumblend = 20                   -- Completion menu slightly transparent
opt.pumheight = 10                  -- Shorter completion menu
opt.winblend = 20                   -- Flooting windows slightly transparent

-- Tabs and indenting
opt.tabstop = 8                     -- If a tab appears, show it as width 8
opt.softtabstop = 4                 -- In files with tabs, use 4-space indents
opt.shiftwidth = 4                  -- Use 4-space indents
opt.expandtab = true                -- Write spaces instead of tabs
opt.autoindent = true               -- Copy indent from current line to next
opt.smartindent = true              -- Indent the next line to the same level
opt.breakindent = true              -- Wrap long lines at the indent level

-- Search
opt.ignorecase = true               -- Ignore case when searching (use \C for strict)
opt.smartcase = true                -- But not if pattern has upper case
opt.infercase = true                -- Infer letter case for built-in keyword

-- Performance
opt.swapfile = false                -- Don't use a swap file.
-- opt.history = 100                -- Does less history improve performance?
opt.lazyredraw = true               -- Improves performance with macros
opt.synmaxcol = 240                 -- Stop highlighting syntax on long lines
opt.updatetime = 400                -- Lower makes some plugins more responsive

local disabled_built_ins = {        -- Disable built-in plugins to start faster
    "netrw",
    "netrwPlugin",
    "netrwSettings",
    "netrwFileHandlers",
    "gzip",
    "zip",
    "zipPlugin",
    "tar",
    "tarPlugin",
    "getscript",
    "getscriptPlugin",
    "vimball",
    "vimballPlugin",
    "2html_plugin",
    "logipat",
    "rrhelper",
    "spellfile_plugin",
    "matchit"
}
-- stylua: ignore end

for _, plugin in pairs(disabled_built_ins) do
    g["loaded_" .. plugin] = 1
end
