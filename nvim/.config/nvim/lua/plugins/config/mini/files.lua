--
-- plugins/config/mini/files.lua - config for mini.files plugin
--

require("mini.files").setup {}

local minifiles_toggle = function(...)
    if not MiniFiles.close() then MiniFiles.open(...) end
end

vim.keymap.set("n", "<leader>F", minifiles_toggle, { desc = "mini.files toggle" })

local map_split = function(buf_id, lhs, direction)
    local rhs = function()
        -- If selected line is a directory, do nothing
        local fs_entry = MiniFiles.get_fs_entry()
        if fs_entry.fs_type ~= "file" then return end

        -- Make new window and set it as target
        local cur_target = MiniFiles.get_explorer_state().target_window
        local new_target = vim.api.nvim_win_call(cur_target, function()
            vim.cmd(direction .. " split")
            return vim.api.nvim_get_current_win()
        end)
        MiniFiles.set_target_window(new_target)

        -- Open file and close mini.files
        MiniFiles.go_in({ close_on_file = true })
    end

    -- Add desc to show in mini.files help
    local desc = "Split " .. direction
    vim.keymap.set("n", lhs, rhs, { buffer = buf_id, desc = desc })
end

local map_tabedit = function(buf_id, lhs)
    local rhs = function()
        -- If selected line is a file, close mini.files and open in a new tab
        local fs_entry = MiniFiles.get_fs_entry()
        if fs_entry.fs_type ~= "file" then return end
        MiniFiles.close()
        vim.cmd("tabedit " .. fs_entry.path)
    end

    -- Add desc to show in mini.files help
    local desc = "Edit in new tab"
    vim.keymap.set("n", lhs, rhs, { buffer = buf_id, desc = desc })
end

vim.api.nvim_create_autocmd("User", {
    pattern = "MiniFilesBufferCreate",
    callback = function(args)
        local buf_id = args.data.buf_id
        map_split(buf_id, "<C-h>", "belowright horizontal")
        map_split(buf_id, "<C-v>", "belowright vertical")
        map_tabedit(buf_id, "<C-t>")
    end,
})
