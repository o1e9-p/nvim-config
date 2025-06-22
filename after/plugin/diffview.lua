require('diffview').setup()
-- маппинг для открытия/закрытия diffview
vim.api.nvim_set_keymap('n', '<leader>do', ':DiffviewOpen<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>dc', ':DiffviewClose<CR>', { noremap = true, silent = true })

