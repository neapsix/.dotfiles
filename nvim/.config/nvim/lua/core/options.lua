--
-- options.lua - General Neovim settings
--

-- API aliases for declaring settings below
local opt = vim.opt
local g = vim.g

-- General
opt.mouse = 'a'                     -- Enable the mouse
opt.clipboard = 'unnamedplus'       -- Use the system clipboard
opt.cot = 'menuone,noselect'        -- Enable completion (ignored with nvim-cmp)
opt.hidden = true                   -- Enable hidden buffers

-- UI
opt.number = true                   -- Enable line numbers
-- opt.colorcolumn = '80'           -- Add a ruler at column 80
opt.showmatch = true                -- Show matching parentheses
opt.linebreak = true                -- Wrap lines on words
opt.termguicolors = true            -- Use 24-bit GUI colors
opt.splitbelow = true               -- Open horizontal splits more naturally
opt.splitright = true               -- Open vertical splits more naturally
opt.showmode = false		    -- Hide the mode when using a status plugin

-- Tabs and indenting
opt.tabstop = 8                     -- If a tab appears, show it as width 8
opt.softtabstop = 4                 -- In files with tabs, use 4-space indents
opt.shiftwidth = 4                  -- Use 4-space indents
opt.shiftwidth = 4                  -- Use 4-space indents
opt.expandtab = true                -- Write spaces instead of tabs
opt.smartindent = false             -- Indent the next line to the same level
opt.autoindent = false              -- Copy indent from current line to next

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

for _, plugin in pairs(disabled_built_ins) do
    g["loaded_" .. plugin] = 1
end
