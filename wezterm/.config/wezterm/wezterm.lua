-- local wezterm = require 'wezterm';

local colors = require 'lua/rose-pine'.colors()
local window_frame = require 'lua/rose-pine'.window_frame()

-- WezTerm config

return {
    hide_tab_bar_if_only_one_tab = true,
    use_fancy_tab_bar = false,
    -- enable_scroll_bar = true,
    line_height = 1.1,
    -- font = wezterm.font("Victor Mono", {weight="Medium"}),
    -- font = wezterm.font("Fira Code"),
    font_size = 13,
    color_scheme = 'rose-pine',
    window_padding = {
        left = 5,
        right = 5, -- also the width of the scroll bar
        top = 2,
        bottom = 2,
    },
    colors = colors,
    window_frame = window_frame,
    --[[ keys = {
        {key="L", mods="CTRL", action="ShowDebugOverlay"},
        {key="R", mods="CTRL", action="ReloadConfiguration"}
    } ]]
}
