--
-- autocmds.lua - Neovim auto-command definitions
--

-- API aliases for declaring settings below
local api = vim.api

api.nvim_create_autocmd('BufRead', {
    pattern = { '*.yaml', '*.yml' },
    command = [[if search('hosts:\|tasks:', 'nw') | set ft=yaml.ansible | endif]],
})

-- api.nvim_create_autocmd('BufReadPost', {
--     pattern = { '*.yaml', '*.yml' },
--     command = [[setlocal sts=2 sw=2 expandtab indentkeys-=0# indentkeys-=<:>]],
-- })

vim.api.nvim_create_autocmd('FileType', {
    pattern = 'help',
    command = 'nnoremap <silent><buffer> q :q<cr>',
    -- callback = function ()
    --     api.nvim_buf_set_keymap(0, "n", "q", ":q<cr>", { silent = true })
    -- end
})
