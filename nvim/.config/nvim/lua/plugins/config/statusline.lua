local M = {}

-- stylua: ignore start
M.modes = {
    ["c"]   = { long = "Command",  short = "C"  },
    ["i"]   = { long = "Insert",   short = "I"  },
    ["n"]   = { long = "Normal",   short = "N"  },
    ["r"]   = { long = "Prompt",   short = "P"  },
    ["R"]   = { long = "Replace",  short = "R"  },
    ["s"]   = { long = "Select",   short = "S"  },
    ["S"]   = { long = "S-Line",   short = "S_" },
    ["\19"] = { long = "S-Block",  short = "^S" },
    ["t"]   = { long = "Terminal", short = "T"  },
    ["v"]   = { long = "Visual",   short = "V"  },
    ["V"]   = { long = "V-Line",   short = "V_" },
    ["\22"] = { long = "V-Block",  short = "^V" },
    ["!"]   = { long = "Shell",    short = "Sh" },
}

M.mode_hl = {
    ["c"]   = "%#MiniStatuslineModeCommand#",
    ["i"]   = "%#MiniStatuslineModeInsert#",
    ["n"]   = "%#MiniStatuslineModeNormal#",
    ["r"]   = "%#MiniStatuslineModeReplace#",
    ["R"]   = "%#MiniStatuslineModeReplace#",
    ["s"]   = "%#MiniStatuslineModeOther#",
    ["S"]   = "%#MiniStatuslineModeOther#",
    ["\19"] = "%#MiniStatuslineModeOther#",
    ["t"]   = "%#MiniStatuslineModeCommand#",
    ["v"]   = "%#MiniStatuslineModeVisual#",
    ["V"]   = "%#MiniStatuslineModeVisual#",
    ["\22"] = "%#MiniStatuslineModeVisual#",
    ["!"]   = "%#MiniStatuslineModeNormal#",
}
-- stylua: ignore end

M.setup = function()
    _G.StatusLine = M

    M.create_hl_groups()
    M.create_autocmds()
end

-- Helper functions for components
M.is_short = function() return vim.api.nvim_win_get_width(0) < 72 end

-- Components
M.mode = function()
    local m = M.modes[vim.fn.mode()]
    return M.is_short() and m.short or m.long
end

M.mode_color = function() return M.mode_hl[vim.fn.mode()] end

M.diff = function()
    if M.is_short() then return "" end

    -- Diff statistics to show in summary.
    -- stylua: ignore start
    local stats = {
        { name = "add",    sign = "+", hl = "%#StatusLineDiffAdd#"    },
        { name = "delete", sign = "-", hl = "%#StatusLineDiffDelete#" },
        { name = "change", sign = "~", hl = "%#StatusLineDiffChange#" },
    }
    -- stylua: ignore end

    local diff = vim.b.minidiff_summary
    if not diff then return "" end

    local d = {}
    for _, stat in ipairs(stats) do
        -- Example: n = vim.b.minidiff_summary.add
        local n = diff[stat.name]
        if n and n > 0 then
            local s = table.concat({ stat.hl, stat.sign, n })
            table.insert(d, s)
        end
    end

    if #d < 1 then return "" end
    return string.format("%s%s", table.concat(d, " "), "%#MiniStatuslineDevinfo#")
end

M.fenc = function()
    if M.is_short() then return "" end
    local enc = (vim.bo.fenc ~= "" and vim.bo.fenc) or vim.o.enc
    return enc ~= "utf-8" and enc or ""
end

M.fmt = function()
    if M.is_short() then return "" end
    local fmt = vim.bo.fileformat
    return fmt ~= "unix" and fmt or ""
end

M.git = function()
    local s = vim.b.minigit_summary_string
    return s or ""
end

-- Treating these as a unit so that we can check whether git() and diff() are
-- both empty and not insert the Devinfo highlight group in that case.
M.git_block = function()
    local components = vim.tbl_filter(function(x) return x ~= "" end, {
        "%#MiniStatuslineDevinfo#",
        M.git(),
        M.diff(),
    })
    -- Return blank if there's only one item after the filter (the hl group).
    -- Avoids an empty block (the hl group + space) when git and diff are blank.
    return #components > 1 and table.concat(components, " ") or ""
end

M.lsp_active = function()
    local clients = vim.lsp.get_clients({ bufnr = 0 })
    if #clients < 1 then return "" end

    local names = {}
    for _, server in pairs(clients) do
        table.insert(names, server.name)
    end

    return M.is_short() and "L" or string.format("[%s]", table.concat(names, " "))
end

