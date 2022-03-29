local wezterm = require 'wezterm';

-- rose-pine

local active_tab = {
    bg_color = "#26233a", -- overlay
    fg_color = "#e0def4", -- text
}

local inactive_tab = {
    bg_color = "#191724", -- base
    fg_color = "#6e6a86", -- muted
}

local colors = {
    tab_bar = {
        background = "#191724", -- base
        active_tab = active_tab,
        inactive_tab = inactive_tab,
        inactive_tab_hover = active_tab,
        new_tab = inactive_tab,
        new_tab_hover = active_tab,

        -- (Fancy tab bar only)
        inactive_tab_edge = "#6e6a86", -- muted
    }
}

-- (Fancy tab bar only)
local window_frame = {
    active_titlebar_bg = "#191724", -- base
    inactive_titlebar_bg = "#191724", -- base
}

-- WezTerm config

return {
    hide_tab_bar_if_only_one_tab = true,
    use_fancy_tab_bar = false,
    -- enable_scroll_bar = true,
    
    line_height = 1.1,

    -- font = wezterm.font("Victor Mono", {weight="Medium"}),
    -- font = wezterm.font("Fira Code"),
   
    font_size = 13,

    color_scheme = "rose-pine",
    -- color_scheme = "nord",
    -- TODO: duplicate the nord color scheme and make these changes:
    -- selection_bg = "#424C5d",
    -- selection_fg = "#d8dee8",
    
    -- Note: right-side padding is also the width of the scroll bar
    window_padding = {
        left = 5,
        right = 5,
        top = 2,
        bottom = 2,
    },

    colors = colors,

    window_frame = window_frame,
    
    -- nord
    --[[ colors = {
        tab_bar = {
            -- Color of the tab strip along the top of the window
            background = "#2e3440",

            -- Colors for the active tab 
            active_tab = {
                -- The color of the background area for the tab
                bg_color = "#eceff4",
                -- The color of the text for the tab
                fg_color = "#4c566a",
            },

            -- Colors for inactive tabs 
            inactive_tab = {
                bg_color = "#2e3440",
                fg_color = "#d8dee9",
            },

            -- Hover color for inactive tabs
            inactive_tab_hover = {
                bg_color = "#424C5D",
                fg_color = "#d8dee9",
                italic = false,
            },

            -- Colors for the new tab button (same as inactive tabs)
            new_tab = {
                bg_color = "#2e3440",
                fg_color = "#d8dee9",
            },

            --Hover colors for the new tab button (same as inactive tabs)
            new_tab_hover = {
                bg_color = "#424C5D",
                fg_color = "#d8dee9",
                italic = false,
            }
        }
    } ]]
}


