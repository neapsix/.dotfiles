--
-- plugins/config/nvim-treesitter.lua - config for nvim-treesitter plugin
--

-- NOTE: treesitter-cli must be installed too.
local ts = require "nvim-treesitter"

local ensure_installed = {
    "beancount",
    "c",
    "html",
    "javascript",
    "lua",
    "markdown",
    "query",
    "svelte",
    "templ",
    "typescript",
    "vim",
    "vimdoc",
}
ts.install(ensure_installed)

vim.treesitter.query.set("lua", "injections", "")

vim.api.nvim_create_autocmd("FileType", {
    callback = function()
        -- Enable treesitter highlighting and disable regex syntax
        pcall(vim.treesitter.start)
        -- Enable treesitter-based indentation
        vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
    end,
})
