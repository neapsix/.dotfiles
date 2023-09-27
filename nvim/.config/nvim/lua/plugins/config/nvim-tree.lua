--
-- plugins/config/nvim-tree.lua - config for nvim-tree plugin
--

require('nvim-tree').setup {}

vim.keymap.set('n', '<leader>F', ':NvimTreeToggle<CR>', { silent = true })


