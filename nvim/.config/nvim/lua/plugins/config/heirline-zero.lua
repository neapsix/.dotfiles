local conditions = require("heirline.conditions")
local utils = require("heirline.utils")

local Space = { provider = " " }
local Sep = { provider = "|" }

local ViMode = {
    init = function(self)
        self.mode = vim.fn.mode() -- :h mode()
    end,

    -- Note: using only first character of mode names in this theme.
    static = {
        mode_names = {
            n = "NORMAL",
            v = "VISUAL",
            V = "V-LINE",
            ["\22"] = "V-BLOCK",
            s = "SELECT",
            S = "S-LINE",
            ["\19"] = "S-BLOCK",
            i = "INSERT",
            R = "REPLACE",
            c = "COMMAND",
            r = "...",
            ["r?"] = "?",
            ["!"] = "!",
            t = "TERMINAL",
        },
    },

    -- Note: Access static fields as attributes after initialization.
    {
        provider = function(self)
            return " " .. self.mode_names[self.mode] .. " "
        end,
        hl = function(self) return self:mode_hl() end,
    },

    -- Re-evaluate component on ModeChanged event. Also re-evaluates the
    -- statusline when entering operator-pending mode.
    update = {
        "ModeChanged",
        pattern = "*:*",
        callback = vim.schedule_wrap(function()
            vim.cmd("redrawstatus")
        end),
    },
}

local FileNameBlock = {
    -- Set up attributes for this component and its children.
    init = function(self)
        self.filename = vim.api.nvim_buf_get_name(0)
    end,
}

local FileName = {
    provider = function(self)
        -- %f = file path relative to working directory or [No Name]
        local f = vim.api.nvim_eval_statusline("%f", {})

        -- If the filename would occupy more than 1/5 of the width,
        -- trim the file path to initials.
        if not conditions.width_percent_below(f.width, 0.20) then
            return vim.fn.pathshorten(f.str)
        else
            return f.str
        end
    end,
}

local FileFlags = {
    -- %m = [+] for modified or [-] for not modifiable
    -- %r = [RO] for read-only
    -- %h = [Help] in help files
    -- %w = [Preview] in preview window (when previewing a tag)
    provider = " %m%r%w",
}

-- Add children to the FileNameBlock component
FileNameBlock = utils.insert(FileNameBlock,
    Space,
    FileName,
    FileFlags,
    -- Cut here when there's not enough space.
    { provider = '%<' }
)

local DevInfoBlock = {
    hl = function(self) return self:mode_hl_inverted_overlay() end
}

local MiniGitSummary = {
    {
        init = function(self)
            self.minigit_summary_string = vim.b.minigit_summary_string
        end,

        provider = function(self)
            return self.minigit_summary_string ~= nil and
                " " .. self.minigit_summary_string .. " "
        end,
        -- Use default update interval because this text is mode-colored
    },
}

local MiniDiffSummary = {
    condition = function()
        -- TODO: This doesn't seem to reliably stop from running on untracked files.
        return vim.b.minidiff_summary_string ~= nil
            and vim.b.minidiff_summary_string ~= ""
            -- Also don't show if a reasonable-length summary (12 chars) would
            -- be 25% or more of the window's width
            and conditions.width_percent_below(12, 0.25)
    end,

    init = function(self)
        self.minidiff_summary = vim.b.minidiff_summary
    end,

    -- This uses the default update interval because it's mode-colored.
    {
        provider = "| "
    },
    -- These are within a block to use a different update event.
    {
        {
            provider = function(self)
                if self.minidiff_summary.add == nil then return "" end
                if self.minidiff_summary.add > 0 then
                    return "+" .. self.minidiff_summary.add .. " "
                end
                return ""
            end,
            hl = "MiniDiffSignAdd",
        },
        {
            provider = function(self)
                if self.minidiff_summary.delete == nil then return "" end
                if self.minidiff_summary.delete > 0 then
                    return "-" .. self.minidiff_summary.delete .. " "
                end
                return ""
            end,
            hl = "MiniDiffSignDelete",
        },
        {
            provider = function(self)
                if self.minidiff_summary.change == nil then return "" end
                if self.minidiff_summary.change > 0 then
                    return "~" .. self.minidiff_summary.change .. " "
                end
                return ""
            end,
            hl = "MiniDiffSignChange",
        },
        update = {
            "User",
            pattern = { "MiniDiffUpdated" },
        },
    },
}

DevInfoBlock = utils.insert(DevInfoBlock,
    ViMode,
    MiniGitSummary,
    MiniDiffSummary
)

local LSPInfoBlock = {}

local LSPProgress = {
    condition = conditions.lsp_attached,
    init = function(self)
        self.progress = require("lsp-progress").progress()
    end,
    {
        provider = function(self) return self.progress end,
    },
    Space,
    update = {
        "User",
        pattern = { "LspProgressStatusUpdated" },
        callback = vim.schedule_wrap(function()
            vim.cmd("redrawstatus")
        end),
    },
}

