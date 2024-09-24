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
    -- font = require("wezterm").font("IBM Plex Mono"),
    -- font = require("wezterm").font("Iosevka Fixed"),
    font = wezterm.font_with_fallback {
        {
            family = "IosevkaTerm Nerd Font",
            harfbuzz_features = { "calt=0" },
        },
    },
    -- font_size = 14.5, -- for IBM Plex Mono
    font_size = 16, -- for IosevkaTerm Nerd Font
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
