--
-- autocmds.lua - Neovim auto-command definitions
--

-- API aliases for declaring settings below
local api = vim.api

-- Disable virtual text (linting) by default. Key in mappings.lua enables it.
api.nvim_create_autocmd("BufEnter", {
    callback = function()
        vim.diagnostic.config { virtual_text = false }
    end,
})

-- YAML: Set file type to yaml.ansible if the file contains ansible stuff.
api.nvim_create_autocmd("BufRead", {
    pattern = { "*.yaml", "*.yml" },
    command = [[if search('hosts:\|tasks:', 'nw') | set ft=yaml.ansible | endif]],
})

-- api.nvim_create_autocmd('BufReadPost', {
--     pattern = { '*.yaml', '*.yml' },
--     command = [[setlocal sts=2 sw=2 expandtab indentkeys-=0# indentkeys-=<:>]],
-- })

-- Help buffer: Press q to close the buffer.
api.nvim_create_autocmd("FileType", {
    pattern = "help",

    -- Vim command version:
    command = "nnoremap <silent><buffer> q :q<cr>",

    -- Lua version:
    -- callback = function ()
    --     api.nvim_buf_set_keymap(0, "n", "q", ":q<cr>", { silent = true })
    -- end
})

-- Markdown: Repeat bullets, numbered lists, and table leaders on the next line.
api.nvim_create_autocmd("FileType", {
    pattern = "markdown",

    -- Vim command version:
    -- command = 'setlocal formatoptions+=r comments=b:-,b:*,b:+,b:>,b:|'

    -- Lua version:
    callback = function()
        -- Add 'r' to repeat the comment leader character on a new line.
        api.nvim_buf_set_option(
            0,
            "formatoptions",
            api.nvim_buf_get_option(0, "formatoptions") .. "r"
        )
        -- Treat a bullet (-, *, +), blockquote (>), table (|), numbered list
        -- (1.), empty or filled checkbox (- [ ] or - [x]) symbol followed by a
        -- space as a single-line comment leader.
        api.nvim_buf_set_option(
            0,
            "comments",
            "b:- [ ],b:- [x],b:-,b:*,b:+,b:>,b:|,b:1."
        )
    end,
})

-- Highlight on yank using built-in function
api.nvim_create_autocmd("TextYankPost", {
    callback = function()
        vim.highlight.on_yank()
    end,
})

-- From Vim defaults: Go to where you left off when opening files (not commits).
vim.cmd [[
    autocmd BufReadPost *
      \ let line = line("'\"")
      \ | if line >= 1 && line <= line("$") && &filetype !~# 'commit'
      \      && index(['xxd', 'gitrebase'], &filetype) == -1
      \ |   execute "normal! g`\""
      \ | endif
]]
