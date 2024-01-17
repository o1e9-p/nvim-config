require("bufferline").setup({
  options = {
    numbers = "ordinal",
    diagnostics = "nvim_lsp"
  },
})

vim.keymap.set('n', '<right>', ':BufferLineMoveNext<CR>')
vim.keymap.set('n', '<left>', ':BufferLineMovePrev<CR>')

-- go to tab (Not working)
vim.keymap.set('n', '<leader>1', 'lua require"bufferline".go_to(1)<CR>')
vim.keymap.set('n', '<leader>2', 'lua require"bufferline".go_to(2)<CR>')
vim.keymap.set('n', '<leader>3', 'lua require"bufferline".go_to(3)<CR>')
vim.keymap.set('n', '<leader>4', 'lua require"bufferline".go_to(4)<CR>')
vim.keymap.set('n', '<leader>5', 'lua require"bufferline".go_to(5)<CR>')
vim.keymap.set('n', '<leader>6', 'lua require"bufferline".go_to(6)<CR>')
vim.keymap.set('n', '<leader>7', 'lua require"bufferline".go_to(7)<CR>')
vim.keymap.set('n', '<leader>8', 'lua require"bufferline".go_to(8)<CR>')
vim.keymap.set('n', '<leader>9', 'lua require"bufferline".go_to(9)<CR>')
vim.keymap.set('n', '<leader>$', 'lua require"bufferline".go_to( -1)<CR>')

