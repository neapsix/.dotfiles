--
-- plugins/config/nvim-lint.lua - config for nvim-lint plugin
--

require("lint").linters_by_ft = {
    markdown = { "vale", "markdownlint" },
    sh = { "shellcheck" },
}

vim.api.nvim_create_autocmd("BufWritePost", {
    callback = function()
        require("lint").try_lint()
    end,
})
