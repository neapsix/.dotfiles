-- WezTerm config

local wezterm = require('wezterm')
local theme = wezterm.plugin.require('https://github.com/neapsix/wezterm').main

return {
    check_for_updates = false,
    audible_bell = 'Disabled',
    hide_tab_bar_if_only_one_tab = true,
    use_fancy_tab_bar = false,
    -- enable_scroll_bar = true,
    -- line_height = 1.1,
    -- dpi = 144,
    -- font = require("wezterm").font("Victor Mono", {weight="Medium"}),
    -- font = require("wezterm").font("Fira Code"),
    -- font = require("wezterm").font("Monaspace Neon"),
    font = require("wezterm").font("IBM Plex Mono"),
    font_size = 14.5,
    -- freetype_load_target = "Light",
    -- color_scheme = 'rose-pine',
    window_padding = {
        left = 5,
        right = 5, -- also the width of the scroll bar
        top = 2,
        bottom = 2,
    },
    colors = theme.colors(),
    window_frame = theme.window_frame(),
    -- keys = {
    --     {key="L", mods="CTRL", action="ShowDebugOverlay"},
    --     {key="R", mods="CTRL", action="ReloadConfiguration"}
    -- }
}
