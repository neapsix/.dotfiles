-- 
-- settings.lua - General Neovim settings
--

-- API aliases for declaring settings below
local opt = vim.opt

-- General
opt.mouse = 'a'                     -- Enable the mouse
opt.clipboard = 'unnamedplus'       -- Use the system clipboard
opt.completeopt = 'menuone,noselect'    -- Enable completion
opt.hidden = true                   -- Enable hidden buffers

-- UI
opt.number = true
-- opt.colorcolumn = '80'           -- Add a ruler at column 80
opt.showmatch = true                -- Show matching parentheses
opt.linebreak = true                -- Wrap lines on words
opt.termguicolors = true            -- Use 24-bit GUI colors
opt.splitbelow = true               -- Open horizontal splits more naturally
opt.splitright = true               -- Open vertical splits more naturally

-- Tabs and indenting
opt.expandtab = true                -- Write spaces instead of tabs
opt.tabstop = 8                     -- If a tab appears, show it as width 8
opt.softtabstop = 4                 -- In files with tabs, use 4-space indents
opt.shiftwidth = 4                  -- Use 4-space indents
opt.smartindent = true              -- Indent the next line to the same level

-- Performance
opt.swapfile = false                -- Don't use a swap file.
-- opt.history = 100                -- Does less history improve performance?
opt.lazyredraw = true               -- Improves performance with macros
opt.synmaxcol = 240                 -- Stop highlighting syntax on long lines
opt.updatetime = 400                -- Lower makes some plugins more responsive
