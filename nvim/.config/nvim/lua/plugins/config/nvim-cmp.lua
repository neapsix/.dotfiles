--
-- plugins/config/nvim-cmp.lua - config for nvim-cmp plugin
--

-- Note: additional line in nvim-lspconfig.lua to set capabilities

local cmp = require "cmp"
local luasnip = require "luasnip"

local expand_or_complete = function(fallback)
    if cmp.visible() then
        if luasnip.expandable() then
            luasnip.expand()
        else
            cmp.confirm {
                select = false, -- Complete only if selected.
            }
        end
    else
        fallback()
    end
end

local expand_or_complete_first = function(fallback)
    if cmp.visible() then
        if luasnip.expandable() then
            luasnip.expand()
        else
            cmp.confirm {
                select = true, -- Complete first item.
            }
        end
    else
        fallback()
    end
end

local next_or_jump = function(fallback)
    -- if cmp.visible() then
    --     cmp.select_next_item()
    -- elseif luasnip.locally_jumpable(1) then
    if luasnip.locally_jumpable(1) then
        luasnip.jump(1)
    else
        fallback()
    end
end

local prev_or_jump = function(fallback)
    -- if cmp.visible() then
    --     cmp.select_prev_item()
    -- elseif luasnip.locally_jumpable(-1) then
    if luasnip.locally_jumpable(-1) then
        luasnip.jump(-1)
    else
        fallback()
    end
end

local config_snippet = {
    expand = function(args)
        luasnip.lsp_expand(args.body)
    end,
}

local config_mapping = cmp.mapping.preset.insert {
    ["<C-b>"] = cmp.mapping.scroll_docs(-4),
    ["<C-f>"] = cmp.mapping.scroll_docs(4),
    ["<C-Space>"] = cmp.mapping.complete(),
    ["<C-e>"] = cmp.mapping.abort(),
    -- Use this line if not using snippets.
    -- ["<CR>"] = cmp.mapping.confirm { select = true },
    ["<CR>"] = cmp.mapping(expand_or_complete),
    ["<C-y>"] = cmp.mapping(expand_or_complete_first),
    ["<Tab>"] = cmp.mapping(next_or_jump, { "i", "s" }),
    ["<S-Tab>"] = cmp.mapping(prev_or_jump, { "i", "s" }),
}

local config_sources = cmp.config.sources({
    { name = "nvim_lsp" },
    { name = "nvim_lsp_signature_help" },
    { name = "luasnip" },
}, {
    { name = "buffer" },
    { name = "path" },
    { name = "calc" },
})

local config_formatting = {
    format = function(entry, vim_item)
        -- Add a label for the source as the "menu" string for each item
        vim_item.menu = ({
            nvim_lsp = "[LSP]",
            nvim_lsp_signature_help = "[Signature]",
            luasnip = "[LuaSnip]",
            buffer = "[Buffer]",
            path = "[Path]",
            calc = "[Calc]",
        })[entry.source.name]
        return vim_item
    end,
}

cmp.setup {
    snippet = config_snippet,
    mapping = config_mapping,
    sources = config_sources,
    formatting = config_formatting,
}

cmp.setup.cmdline({ "/", "?" }, {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
        { name = "buffer" },
    },
})

cmp.setup.cmdline({ ":" }, {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
        { name = "path" },
    }, {
        { name = "cmdline" },
    }),
    matching = { disallow_symbol_nonprefix_matching = false },
})

-- Add () when inserting a function with completion.
local cmp_autopairs = require "nvim-autopairs.completion.cmp"
cmp.event:on(
    "confirm_done",
    cmp_autopairs.on_confirm_done { map_char = { tex = "" } }
)
