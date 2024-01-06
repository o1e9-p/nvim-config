-- LSP setup
local lsp = require("lsp-zero")
lsp.preset("recommended")

lsp.ensure_installed({
    "tsserver",
    -- "eslint",
    "gopls",
    "golangci_lint_ls",
    "clangd",
    "cssls",
    -- "zls",
    -- "jedi_language_server",
    -- "emmet_ls",
    -- "angularls",
})

-- CMP setup
-- local cmp = require("cmp")
-- local cmp_select = { behavior = cmp.SelectBehavior.Select }
-- local cmp_mappings = lsp.defaults.cmp_mappings({
--     ["<Tab>"] = cmp.mapping.confirm({ select = false }),
--     ["<C-Space>"] = cmp.mapping.complete(),
--     ["<C-e>"] = cmp.mapping.abort(),
--     ["<C-p>"] = cmp.mapping.select_prev_item(cmp_select),
--     ["<C-n>"] = cmp.mapping.select_next_item(cmp_select),
--     ["<C-b>"] = cmp.mapping.scroll_docs(-4),
--     ["<C-f>"] = cmp.mapping.scroll_docs(4),
-- })
--
-- lsp.setup_nvim_cmp({
--     mapping = cmp_mappings,
--     sources = {
--         { name = 'path' },
--         { name = 'nvim_lsp' },
--         { name = 'buffer' },
--         { name = 'luasnip' },
--     }
-- })


-- Key bindings
-- local on_attach = function(client, bufnr)
--     local bufopts = { noremap = true, silent = true, buffer = bufnr }
--     vim.keymap.set("n", "gD", vim.lsp.buf.declaration, bufopts)
--     vim.keymap.set("n", "gd", vim.lsp.buf.definition, bufopts)
--     vim.keymap.set("n", "K", vim.lsp.buf.hover, bufopts)
--     vim.keymap.set("n", "gi", vim.lsp.buf.implementation, bufopts)
--     vim.keymap.set("i", "<C-k>", vim.lsp.buf.signature_help, bufopts)
--     vim.keymap.set("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, bufopts)
--     vim.keymap.set("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, bufopts)
--     vim.keymap.set("n", "<leader>wl", function()
--         print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
--     end, bufopts)
--     vim.keymap.set("n", "<leader>D", vim.lsp.buf.type_definition, bufopts)
--     vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, bufopts)
--     vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, bufopts)
--     vim.keymap.set("n", "gr", vim.lsp.buf.references, bufopts)
--     vim.keymap.set("n", "<leader>f", function() vim.lsp.buf.format { async = true } end, bufopts)
--     vim.keymap.set("n", "<C-]>", function() vim.diagnostic.goto_next() end)
--     vim.keymap.set("n", "<C-[>", function() vim.diagnostic.goto_prev() end)
--     require("lsp_signature").on_attach({
--         doc_lines = 0,
--         handler_opts = {
--             border = "none",
--         },
--     }, bufnr)
-- end
--
--
-- lsp.on_attach(on_attach)


lsp.setup()

-- local rust_tools = require("rust-tools")
--
-- rust_tools.setup({
--     server = {
--         on_attach = on_attach,
--     }
-- })



require("fidget").setup()

-- UI enhancements

vim.diagnostic.config({
    virtual_text = true,
    signs = true,
    underline = true,
    update_in_insert = true,
    severity_sort = false,
})
