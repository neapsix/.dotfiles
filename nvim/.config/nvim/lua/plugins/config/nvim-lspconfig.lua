--
-- plugins/config/nvim-lspconfig.lua - config for nvim-lspconfig plugin
--

local runtime_path = vim.split(package.path, ';')
table.insert(runtime_path, 'lua/?.lua')
table.insert(runtime_path, 'lua/?/init.lua')

local capabilities = vim.lsp.protocol.make_client_capabilities()
-- capabilities = require 'cmp_nvim_lsp'.update_capabilities(capabilities)
capabilities = require 'cmp_nvim_lsp'.default_capabilities(capabilities)

local on_attach = require 'plugins.config.handlers'.on_attach

require 'lspconfig'.awk_ls.setup {}

require 'lspconfig'.lua_ls.setup {
    settings = {
        Lua = {
            runtime = {
                version = 'LuaJIT',
                path = 'runtime_path',
            },
            diagnostics = {
                globals = { 'vim' },
            },
            workspace = {
                library = vim.api.nvim_get_runtime_file('', true),
                checkThirdParty = false,
            },
            telemetry = {
                enable = false,
            },
        },
    },
    capabilities = capabilities,
    on_attach = on_attach,
}

require 'lspconfig'.gopls.setup {
    capabilities = capabilities,
    on_attach = on_attach,
}

require 'lspconfig'.ansiblels.setup {
    capabilities = capabilities,
    on_attach = on_attach,
}

require 'lspconfig'.pyright.setup {
    capabilities = capabilities,
    on_attach = on_attach,
}

require 'lspconfig'.templ.setup {
    capabilities = capabilities,
    on_attach = on_attach,
}

-- Mappings - same as defaults from nvim-lspconfig docs
vim.keymap.set('n', '<space>e', vim.diagnostic.open_float)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next)

-- Buffer-local mappings - Use autocmd to map after the language server
-- attaches to the buffer.
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('UserLspConfig', {}),
  callback = function(ev)
    -- Enable completion triggered by <c-x><c-o>
    -- Built-in compleiton handled with nvim-cmp.
    -- vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

    -- Buffer local mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    local opts = { buffer = ev.buf }
    -- vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
    -- Note: Use C-o and C-i to get back after going to definition
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
    vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
    -- vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, opts)
    -- vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, opts)
    vim.keymap.set('n', '<space>wl', function()
      print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, opts)
    -- Repetitive of gd for my purposes.
    -- vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, opts)
    vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, opts)
    vim.keymap.set({ 'n', 'v' }, '<space>ca', vim.lsp.buf.code_action, opts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
    -- Formatting handled with conform.nvim
    -- vim.keymap.set('n', '<space>f', function()
    --   vim.lsp.buf.format { async = true }
    -- end, opts)
  end,
})

-- Additional setup and helper functions for certain servers
local M = {}

-- gopls: Return a function that applies "organize imports" edits from gopls.
-- Used in the config for guard.nvim to fix imports when we run the formatter.
--
-- This code comes from the autocmd setup example in the gopls docs here:
-- https://github.com/golang/tools/blob/master/gopls/doc/vim.md#vim--neovim
function M.gopls_organize_imports ()
    local params = vim.lsp.util.make_range_params()
    params.context = { only = { 'source.organizeImports' } }
    -- buf_request_sync defaults to a 1000ms timeout. Depending on your
    -- machine and codebase, you may want longer. Add an additional
    -- argument after params if you find that you have to write the file
    -- twice for changes to be saved.
    -- E.g., vim.lsp.buf_request_sync(0, "textDocument/codeAction", params, 3000)
    local result =
        vim.lsp.buf_request_sync(0, 'textDocument/codeAction', params)
    for cid, res in pairs(result or {}) do
        for _, r in pairs(res.result or {}) do
            if r.edit then
                local enc = (vim.lsp.get_client_by_id(cid) or {}).offset_encoding
                    or 'utf-16'
                vim.lsp.util.apply_workspace_edit(r.edit, enc)
            end
        end
    end
    -- vim.lsp.buf.format { async = false }
end

return M
