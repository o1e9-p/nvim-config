require("bufferline").setup({
  options = {
    numbers = "ordinal",
    diagnostics = "nvim_lsp"
  },
})

vim.keymap.set('n', '<right>', ':BufferLineCycleNext<CR>')
vim.keymap.set('n', '<left>', ':BufferLineCyclePrev<CR>')

-- close current tab
vim.keymap.set('n', 'bd', ':bd<CR>lua require"bufferline".go_to(num)<CR>')

-- go to tab (Not working)
vim.keymap.set('n', ' 1', ':BufferLineGoToBuffer 1<CR>')
vim.keymap.set('n', ' 2', ':BufferLineGoToBuffer 2<CR>')
vim.keymap.set('n', ' 3', ':BufferLineGoToBuffer 3<CR>')
vim.keymap.set('n', ' 4', ':BufferLineGoToBuffer 4<CR>')
vim.keymap.set('n', ' 5', ':BufferLineGoToBuffer 5<CR>')
vim.keymap.set('n', ' 6', ':BufferLineGoToBuffer 6<CR>')
vim.keymap.set('n', ' 7', ':BufferLineGoToBuffer 7<CR>')
vim.keymap.set('n', ' 8', ':BufferLineGoToBuffer 8<CR>')
vim.keymap.set('n', ' 9', ':BufferLineGoToBuffer 9<CR>')
vim.keymap.set('n', ' $', ':BufferLineGoToBuffer -1<CR>')

