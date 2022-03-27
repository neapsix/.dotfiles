--
-- plugins/configs/lualine.lua - config for lualine.nvim plugin
--

require('lualine').setup {
  options = {
    icons_enabled = false,
    theme = 'rose-pine';
    component_separators = { left = '|', right = '|'},
    section_separators = { left = '', right = ''},
  },
}
