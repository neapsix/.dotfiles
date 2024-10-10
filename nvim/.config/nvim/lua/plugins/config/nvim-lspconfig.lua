--
-- plugins/config/nvim-lspconfig.lua - config for nvim-lspconfig plugin
--

local runtime_path = vim.split(package.path, ";")
table.insert(runtime_path, "lua/?.lua")
table.insert(runtime_path, "lua/?/init.lua")

local capabilities = vim.lsp.protocol.make_client_capabilities()
-- capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

-- Note: buffer-local mappings for LSP functions are set with an
-- LspAttach autocmd defined in the core/mappings.lua file.

require("lspconfig").ansiblels.setup { capabilities = capabilities }

require("lspconfig").awk_ls.setup { capabilities = capabilities }

require("lspconfig").lua_ls.setup {
    settings = {
        Lua = {
            runtime = {
                version = "LuaJIT",
                path = "runtime_path",
            },
            diagnostics = {
                globals = { "vim" },
            },
            completion = {
                showWord = "Disable",
                workspaceWord = false,
            },
            workspace = {
                checkThirdParty = false,
                library = { vim.env.VIMRUNTIME }
                -- This is a lot slower:
                -- library = vim.api.nvim_get_runtime_file("", true),
            },
            telemetry = {
                enable = false,
            },
            format = {
                enable = false,
            },
        },
    },
    capabilities = capabilities,
}

require("lspconfig").gopls.setup { capabilities = capabilities }

require("lspconfig").pyright.setup { capabilities = capabilities }

require("lspconfig").templ.setup { capabilities = capabilities }

-- Additional setup and helper functions for certain servers
local M = {}

-- gopls: Return a function that applies "organize imports" edits from gopls.
-- Used in the config for conform.nvim to fix imports when we run the formatter.
--
-- This code comes from the autocmd setup example in the gopls docs here:
-- https://github.com/golang/tools/blob/master/gopls/doc/vim.md#vim--neovim
function M.gopls_organize_imports()
    local params = vim.lsp.util.make_range_params()
    params.context = { only = { "source.organizeImports" } }
    -- buf_request_sync defaults to a 1000ms timeout. Depending on your
    -- machine and codebase, you may want longer. Add an additional
    -- argument after params if you find that you have to write the file
    -- twice for changes to be saved.
    -- E.g., vim.lsp.buf_request_sync(0, "textDocument/codeAction", params, 3000)
    local result =
        vim.lsp.buf_request_sync(0, "textDocument/codeAction", params)
    for cid, res in pairs(result or {}) do
        for _, r in pairs(res.result or {}) do
            if r.edit then
                local enc = (vim.lsp.get_client_by_id(cid) or {}).offset_encoding
                    or "utf-16"
                vim.lsp.util.apply_workspace_edit(r.edit, enc)
            end
        end
    end
    -- vim.lsp.buf.format { async = false }
end

return M
