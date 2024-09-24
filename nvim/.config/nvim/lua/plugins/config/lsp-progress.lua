--
-- plugins/config/lsp-progress.lua - config for lsp-progress plugin
--

-- Minimal configuration to show just a spinner if it's doing something.
require("lsp-progress").setup({
    -- Refreshing every 1000ms is enough for a statusline.
    -- Note: this doesn't actually refresh at the same time as lualine,
    -- so setting 1000 just means it refreshes twice every 1000ms. :(
    regular_internal_update_time = 1000,
    -- Spinners should spin clockwise
    -- spinner = { "⣷", "⣯", "⣟", "⡿", "⢿", "⣻", "⣽", "⣾" },
    spinner = { "⢎ ", "⠎⠁", "⠊⠑", "⠈⠱", " ⡱", "⢀⡰", "⢄⡠", "⢆⡀" },
    -- Format to show only the spinner.
    client_format = function(_, spinner, series_messages)
        return #series_messages > 0 and
            spinner or nil
    end,
    -- Format to show only when a language server is doing something.
    format = function(client_messages)
        return #client_messages > 0 and table.concat(client_messages, " ") or ""
    end,
})
