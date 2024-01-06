-- UI enhancements
vim.diagnostic.config({
    virtual_text = true,
    signs = true,
    underline = true,
    update_in_insert = true,
    severity_sort = false,
    severity = { min = vim.diagnostic.severity.HINT }
})

vim.keymap.set("n", "gl", "<cmd>lua vim.diagnostic.open_float()<CR>")
