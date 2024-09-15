--
-- plugins/config/luasnip.lua - config for LuaSnip plugin
--

local luasnip = require "luasnip"

vim.keymap.set({ "i" }, "<C-K>", function()
    luasnip.expand()
end, { silent = true })
vim.keymap.set({ "i", "s" }, "<C-L>", function()
    luasnip.jump(1)
end, { silent = true })
vim.keymap.set({ "i", "s" }, "<C-J>", function()
    luasnip.jump(-1)
end, { silent = true })
vim.keymap.set({ "i", "s" }, "<C-E>", function()
    if luasnip.choice_active() then
        luasnip.change_choice(1)
    end
end, { silent = true })

require("luasnip.loaders.from_vscode").lazy_load {}
