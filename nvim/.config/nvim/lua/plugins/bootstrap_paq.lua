--
-- bootstrap.lua - Bootstrap Paq if not installed
--

local function clone_paq()
    local path = vim.fn.stdpath "data" .. "/site/pack/paqs/start/paq-nvim"

    if vim.fn.empty(vim.fn.glob(path)) > 0 then
        vim.fn.system {
            "git",
            "clone",
            "--depth=1",
            "https://github.com/savq/paq-nvim.git",
            path,
        }
    end
end

local function bootstrap_paq()
    clone_paq()

    -- Don't load Paq at this point. We'll list it in its own list of plugins.
    -- vim.cmd('packadd paq-nvim')

    local paq = require "paq"

    return paq
end

return { bootstrap_paq = bootstrap_paq }