local Diagnostics = {
    condition = conditions.has_diagnostics,

    static = {
        error_icon = "E",
        warn_icon = "W",
        info_icon = "I",
        hint_icon = "H",
    },

    init = function(self)
        self.errors = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.ERROR })
        self.warnings = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.WARN })
        self.hints = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.HINT })
        self.info = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.INFO })
    end,

    update = { "DiagnosticChanged", "BufEnter" },

    {
        provider = "![",
    },
    {
        provider = function(self)
            -- 0 is just another output, we can decide to print it or not!
            return self.errors > 0 and (self.error_icon .. self.errors .. " ")
        end,
        hl = "DiagnosticError"
    },
    {
        provider = function(self)
            return self.warnings > 0 and (self.warn_icon .. self.warnings .. " ")
        end,
        hl = "DiagnosticWarn"
    },
    {
        provider = function(self)
            return self.info > 0 and (self.info_icon .. self.info .. " ")
        end,
        hl = "DiagnosticInfo"
    },
    {
        provider = function(self)
            return self.hints > 0 and (self.hint_icon .. self.hints)
        end,
        hl = "DiagnosticHint"
    },
    {
        provider = "]",
    },
    Space,
}

local LSPActive = {
    condition = conditions.lsp_attached,
    update = { 'LspAttach', 'LspDetach' },

    provider = function()
        local names = {}
        for _, server in pairs(vim.lsp.get_clients({ bufnr = 0 })) do
            table.insert(names, server.name)
        end
        return "[" .. table.concat(names, " ") .. "]"
    end,
}

LSPInfoBlock = utils.insert(LSPInfoBlock,
    LSPProgress,
    Diagnostics,
    LSPActive
)

local FileInfoBlock = {}

local FileEncoding = {
    provider = function()
        local enc = (vim.bo.fenc ~= '' and vim.bo.fenc) or vim.o.enc
        return enc ~= "utf-8" and (enc .. " | ")
    end
}

local FileFormat = {
    provider = function()
        local fmt = vim.bo.fileformat
        return fmt ~= "unix" and (fmt .. " | ")
    end
}

local FileType = {
    provider = function()
        if vim.bo.filetype ~= "" then
            return vim.bo.filetype .. " "
        end
    end,
}

FileInfoBlock = utils.insert(FileInfoBlock,
    FileEncoding,
    FileFormat,
    FileType
)

local Percent = {
    provider = " %3(%P%) ",
    hl = function(self) return self:mode_hl_inverted_overlay() end,
}

local Ruler = {
    -- %l = current line number
    -- %L = number of lines in the buffer
    -- %c = column number
    -- %P = percentage through file of displayed window
    -- provider = " %7(%l/%3L%):%2c ",
    provider = " %l:%c ",
    hl = function(self) return self:mode_hl() end,
}

local TerminalName = {
    -- We could add a condition to check that buftype == 'terminal'
    -- or we could do that later.
    provider = function()
        local tname, _ = vim.api.nvim_buf_get_name(0):gsub(".*:", "")
        return tname
    end,
}

local HelpFileName = {
    -- %t = File name (tail) of file in the buffer
    -- Note: no need to check that the filetype is help, because we only
    -- use this component in the Help statusline.
    provider = "%t",
}

local Align = { provider = "%=" }

local DefaultStatusline = {
    DevInfoBlock,
    FileNameBlock,
    Align,
    LSPInfoBlock,
    Space,
    FileInfoBlock,
    Percent,
    Ruler
}

local InactiveStatusline = {
    condition = conditions.is_not_active,
    FileType,
    FileName,
    Align,
}

local SpecialStatusline = {
    condition = function()
        return conditions.buffer_matches({
            buftype = { "nofile", "prompt", "help", "quickfix" },
            filetype = { "^git.*", "fugitive" },
        })
    end,
    FileType,
    HelpFileName,
    Align
}

local TerminalStatusline = {
    condition = function()
        return conditions.buffer_matches({ buftype = { "terminal" } })
    end,

    -- Add a condition to ViMode to show it only when buffer is active.
    { condition = conditions.is_active, ViMode, Space },
    FileType,
    TerminalName,
    Align,
}

local StatusLines = {
    static = {
        mode_hl_map = {
            n = "MiniStatuslineModeNormal",
            i = "MiniStatusLineModeInsert",
            v = "MiniStatusLineModeVisual",
            V = "MiniStatusLineModeVisual",
            ["\22"] = "MiniStatusLineModeVisual",
            c = "MiniStatuslineModeCommand",
            s = "MiniStatusLineModeOther",
            S = "MiniStatusLineModeOther",
            ["\19"] = "MiniStatusLineModeOther",
            R = "MiniStatuslineModeReplace",
            r = "MiniStatuslineModeReplace",
            ["!"] = "MiniStatuslineModeNormal",
        },

        mode_hl = function(self)
            local mode = conditions.is_active() and vim.fn.mode() or "n"
            return self.mode_hl_map[mode]
        end,

        mode_hl_inverted = function(self)
            local h = utils.get_highlight(self:mode_hl())
            return { fg = h.bg, bg = h.fg }
        end,

        mode_hl_inverted_overlay = function(self)
            local mode_colors = utils.get_highlight(self:mode_hl())
            local block_colors = utils.get_highlight("MiniStatusLineDevinfo")
            return { fg = mode_colors.bg, bg = block_colors.bg }
        end,

    },

    hl = function()
        if conditions.is_active() then
            return "Normal"
        else
            return "NonText"
        end
    end,

    -- Uses first statusline with no condition or with true condition.
    fallthrough = false,

    SpecialStatusline,
    TerminalStatusline,
    InactiveStatusline,
    DefaultStatusline,
}

require("heirline").setup({ statusline = StatusLines })
