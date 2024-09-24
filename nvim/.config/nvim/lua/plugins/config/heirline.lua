local conditions = require("heirline.conditions")
local utils = require("heirline.utils")

local Space = { provider = " " }

local ViMode = {
    init = function(self)
        self.mode = vim.fn.mode(1) -- :h mode()
    end,
    -- Map the output of mode() to a display name string and highlight
    -- group. Put in `static` to compute once at initialization time.
    static = {
        mode_names = {
            n = "N",
            no = "N?",
            nov = "N?",
            noV = "N?",
            ["no\22"] = "N?",
            niI = "Ni",
            niR = "Nr",
            niV = "Nv",
            nt = "Nt",
            v = "V",
            vs = "Vs",
            V = "V_",
            Vs = "Vs",
            ["\22"] = "^V",
            ["\22s"] = "^V",
            s = "S",
            S = "S_",
            ["\19"] = "^S",
            i = "I",
            ic = "Ic",
            ix = "Ix",
            R = "R",
            Rc = "Rc",
            Rx = "Rx",
            Rv = "Rv",
            Rvc = "Rv",
            Rvx = "Rv",
            c = "C",
            cv = "Ex",
            r = "...",
            rm = "M",
            ["r?"] = "?",
            ["!"] = "!",
            t = "T",
        },
        mode_hl = {
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
            t = "MiniStatuslineModeNormal",
        },
    },

    {
        provider = "",
        hl = function(self)
            local mode = self.mode:sub(1, 1) -- First character of mode
            return { fg = utils.get_highlight(self.mode_hl[mode]).bg }
        end,
    },
    -- Note: Access static fields as attributes after initialization.
    {
        provider = function(self)
            return " " .. self.mode_names[self.mode] .. " "
        end,
        hl = function(self)
            local mode = self.mode:sub(1, 1) -- First character of mode
            return self.mode_hl[mode]
        end,
    },
    {
        provider = "",
        hl = function(self)
            local mode = self.mode:sub(1, 1) -- First character of mode
            return { fg = utils.get_highlight(self.mode_hl[mode]).bg }
        end,
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

-- Define children separately to add later.
local FileIcon = {
    init = function(self)
        local filename = self.filename
        -- local extension = vim.fn.fnamemodify(filename, ":e")
        self.icon, self.hl, self.is_default = MiniIcons.get("file", filename)
    end,
    provider = function(self)
        return self.icon and (" " .. self.icon .. " ")
    end,
}

local FileName = {
    provider = function(self)
        -- %f = file path relative to working directory or [No Name]
        local f = vim.api.nvim_eval_statusline("%f", {})

        -- If the filename would occupy more than 1/4 of the width,
        -- trim the file path to initials.
        if not conditions.width_percent_below(f.width, 0.25) then
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

    -- %#String# = gold
    -- %#Special# = foam
    -- %#NonText# = gray
    -- %#Function# = rose
    -- %#Macro# = iris

    -- provider = " %#String#%m%#Special#%r%#Macro#%w"
    Space,
    {
        provider = "%m",
        hl = "String",
    },
    {
        provider = "%r",
        hl = "Special",
    },
    {
        provider = "%w",
        hl = "Macro",
    },
}

-- Change filename color if the buffer is modified. Use this "modifier"
-- component to alter the existing filename component.
local FileNameModifer = {
    hl = function()
        if vim.bo.modified then
            -- Use `force` to override the child's hl foreground.
            return "Title"
        end
    end,
}

-- Add children to the FileNameBlock component
FileNameBlock = utils.insert(FileNameBlock,
    FileIcon,
    -- Make FileName a child of FileNameModifier.
    utils.insert(FileNameModifer, FileName),
    FileFlags,
    -- Cut here when there's not enough space.
    { provider = '%<' }
)

local DevInfoBlock = {
    hl = "MiniStatuslineDevinfo",
}

local MiniGitSummary = {
    -- condition = function()
    --     return vim.b.minigit_summary_string ~= nil
    -- end,

    -- Space,
    {
        init = function(self)
            self.minigit_summary_string = vim.b.minigit_summary_string
            -- self.minigit_summary = vim.b.minigit_summary
        end,

        provider = function(self)
            -- return " " .. self.minigit_summary.head_name
            return self.minigit_summary_string ~= nil and
                "  " .. self.minigit_summary_string .. " "
        end,
        update = {
            "User",
            pattern = { "MiniGitUpdated" },
        },
    },
}

local MiniDiffSummary = {
    condition = function()
        -- TODO: This doesn't seem to reliably stop from running on untracked files.
        return vim.b.minidiff_summary_string ~= nil
            -- Also don't show if a reasonable-length summary (12 chars) would
            -- be 25% or more of the window's width
            and conditions.width_percent_below(12, 0.25)
    end,

    init = function(self)
        self.minidiff_summary = vim.b.minidiff_summary
    end,
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
        -- error_icon = vim.fn.sign_getdefined("DiagnosticSignError")[1].text,
        -- warn_icon = vim.fn.sign_getdefined("DiagnosticSignWarn")[1].text,
        -- info_icon = vim.fn.sign_getdefined("DiagnosticSignInfo")[1].text,
        -- hint_icon = vim.fn.sign_getdefined("DiagnosticSignHint")[1].text,
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

local DAPMessages = {
    condition = function()
        local session = require("dap").session()
        return session ~= nil
    end,
    provider = function()
        return "  " .. require("dap").status()
    end,
    hl = "Debug"
}

local FileInfoBlock = {
    hl = "MiniStatuslineFileinfo",
}

local FileType = {
    provider = function()
        return string.upper(vim.bo.filetype)
    end,
}

local FileEncoding = {
    provider = function()
        local enc = (vim.bo.fenc ~= '' and vim.bo.fenc) or vim.o.enc
        return enc ~= 'utf-8' and enc:upper()
    end
}

local FileFormat = {
    provider = function()
        local fmt = vim.bo.fileformat
        return fmt ~= 'unix' and fmt:upper()
    end
}

local Ruler = {
    -- %l = current line number
    -- %L = number of lines in the buffer
    -- %c = column number
    -- %P = percentage through file of displayed window
    provider = "%P %7(%l/%3L%):%2c",
}

FileInfoBlock = utils.insert(FileInfoBlock,
    Space,
    FileType,
    Space,
    -- TODO: Remove spaces after FileEncoding and FileFormat if not visible?
    FileEncoding,
    Space,
    FileFormat,
    Space,
    Ruler,
    Space
)

local TerminalName = {
    -- We could add a condition to check that buftype == 'terminal'
    -- or we could do that later.
    provider = function()
        local tname, _ = vim.api.nvim_buf_get_name(0):gsub(".*:", "")
        return " " .. tname
    end,
    hl = "Function",
}

local HelpFileName = {
    -- %t = File name (tail) of file in the buffer
    -- Note: no need to check that the filetype is help, because we only
    -- use this component in the Help statusline.
    provider = "%t",
    hl = "Function",
}

-- local Snippets = {
--     -- check that we are in insert or select mode
--     condition = function()
--         return vim.tbl_contains({'s', 'i'}, vim.fn.mode())
--     end,
--     provider = function()
--         local luasnip = require "luasnip"
--         -- Note: forward box appears even if you're on the last item. :(
--         local forward =  luasnip.locally_jumpable(1) and "" or ""
--         local backward = luasnip.locally_jumpable(-1) and " " or ""
--         return backward .. forward
--     end,
--     hl = "DiagnosticError",
-- }

local Align = { provider = "%=" }

local DefaultStatusline = {
    hl = "MiniStatuslineFilename",
    DevInfoBlock,
    FileNameBlock,
    Align,
    DAPMessages,
    Align,
    LSPInfoBlock,
    Space,
    FileInfoBlock,
}

local InactiveStatusline = {
    condition = conditions.is_not_active,
    hl = "MiniStatuslineInactive",
    FileType,
    Space,
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
    hl = "MiniStatuslineFilename",
    FileType,
    Space,
    HelpFileName,
    Align
}

local TerminalStatusline = {
    condition = function()
        return conditions.buffer_matches({ buftype = { "terminal" } })
    end,

    hl = "DiffDelete",

    -- Add a condition to ViMode to show it only when buffer is active.
    { condition = conditions.is_active, ViMode, Space },
    FileType,
    Space,
    TerminalName,
    Align,
}

local StatusLines = {
    hl = function()
        if conditions.is_active() then
            return "StatusLine"
        else
            return "StatusLineNC"
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
