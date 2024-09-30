--
-- plugins/config/mini/completion.lua - tweaks to built-in completion
--     for use with mini.completion and mini.pairs.
--
-- Notes:
--   - This file doesn't require mini.completion. It also affects the
--     built-in completion (<C-x><C-o>).
--   - Only one line requires mini.pairs (with an alternative for stock).
--   - Load after mini.pairs (and any other plugin that remaps <CR>).
--

require("mini.completion").setup {
    source_func = "omnifunc",
    auto_setup = false,
}

-- To use `<Tab>` and `<S-Tab>` for navigation through completion list
-- local imap_expr = function(lhs, rhs)
--     vim.keymap.set("i", lhs, rhs, { expr = true })
-- end
-- imap_expr("<Tab>", [[pumvisible() ? "\<C-n>" : "\<Tab>"]])
-- imap_expr("<S-Tab>", [[pumvisible() ? "\<C-p>" : "\<S-Tab>"]])

-- To get more consistent behavior of `<CR>`. With the list visible and
-- an item selected (i.e., completed in the text), confirm and close.
-- Without this, it confirms and closes and also adds a new line.
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
        -- If popup is not visible, use plain `<CR>`.
        -- return keys["cr"]
        -- Or use mini.pairs function instead of plain `<CR>`.
        return require("mini.pairs").cr()
    end
end

vim.keymap.set("i", "<CR>", "v:lua._G.cr_action()", { expr = true })

-- Auto-insert () and put the cursor in the middle after completing a function.
-- Credit to LazyVim (auto_brackets function in util.cmp.lua)
local function auto_brackets()
    local completed_item_kind = vim.v.completed_item.kind
    if not completed_item_kind then return end

    if completed_item_kind == "Function" then
        local cursor = vim.api.nvim_win_get_cursor(0)
        local prev_char = vim.api.nvim_buf_get_text(0, cursor[1] - 1, cursor[2], cursor[1] - 1, cursor[2] + 1, {})[1]
        if prev_char ~= "(" and prev_char ~= ")" then
            local keys_to_feed = vim.api.nvim_replace_termcodes("()<left>", false, false, true)
            vim.api.nvim_feedkeys(keys_to_feed, "i", true)
        end
    end
end

vim.api.nvim_create_autocmd({ "CompleteDonePre" }, {
    pattern = "*",
    callback = function() auto_brackets() end,
})
