--
-- plugins/config/handlers.lua - contains on_attach func for LSPs.
--

local M = {}

-- Run by LSP servers when attaching to a buffer. Specify this function
-- in the lspconfig setup for each LSP server.
function M.on_attach()
    -- Set buffer-local mappings for LSP functions.
    vim.keymap.set(
        "n",
        "gD",
        vim.lsp.buf.declaration,
        { desc = "Go to declaration (LSP)" }
    )
    vim.keymap.set(
        "n",
        "gd",
        vim.lsp.buf.definition,
        { desc = "Go to definition (LSP)" }
    )
    vim.keymap.set(
        "n",
        "K",
        vim.lsp.buf.hover,
        { desc = "Hover (LSP)" }
    )
    vim.keymap.set(
        "n",
        "gi",
        vim.lsp.buf.implementation,
        { desc = "Go to implementation (LSP)" }
    )
    vim.keymap.set(
        "n",
        "T",
        vim.lsp.buf.signature_help,
        { desc = "Signature help (LSP)" }
    )
    vim.keymap.set(
        "n",
        "wa",
        vim.lsp.buf.add_workspace_folder,
        { desc = "Add workspace folder (LSP)" }
    )
    vim.keymap.set(
        "n",
        "wr",
        vim.lsp.buf.remove_workspace_folder,
        { desc = "Remove workspace folder (LSP)" }
    )
    vim.keymap.set(
        "n",
        "wl",
        function()
            print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
        end,
        { desc = "List workspace folders(LSP)" }
    )
    vim.keymap.set(
        "n",
        "<Space>D",
        vim.lsp.buf.type_definition,
        { desc = "Go to type definition (LSP)" }
    )
    vim.keymap.set(
        "n",
        "<Space>rn",
        vim.lsp.buf.rename,
        { desc = "Rename (LSP)" }
    )
    vim.keymap.set(
        "n",
        "<Space>ca",
        vim.lsp.buf.code_action,
        { desc = "Select code action here (LSP)" }
    )
    -- Replaced by trouble (LSP definitions/references list)
    -- vim.keymap.set(
    --     "n",
    --     "<Space>gr",
    --     vim.lsp.buf.references,
    --     { desc = "References (LSP)" }
    -- )
    -- Note: formatting, including with the built-in LSP as below, is done
    -- through the Conform plugin (see plugins/config/conform.lua).
    -- vim.keymap.set(
    --     "n",
    --     "<Space>f",
    --     function()
    --         vim.lsp.buf.format { async = true }
    --     end,
    --     { desc = "Format buffer (LSP)" }
    -- )

    -- Set omnifunc for mini.completion (if activating on buffer attach)
    -- vim.o.omnifunc = 'v:lua.MiniCompletion.completefunc_lsp'
end

return M
