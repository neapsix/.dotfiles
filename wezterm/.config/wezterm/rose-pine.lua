-- rose-pine

local M = {}

local rose_pine = {
    base = '#191724',
    overlay = '#26233a',
    muted = '#6e6a86',
    text = '#e0def4',
}

local active_tab = {
    bg_color = rose_pine.overlay,
    fg_color = rose_pine.text,
}

local inactive_tab = {
    bg_color = rose_pine.base,
    fg_color = rose_pine.muted,
}

function M.colors()
    return {
        tab_bar = {
            background = rose_pine.base,
            active_tab = active_tab,
            inactive_tab = inactive_tab,
            inactive_tab_hover = active_tab,
            new_tab = inactive_tab,
            new_tab_hover = active_tab,
            inactive_tab_edge = rose_pine.muted, -- (Fancy tab bar only)
        }
    }
end

function M.window_frame() -- (Fancy tab bar only)
    return {
        active_titlebar_bg = rose_pine.base,
        inactive_titlebar_bg = rose_pine.base,
    }
end

return M
