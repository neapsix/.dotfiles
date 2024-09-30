--
-- mappings.lua - Key mappings for Neovim
--

-- Clear highlighting with Esc
vim.keymap.set("n", "<Esc>", "<cmd>noh<CR>")

-- Move around splits using Ctrl + {h,j,k,l}
vim.keymap.set("n", "<C-h>", "<C-w>h")
vim.keymap.set("n", "<C-j>", "<C-w>j")
vim.keymap.set("n", "<C-k>", "<C-w>k")
vim.keymap.set("n", "<C-l>", "<C-w>l")

-- Next/prev/first/last buffer with ]B ]b [b [B
-- Note: mini.bracketed provides a more complete version.
vim.keymap.set("n", "[B", "<cmd>bfirst<CR>", { desc = "First buffer" })
vim.keymap.set("n", "[b", "<cmd>bNext<CR>", { desc = "Previous buffer" })
vim.keymap.set("n", "]b", "<cmd>bnext<CR>", { desc = "Next buffer" })
vim.keymap.set("n", "]B", "<cmd>blast<CR>", { desc = "Last buffer" })

-- Close buffers with <leader>bd
vim.keymap.set("n", "<leader>bd", "<cmd>bd<CR>", { desc = "Buffer delete" })
vim.keymap.set("n", "<leader>bu", "<cmd>bu<CR>", { desc = "Buffer unload" })

-- Toggle diagnostic text with <leader>ll
vim.keymap.set("n", "<Leader>ll", function()
    vim.diagnostic.config {
        virtual_text = not vim.diagnostic.config().virtual_text,
    }
    print("virtual_text = " .. tostring(vim.diagnostic.config().virtual_text))
end, { desc = "LSP toggle virtual text" })

-- Toggle diagnostics altogether with <leader>lsp
vim.keymap.set("n", "<Leader>lsp", function()
    vim.diagnostic.enable(not vim.diagnostic.is_enabled())
    print("vim.diagnostic.is_enabled() = " .. tostring(vim.diagnostic.is_enabled()))
end, { desc = "LSP toggle diagnostics" })

-- Global LSP mappings
vim.keymap.set("n", "<space>e", vim.diagnostic.open_float, { desc = "LSP open float" })
-- Set by default
-- vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "LSP previous diagnostic" })
-- vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "LSP next diagnostic" })

-- Buffer-local mappings for built-in LSP support (set when a language server
-- attaches to a buffer. This autocommand replaces on_attach functions set by
-- lspconfig for each language server in older neovim versions.
vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("UserLspConfig", {}),
    callback = function(ev)
        -- Set by default
        -- Enable completion triggered by <c-x><c-o>
        -- vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"

        -- Set omnifunc for mini.completion (if activating on buffer attach)
        vim.o.omnifunc = 'v:lua.MiniCompletion.completefunc_lsp'

        -- Set buffer-local mappings for LSP functions.
        -- stylua: ignore start
        vim.keymap.set("n", "gD", vim.lsp.buf.declaration,
            { buffer = ev.buf, desc = "Go to declaration (LSP)" })
        vim.keymap.set("n", "gd", vim.lsp.buf.definition,
            { buffer = ev.buf, desc = "Go to definition (LSP)" })
        -- Set by default
        -- vim.keymap.set("n", "K", vim.lsp.buf.hover,
        --     { buffer = ev.buf, desc = "Hover (LSP)" })
        vim.keymap.set("n", "gi", vim.lsp.buf.implementation,
            { buffer = ev.buf, desc = "Go to implementation (LSP)" })
        vim.keymap.set("n", "<C-s>", vim.lsp.buf.signature_help,
            { buffer = ev.buf, desc = "Signature help (LSP)" })
        vim.keymap.set("n", "wa", vim.lsp.buf.add_workspace_folder,
            { buffer = ev.buf, desc = "Add workspace folder (LSP)" })
        vim.keymap.set("n", "wr", vim.lsp.buf.remove_workspace_folder,
            { buffer = ev.buf, desc = "Remove workspace folder (LSP)" })
        vim.keymap.set("n", "wl",
            function()
                print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
            end,
            { buffer = ev.buf, desc = "List workspace folders (LSP)" })
        vim.keymap.set("n", "<Space>D", vim.lsp.buf.type_definition,
            { buffer = ev.buf, desc = "Go to type definition (LSP)" })
        vim.keymap.set("n", "<Space>rn", vim.lsp.buf.rename,
            { buffer = ev.buf, desc = "Rename (LSP)" })
        vim.keymap.set("n", "<Space>ca", vim.lsp.buf.code_action,
            { buffer = ev.buf, desc = "Select code action here (LSP)" })
        -- Replaced by trouble (LSP definitions/references list)
        -- vim.keymap.set("n", "<Space>gr", vim.lsp.buf.references,
        --     { buffer = ev.buf, desc = "References (LSP)" })
        -- Note: formatting, including with the built-in LSP as below, is done
        -- through the Conform plugin (see plugins/config/conform.lua).
        -- vim.keymap.set("n", "<Space>f",
        --     function()
        --         vim.lsp.buf.format { async = true }
        --     end,
        --     { buffer = ev.buf, desc = "Format buffer (LSP)" })
        -- stylua: ignore end
    end,
})
