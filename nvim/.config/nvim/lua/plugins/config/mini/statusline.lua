-- Lightly modified version of default settings
local function active()
    local mode, mode_hl = MiniStatusline.section_mode({ trunc_width = 120 })
    local git           = MiniStatusline.section_git({ trunc_width = 70 })
    local diff          = MiniStatusline.section_diff({ trunc_width = 70 })
    local diagnostics   = MiniStatusline.section_diagnostics({ trunc_width = 70 })
    local lsp           = MiniStatusline.section_lsp({ trunc_width = 70 })
    local filename      = MiniStatusline.section_filename({ trunc_width = 140 })
    local fileinfo      = MiniStatusline.section_fileinfo({ trunc_width = 70 })
    local location      = MiniStatusline.section_location({ trunc_width = 70 })
    local search        = MiniStatusline.section_searchcount({ trunc_width = 70 })
    -- local percent       = vim.api.nvim_eval_statusline("%p", {}).str .. "%%"
    -- local ruler         = vim.api.nvim_eval_statusline("%l", {}).str .. ":" .. vim.api.nvim_eval_statusline("%c", {})
    -- .str

    return MiniStatusline.combine_groups({
        { hl = mode_hl,                 strings = { mode } },
        { hl = 'MiniStatuslineDevinfo', strings = { git, diff, diagnostics, lsp } },
        '%<', -- Mark general truncate point
        { hl = 'MiniStatuslineFilename', strings = { filename } },
        '%=', -- End left alignment
        { hl = 'MiniStatuslineFileinfo', strings = { fileinfo } },
        { hl = mode_hl,                  strings = { search, location } },
    })
end

require("mini.statusline").setup {
    content = {
        active = active,
    },
    -- use_icons = false,
}
