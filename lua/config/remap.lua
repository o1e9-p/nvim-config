vim.keymap.set('n', '<leader>pv', ':Ex<CR>')

-- move highlighted text
vim.keymap.set('v', 'J', ":m '>+1<CR>gv=gv")
vim.keymap.set('v', 'K', ":m '>-2<CR>gv=gv")

-- copy and past a lot of times the identical value
vim.keymap.set('x', '<leader>p', "\"_dp")

-- simple replacing
vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

-- Системный буфер обмена shift - Y
vim.keymap.set('v', 'S-Y', '"+y', {})
-- Типа 'Нажимает' на ESC при быстром нажатии jj, чтобы не тянутся
vim.keymap.set('i', 'jj', '<Esc>')
-- Стрелочки откл. Использовать hjkl
vim.keymap.set('', '<up>', ':echoe "Use k"<CR>')
vim.keymap.set('', '<down>', ':echoe "Use j"<CR>')
vim.keymap.set('', '<left>', ':echoe "Use h"<CR>')
vim.keymap.set('', '<right>', ':echoe "Use l"<CR>')
-- Автоформат + сохранение по CTRL-s , как в нормальном, так и в insert режиме
vim.keymap.set('n', '<C-s>', '<CR>:w<CR>')
vim.keymap.set('i', '<C-s>', '<esc>:<CR>:w<CR>')
-- Закрыть окно на q
vim.keymap.set('n', 'q', ':q<CR>')
-- Переключение вкладок с помощью TAB или shift-tab (akinsho/bufferline.nvim)
vim.keymap.set('n', '<Tab>', ':BufferLineCycleNext<CR>')
vim.keymap.set('n', '<S-Tab>', ':BufferLineCyclePrev<CR>')
-- Пролистнуть на страницу вниз / вверх (как в браузерах)
vim.keymap.set('n', '<Space>', '<PageDown> zz')
vim.keymap.set('n', '<C-Space>', '<PageUp> zz')
-- " Переводчик рус -> eng
vim.keymap.set('v', 't', '<Plug>(VTranslate)', {})

-- По F1 очищаем последний поиск с подсветкой
vim.keymap.set('n', '<F1>', ':nohl<CR>')
-- <F6> дерево файлов.
vim.keymap.set('n', '<F6>', ':NvimTreeRefresh<CR>:NvimTreeToggle<CR>')
-- <F8>  Показ дерева классов и функций, плагин majutsushi/tagbar
vim.keymap.set('n', '<F8>', ':TagbarToggle<CR>')

vim.keymap.set('n', 'tb', ':Telescope buffers<CR><Esc>')
