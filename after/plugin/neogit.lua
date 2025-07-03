local neogit = require('neogit')

neogit.setup {
  -- автоматически обновлять статус при возврате в буфер
  auto_refresh = true,
  -- не спрашивать подтверждение при коммите
  disable_commit_confirmation = true,
  -- интеграция с diffview (нужно установить diffview.nvim)
  integrations = { diffview = true },
  -- открывать Neogit не в табе, а в split’е
  kind = 'split',
}

-- Маппинги
local map = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

-- открыть статус-буфер Neogit
map('n', '<leader>gs', ':Neogit<CR>', opts)
-- сразу открыть окно коммита
map('n', '<leader>gc', ':Neogit commit<CR>', opts)
-- открыть обзор конфликтов (через diffview)
map('n', '<leader>gd', ':DiffviewOpen<CR>', opts)

-- сразу индексировать все изменения
map('n', '<leader>ga', ':Neogit stage_modifications<CR>', { noremap = true, silent = true })

-- пушить в удалёнку
map('n', '<leader>gp', ':Neogit push<CR>', opts)


