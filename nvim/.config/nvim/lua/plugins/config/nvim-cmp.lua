--
-- plugins/config/nvim-cmp.lua - config for nvim-cmp plugin
--

-- local has_words_before = function()
--     local line, col = unpack(vim.api.nvim_win_get_cursor(0))
--     return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
-- end

local cmp = require "cmp"
local luasnip = require "luasnip"

-- Add () when inserting a function with completion.
local cmp_autopairs = require "nvim-autopairs.completion.cmp"
cmp.event:on(
    "confirm_done",
    cmp_autopairs.on_confirm_done { map_char = { tex = "" } }
)

local snippet = {
    expand = function(args)
        luasnip.lsp_expand(args.body)
    end,
}

local mapping = {
    -- Ctrl+k and Ctrl+j select items. Arrows also work.
    ["<C-k>"] = cmp.mapping.select_prev_item(),
    ["<C-j>"] = cmp.mapping.select_next_item(),

    -- Ctrl+f and Ctrl+b scroll the docs window.
    ["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(-4), { "i", "c" }),
    ["<C-b>"] = cmp.mapping(cmp.mapping.scroll_docs(4), { "i", "c" }),

    -- Ctrl+Space checks for completion manually.
    ["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),

    -- Change to the following if you run into the issue described in
    -- https://github.com/hrsh7th/nvim-cmp/issues/531
    -- ['<C-Space>'] = cmp.mapping(cmp.mapping.complete({
    --     reason = cmp.ContextReason.Auto,
    --   }), { 'i', 'c' }),

    -- Disable Ctrl+Y. By default, Ctrl+Y confirms the selected suggestion.
    -- ['<C-y>'] = cmp.config.disable,

    -- Ctrl+E aborts in insert mode and closes the menu in command mode.
    ["<C-e>"] = cmp.mapping {
        i = cmp.mapping.abort(),
        c = cmp.mapping.close(),
    },

    -- Ctrl+y confirms the first suggestion.
    -- ['<C-y>'] = cmp.mapping.confirm({ select = true }),

    -- Ctrl+y confirms the first suggestion or jumps into a snippet.
    ["<C-y>"] = cmp.mapping(function(fallback)
        if cmp.visible() then
            -- cmp.select_next_item()
            cmp.confirm { select = true }
        elseif luasnip.expand_or_jumpable() then
            luasnip.expand_or_jump()
        -- elseif has_words_before() then
        --     cmp.complete()
        else
            fallback()
        end
    end, { "i", "s" }),

    -- Shift+y jumps out of a snippet
    ["<S-y>"] = cmp.mapping(function(fallback)
        -- if cmp.visible() then
        --      cmp.select_prev_item()
        --  elseif luasnip.jumpable(-1) then
        if luasnip.jumpable(-1) then
            luasnip.jump(-1)
        else
            fallback()
        end
    end, { "i", "s" }),
}

cmp.setup {
    completion = { autocomplete = false },
    snippet = snippet,
    mapping = mapping,
    sources = cmp.config.sources({
        { name = "nvim_lsp" },
        { name = "nvim_lsp_signature_help" },
        { name = "luasnip" },
    }, {
        { name = "buffer" },
        { name = "path" },
        { name = "calc" },
    }),
    window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
    },
    formatting = {
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
    },
    experimental = {
        ghost_text = true,
    },
}

cmp.setup.cmdline(":", {
    sources = {
        { name = "cmdline" },
    },
})

cmp.setup.cmdline("/", {
    sources = {
        { name = "buffer" },
    },
})

-- Capabilities are set up in nvim-lspconfig.lua

--[[ local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require 'cmp_nvim_lsp'.update_capabilities(capabilities) ]]
