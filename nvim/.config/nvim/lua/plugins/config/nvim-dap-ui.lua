--
-- plugins/config/nvim-dap-ui.lua - config for nvim-dap-ui plugin
--

local dap, dapui = require "dap", require "dapui"

dapui.setup()

-- Automatically open and close the DAP UI with a debug session.
dap.listeners.after.event_initialized["dapui_config"] = function()
    dapui.open()
end

dap.listeners.before.event_terminated["dapui_config"] = function()
    dapui.close()
end

dap.listeners.before.event_exited["dapui_config"] = function()
    dapui.close()
end
