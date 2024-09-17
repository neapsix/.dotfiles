--
-- plugins/config/lsp-progress.lua - config for lsp-progress plugin
--

-- Minimal configuration to show just the name of the language server
-- and a spinner if it's doing something.
require("lsp-progress").setup({
    -- Because we're only showing the spinner, don't update way more
    -- often than the spinner's fixed update rate (200 by default).
    event_update_time_limit = 100,
    -- Don't make lualine refresh more often than its default time.
    -- Note: this doesn't actually refresh at the same time as lualine,
    -- so setting 1000 just means it refreshes twice every 1000ms. :(
    regular_internal_update_time = 1000,
    -- Spinners should spin clockwise
    spinner = { "⣷", "⣯", "⣟", "⡿", "⢿", "⣻", "⣽", "⣾" },
    client_format = function(client_name, spinner, series_messages)
        -- Show only ls name in brackets and spinner.
        return #series_messages > 0 and
            ("[" .. client_name .. "] " .. spinner) or nil
    end,
    format = function(client_messages)
        -- Show messages if the ls is doing something.
        if #client_messages > 0 then
            return table.concat(client_messages, " ")
        end

        -- Otherwise show the names of all ls attached to this buffer.
        local clients = vim.lsp.get_clients()

        if #clients > 0 then
            local client_names = {}

            for _, client in pairs(clients) do
                if client.name ~= "" then
                    table.insert(client_names, ("[" .. client.name .. "]"))
                end
            end

            return table.concat(client_names, " ")
        end

        return ""

        -- To show only when it's doing something, use this instead.
        -- return #messages > 0 and table.concat(messages, " ") or ""
    end,
})
