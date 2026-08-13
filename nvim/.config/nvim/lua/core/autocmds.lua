--
-- autocmds.lua - Neovim auto-command definitions
--

-- API aliases for declaring settings below
local api = vim.api

-- Disable virtual text (linting) by default. Key in mappings.lua enables it.
api.nvim_create_autocmd("BufEnter", {
    callback = function() vim.diagnostic.config { virtual_text = false } end,
})

-- NOTE: Replaced by mfussenegger/nvim-ansible plugin.
-- YAML: Set file type to yaml.ansible if the file contains ansible stuff.
-- api.nvim_create_autocmd("BufRead", {
--     pattern = { "*.yaml", "*.yml" },
--     command = [[if search('hosts:\|tasks:\|ansible.builtin', 'nw') | set ft=yaml.ansible | endif]],
-- })

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

-- Markdown: In bullet and numbered lists, use Tab and Shift-Tab to indent.
local keycode = vim.keycode
    or function(x) return vim.api.nvim_replace_termcodes(x, true, true, true) end

local list_patterns = {
    "^%s*[%-%*%+]", -- bullet list (e.g. `- `, `* `, or `+ `)
    "^%s*%d+%.", -- numbered list (e.g. `1. `)
}

local map_tab = function()
    local rhs = function()
        -- If the text before the cursor is the start of a line, some spaces,
        -- a bullet or number, then anything, indent. Otherwise, type a tab.
        local line = vim.api.nvim_get_current_line()
        local cursor = vim.api.nvim_win_get_cursor(0)
        local before = line:sub(1, cursor[2])
        for _, v in pairs(list_patterns) do
            if before:match(v) then return keycode "<C-t>" end
        end
        return keycode "<Tab>"
    end

    vim.keymap.set("i", "<Tab>", rhs, { expr = true })
end

local map_shift_tab = function()
    local rhs = function()
        -- If the text before the cursor is the start of a line, some spaces,
        -- a bullet or number, then anything, un-indent.
        local line = vim.api.nvim_get_current_line()
        local cursor = vim.api.nvim_win_get_cursor(0)
        local before = line:sub(1, cursor[2])
        for _, v in pairs(list_patterns) do
            if before:match(v) then return keycode "<C-d>" end
        end
    end

    vim.keymap.set("i", "<S-Tab>", rhs, { expr = true })
end

-- Markdown: Repeat bullets, numbered lists, and table leaders on the next line.
api.nvim_create_autocmd("FileType", {
    pattern = "markdown",

    -- Vim command version:
    -- command = 'setlocal formatoptions+=r comments=b:-,b:*,b:+,b:>,b:|'

    -- Lua version:
    callback = function()
        local buf = api.nvim_get_current_buf()
        -- Add 'r' to repeat the comment leader character on a new line.
        api.nvim_set_option_value(
            "formatoptions",
            api.nvim_get_option_value("formatoptions", { buf = buf }) .. "r",
            { buf = buf }
        )
        -- Treat a bullet (-, *, +), blockquote (>), table (|), numbered list
        -- (1.), empty or filled checkbox (- [ ] or - [x]) symbol followed by a
        -- space as a single-line comment leader.
        api.nvim_set_option_value(
            "comments",
            "b:- [ ],b:- [x],b:-,b:*,b:+,b:>,b:|,b:1.",
            { buf = buf }
        )

        -- Indent bullets/numbered lists with Tab and Shift-Tab.
        map_tab()
        map_shift_tab()
    end,
})

-- Highlight on yank using built-in function
api.nvim_create_autocmd("TextYankPost", {
    callback = function() vim.highlight.on_yank() end,
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
