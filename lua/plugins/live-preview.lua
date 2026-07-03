return {
    'brianhuster/live-preview.nvim',
    dependencies = {
        'nvim-telescope/telescope.nvim',
    },
    config = function()
        require('livepreview.config').set({
            port = 5500,
            dynamic_root = false,
            sync_scroll = true,
        })
        vim.keymap.set('n', '<leader>lp', '<cmd>LivePreview start<CR>', { desc = 'Live Preview start' })
        vim.keymap.set('n', '<leader>lpc', '<cmd>LivePreview close<CR>', { desc = 'Live Preview close' })
        vim.keymap.set('n', '<leader>lpf', '<cmd>LivePreview pick<CR>', { desc = 'Live Preview pick file' })
    end,
}
