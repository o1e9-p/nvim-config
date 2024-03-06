vim.g.translator_target_lang = "ru"
vim.g.translator_source_lang = "en"
vim.g.translator_window_type = "popup"


-- Keymap
vim.api.nvim_set_keymap('n', '<leader>tr', '<Plug>Translate', {})
vim.api.nvim_set_keymap('v', '<leader>tr', '<Plug>Translate', {})
vim.api.nvim_set_keymap('n', '<leader>trw', '<Plug>TranslateW', {})
vim.api.nvim_set_keymap('v', '<leader>trw', '<Plug>TranslateW', {})
