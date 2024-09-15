--
-- plugins/config/mini/sessions.lua - config for mini.sessions plugin
--

require("mini.sessions").setup {
    force = {
        delete = true, -- Allow deleting current session.
    },
}

-- Prompt for a name and write a global session with that name.
local function session_new()
    vim.ui.input({ prompt = "Enter session name: " }, function(input)
        if input == nil or input == "" then
            print "No file name. Session not saved."
            return
        end
        if string.find(input, '[\\/:*?"<>|]') then
            print "Invalid file name. Session not saved."
            return
        end
        MiniSessions.write(tostring(input))
    end)
end

-- Prompt to delete a session from a list of global sessions.
local function session_select_delete()
    MiniSessions.select "delete"
end

vim.keymap.set("n", "<leader>sa", session_new)
vim.keymap.set("n", "<leader>sr", MiniSessions.read)
vim.keymap.set("n", "<leader>ss", MiniSessions.select)
vim.keymap.set("n", "<leader>sd", session_select_delete)
vim.keymap.set("n", "<leader>sD", MiniSessions.delete)
