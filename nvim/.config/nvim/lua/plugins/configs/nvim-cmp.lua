--
-- plugins/configs/nvim-cmp.lua - config for nvim-cmp plugin
--

local cmp = require 'cmp'

local cmp_mapping = {
    -- Ctrl+b and Ctrl+f scroll the docs window.
    ['<C-b>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
    ['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),

    -- Ctrl+Space checks for completion manually.
    ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
    
    -- Disable Ctrl+Y. By default, Ctrl+Y confirms the selected suggestion.
    -- ['<C-y>'] = cmp.config.disable,
    
    -- Ctrl+E aborts in insert mode and closes the menu in command mode.
    ['<C-e>'] = cmp.mapping({
        i = cmp.mapping.abort(),
        c = cmp.mapping.close(),
    }),

    -- Either Return or Tab confirms the first suggestion.
    -- ['<CR>'] = cmp.mapping(cmp.mapping.confirm({ select = true }), { 'i', 'c' }), 
    ['<Tab>'] = cmp.mapping(cmp.mapping.confirm({ select = true }), { 'i', 'c' }),

    -- Alternative mapping for Tab (from cmp wiki IntelliJ-style snippet):
    -- Don't select anything automatically. Tab selects then confirms.
    --[[ ["<Tab>"] = cmp.mapping(function(fallback)
        if cmp.visible() then
            local entry = cmp.get_selected_entry()
            if not entry then
                cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
            else
                cmp.confirm()
            end
        else
            fallback()
        end
    end, {"i","s","c",}), ]]
}

cmp.setup {
    mapping = cmp_mapping,
    sources = cmp.config.sources({
        { name = 'buffer' },
        { name = 'path' },
        { name = 'calc' },
    }),
}

cmp.setup.cmdline(':', {
    sources = {
        { name = 'cmdline' },
    },
})

cmp.setup.cmdline('/', {
    sources = {
        { name = 'buffer' },
    },
})
