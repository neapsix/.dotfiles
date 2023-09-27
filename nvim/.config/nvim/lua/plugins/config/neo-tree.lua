--
-- plugins/config/neo-tree.lua - config for neo-tree plugin
--

require('neo-tree').setup {
    window = {
        width = 32,
    }
}

vim.keymap.set('n', '<leader>F', ':Neotree<CR>', { silent = true })

