--
-- plugins/config/mini/pairs.lua - config for mini.pairs plugin
--

local pairs = require "mini.pairs"
pairs.setup {}

-- Extra logic for mini.pairs borrowed from LazyVim
local open = pairs.open
pairs.open = function(pair, neigh_pattern)
    local o, c = pair:sub(1, 1), pair:sub(2, 2)
    -- In markdown files, if you type three backticks (```), add a new line then
    -- the matching pair. Without this, ``` makes ```` (two pairs of singles).
    local line = vim.api.nvim_get_current_line()
    local cursor = vim.api.nvim_win_get_cursor(0)
    local before = line:sub(1, cursor[2])
    if o == "`" and vim.bo.filetype == "markdown" and before:match "^%s*``" then
        return "`\n```"
            .. vim.api.nvim_replace_termcodes("<up>", true, true, true)
    end

    -- Skip auto-pair when the next character is one of these. For example, if
    -- you type " before a word, add just one quotation mark instead of a pair.
    local skip_next = [=[[%w%%%'%[%"%.%`%$]]=]
    local next = line:sub(cursor[2] + 1, cursor[2] + 1)
    if next ~= "" and next:match(skip_next) then return o end

    -- Skip auto-pair when the next character is the closing pair and there are
    -- more closing pairs than opening pairs. For example, type { here { | } }.
    if next == c and c ~= o then
        local _, count_open = line:gsub(vim.pesc(pair:sub(1, 1)), "")
        local _, count_close = line:gsub(vim.pesc(pair:sub(2, 2)), "")
        if count_close > count_open then return o end
    end

    return open(pair, neigh_pattern)
end