M.lsp_diagnostics = function()
    -- Diagnostic levels to show in summary.
    -- stylua: ignore start
    local levels = {
        { name = "ERROR", sign = "E", hl = "%#DiagnosticError#" },
        { name = "WARN",  sign = "W", hl = "%#DiagnosticWarn#"  },
        { name = "INFO",  sign = "I", hl = "%#DiagnosticHint#"  },
        { name = "HINT",  sign = "H", hl = "%#DiagnosticInfo#"  },
    }
    -- stylua: ignore end

    local severity = vim.diagnostic.severity

    -- Note: Much more efficient than vim.diagnostic.get() four times.
    local count = vim.diagnostic.count(0)

    local d = {}
    for _, level in ipairs(levels) do
        -- Example: n = count[vim.diagnostic.severity.ERROR]
        local n = count[severity[level.name]]
        if n and n > 0 then
            local s = table.concat({ level.hl, level.sign, n })
            table.insert(d, s)
        end
    end

    if #d < 1 then return "" end
    return string.format("![%s%s]", table.concat(d, " "), "%#MiniStatuslineFilename#")
end

M.lsp_progress = function()
    local progress = require("lsp-progress").progress()
    return progress or ""
end

M.name = function() return M.is_short() and "%t" or "%f" end

-- Statusline layouts
M.active = function()
    -- Filter the statusline layout to remove empty ("") or nil components.
    local components = vim.tbl_filter(function(x) return x ~= "" end, {
        M.mode_color(),
        M.mode(),
        M.git_block(),
        "%#MiniStatuslineFilename#",
        M.name(),
        "%m%r%h%w",
        "%<",
        "%=",
        M.lsp_progress(),
        M.lsp_diagnostics(),
        M.lsp_active(),
        "%#MiniStatuslineFileinfo#",
        "%Y",
        M.fmt(),
        M.fenc(),
        "%P %7(%l/%3L%):%2c ",
    })

    return table.concat(components, " ")
end

M.inactive = function()
    return table.concat({
        "%Y",
        "%t",
    }, " ")
end

-- Functions to finish setting up the statusline
-- Run during setup and again by an autocommand when the colorscheme changes.
M.create_hl_groups = function()
    -- The diff summary appears in a block with a lighter background, but the
    -- MiniDiffSign* highlight groups clear the background color. Define new
    -- groups with the diff sign foreground colors and that block's background.
    local bg_group = "MiniStatuslineDevinfo"
    M.merge_hl_groups(bg_group, "MiniDiffSignAdd", "StatusLineDiffAdd")
    M.merge_hl_groups(bg_group, "MiniDiffSignDelete", "StatusLineDiffDelete")
    M.merge_hl_groups(bg_group, "MiniDiffSignChange", "StatusLineDiffChange")
end

-- Creates a new highlight group with the background color from one specified
-- highlight group and the foreground color from another.
M.merge_hl_groups = function(bg_group, fg_group, new_group)
    local get_hl = function(name) return vim.api.nvim_get_hl(0, { name = name }) end

    local bg_hl, fg_hl = get_hl(bg_group), get_hl(fg_group)

    vim.api.nvim_set_hl(0, new_group, { fg = fg_hl.fg, bg = bg_hl.bg })
end

M.create_autocmds = function()
    local group = vim.api.nvim_create_augroup("Statusline", {})

    vim.api.nvim_create_autocmd({ "WinEnter", "BufEnter" }, {
        group = group,
        pattern = "*",
        callback = M.set_statusline,
        desc = "Set statusline for all windows.",
    })

    vim.api.nvim_create_autocmd({ "User" }, {
        group = group,
        pattern = "LspProgressStatusUpdated, LspAttach, LspDetach",
        callback = vim.schedule_wrap(function() vim.cmd("redrawstatus") end),
        desc = "Redraw statusline to refresh attached LSPs and LSP progress.",
    })

    vim.api.nvim_create_autocmd({ "ColorScheme" }, {
        group = group,
        pattern = "*",
        callback = M.create_hl_groups,
        desc = "Recreate statusline highlight groups on colorscheme change.",
    })
end

-- Slight tweak of ensure_content function from mini.statusline v0.14.0.
M.set_statusline = vim.schedule_wrap(function()
    local cur_win_id = vim.api.nvim_get_current_win()
    local is_global_stl = vim.o.laststatus == 3

    for _, win_id in ipairs(vim.api.nvim_list_wins()) do
        if win_id == cur_win_id or is_global_stl then
            vim.wo[win_id].statusline = "%{%v:lua.StatusLine.active()%}"
        else
            vim.wo[win_id].statusline = "%{%v:lua.StatusLine.inactive()%}"
        end
    end
end)

return M
