-- Contains filetype-specific options for templ (go library) files.
-- Loaded in the after/ftplugin/ directory to override the settings
-- in the global filetype plugin (see :help ftplugin-overrule).

-- Set options to use within this buffer
local opt = vim.opt_local

-- Use tabs to indent and show them 8 columns wide
opt.tabstop = 8
opt.expandtab = false
opt.shiftwidth = 8

-- Show a rule after column 80
opt.colorcolumn = "81"

-- Set text width to hard-wrap. Note: only comments are hard-wrapped.
-- The format options (:set fo?) have c but not t (see :help fo-table).
opt.textwidth = 80

opt.formatoptions = "cqj"
