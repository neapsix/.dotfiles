local M = {}

function M.on_attach(client, bufnr)
    local mappings = {
        ["gD"] = "vim.lsp.buf.declaration()",
        ["gd"] = "vim.lsp.buf.definition()",
        ["K"] = "vim.lsp.buf.hover()",
        ["gi"] = "vim.lsp.buf.implementation()",
        ["T"] = "vim.lsp.buf.signature_help()",
        ["<Space>wa"] = "vim.lsp.buf.add_workspace_folder()",
        ["<Space>wr"] = "vim.lsp.buf.remove_workspace_folder()",
        ["<Space>wl"] = "print(vim.inspect(vim.lsp.buf.list_workspace_folders()))",
        ["<Space>D"] = "vim.lsp.buf.type_definition()",
        ["<Space>rn"] = "vim.lsp.buf.rename()",
        ["<Space>ca"] = "vim.lsp.buf.code_action()",
        -- ['<Space>gr'] = 'vim.lsp.buf.references', -- Replaced by trouble
        -- Note: formatting, including with the built-in LSP as below, is done
        -- through the Guard plugin (see plugins/config/guard.lua).
        -- ['<Space>f'] = 'vim.lsp.buf.format { async = true }', -- Replaced by guard
    }

    for key, lua_string in pairs(mappings) do
        local options = { noremap = true, silent = true }

        local command_string = "<CMD>lua " .. lua_string .. "<CR>"

        vim.api.nvim_set_keymap("n", key, command_string, options)
    end
end

return M
