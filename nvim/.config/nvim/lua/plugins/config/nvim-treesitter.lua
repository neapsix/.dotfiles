--
-- plugins/config/nvim-treesitter.lua - config for nvim-treesitter plugin
--

if vim.fn.executable "tree-sitter" == 0 then
    vim.print "Aborting nvim-treesitter plugin setup because tree-sitter-cli is not installed."
    return
end

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
