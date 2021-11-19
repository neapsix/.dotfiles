local wezterm = require 'wezterm';
return {
    -- font = wezterm.font("Victor Mono", {weight="Medium"}),
    font = wezterm.font("Fira Code"),

    -- font_size = 12.0,
    line_height = 1.1,

    color_scheme = "nord",
    -- enable_scroll_bar = true,

    -- set to false to disable the tab bar completely
    -- enable_tab_bar = true,

    -- set to true to hide the tab bar when there is only
    -- a single tab in the window
    hide_tab_bar_if_only_one_tab = true,

    window_padding = {
        left = 5,
        right = 5,
        top = 2,
        bottom = 2,
    },

    colors = {
        selection_bg = "#424C5d",
        selection_fg = "#d8dee8",

        tab_bar = {
            -- The color of the strip that goes along the top of the window
            background = "#2e3440",

            -- The active tab is the one that has focus in the window
            active_tab = {
                -- The color of the background area for the tab
                bg_color = "#eceff4",
                -- The color of the text for the tab
                fg_color = "#4c566a",

                -- Specify whether you want "Half", "Normal" or "Bold" intensity for the
                -- label shown for this tab.
                -- The default is "Normal"
                -- intensity = "Normal",

                -- Specify whether you want "None", "Single" or "Double" underline for
                -- label shown for this tab.
                -- The default is "None"
                -- underline = "None",

                -- Specify whether you want the text to be italic (true) or not (false)
                -- for this tab.  The default is false.
                -- italic = false,

                -- Specify whether you want the text to be rendered with strikethrough (true)
                -- or not for this tab.  The default is false.
                -- strikethrough = false,
            },

            -- Inactive tabs are the tabs that do not have focus
            inactive_tab = {
                bg_color = "#2e3440",
                fg_color = "#d8dee9",

                -- The same options that were listed under the `active_tab` section above
                -- can also be used for `inactive_tab`.
            },

            -- You can configure some alternate styling when the mouse pointer
            -- moves over inactive tabs
            inactive_tab_hover = {
                bg_color = "#424C5D",
                fg_color = "#d8dee9",
                italic = false,

                -- The same options that were listed under the `active_tab` section above
                -- can also be used for `inactive_tab_hover`.
            },

            -- The new tab button that let you create new tabs
            new_tab = {
                bg_color = "#2e3440",
                fg_color = "#d8dee9",

                -- The same options that were listed under the `active_tab` section above
                -- can also be used for `new_tab`.
            },

            -- You can configure some alternate styling when the mouse pointer
            -- moves over the new tab button
            new_tab_hover = {
                bg_color = "#424C5D",
                fg_color = "#d8dee9",
                italic = false,

                -- The same options that were listed under the `active_tab` section above
                -- can also be used for `new_tab_hover`.
            }
        }
    }
}
