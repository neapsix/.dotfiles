--
-- plugins/config/mini/completion.lua - config for mini.completion plugin
--

require("mini.completion").setup {
    source_func = "omnifunc",
    auto_setup = false,
}

-- To use `<Tab>` and `<S-Tab>` for navigation through completion list

local imap_expr = function(lhs, rhs)
    vim.keymap.set("i", lhs, rhs, { expr = true })
end
imap_expr("<Tab>", [[pumvisible() ? "\<C-n>" : "\<Tab>"]])
imap_expr("<S-Tab>", [[pumvisible() ? "\<C-p>" : "\<S-Tab>"]])

-- To get more consistent behavior of `<CR>`. With the list visible and
-- an item selected (i.e., completed in the text), it should confirm
-- and close, not add a new line.

local keycode = vim.keycode
    or function(x)
        return vim.api.nvim_replace_termcodes(x, true, true, true)
    end
local keys = {
    ["cr"] = keycode "<CR>",
    ["ctrl-y"] = keycode "<C-y>",
    ["ctrl-y_cr"] = keycode "<C-y><CR>",
}

_G.cr_action = function()
    if vim.fn.pumvisible() ~= 0 then
        -- If popup is visible, confirm selected item (and close list)
        local item_selected = vim.fn.complete_info()["selected"] ~= -1
        return item_selected and keys["ctrl-y"] or keys["ctrl-y_cr"]
    else
        -- If popup is not visible, use plain `<CR>`. You might want to customize
        -- according to other plugins. For example, to use 'mini.pairs', replace
        -- next line with `return require('mini.pairs').cr()`
        -- return keys["cr"]
        return require('mini.pairs').cr()
    end
end

vim.keymap.set("i", "<CR>", "v:lua._G.cr_action()", { expr = true })
