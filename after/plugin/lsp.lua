local lsp  = require('lsp-zero')
lsp.extend_lspconfig()

lsp.on_attach(function(client, bufnr)
  local opts = {buffer = bufnr, remap = false}

  vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
  vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
  vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts)
  vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end, opts)
  vim.keymap.set("n", "[d", function() vim.diagnostic.goto_next() end, opts)
  vim.keymap.set("n", "]d", function() vim.diagnostic.goto_prev() end, opts)
  vim.keymap.set("n", "<leader>vca", function() vim.lsp.buf.code_action() end, opts)
  vim.keymap.set("n", "gr", function() vim.lsp.buf.references() end, opts)
  vim.keymap.set("n", "<leader>vrn", function() vim.lsp.buf.rename() end, opts)
  vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
	vim.keymap.set('n', 'C-]', function() vim.lsp.buf.definition() end, opts)
	vim.keymap.set('n', 'gD', function() vim.lsp.buf.declaration() end,opts)
	vim.keymap.set('n', 'gd', function() vim.lsp.buf.definition() end,opts)
	vim.keymap.set('n', 'gI', function() vim.lsp.buf.incoming_calls() end,opts)
	vim.keymap.set('n', 'gO', function() vim.lsp.buf.outgoing_calls() end,opts)
	vim.keymap.set('n', 'K', function() vim.lsp.buf.hover() end,opts)
	vim.keymap.set('n', 'gi', function() vim.lsp.buf.implementation() end,opts)
	vim.keymap.set('n', '<C-k>', function() vim.lsp.buf.signature_help() end,opts)
	vim.keymap.set('n', '<space>wa', function() vim.lsp.buf.add_workspace_folder() end,opts)
	vim.keymap.set('n', '<space>wr', function() vim.lsp.buf.remove_workspace_folder() end,opts)
	vim.keymap.set('n', '<space>D', function() vim.lsp.buf.type_definition() end,opts)
	vim.keymap.set('n', '<space>rn', function() vim.lsp.buf.rename() end,opts)
	vim.keymap.set('n', 'gr', function() vim.lsp.buf.references() end,opts)

end)

require('mason').setup({})
require('mason-lspconfig').setup({
  ensure_installed = {
    'gopls', 'golangci_lint_ls',
    'ts_ls', 'eslint'
  },
  automatic_installation = true,
  handlers = {
    lsp.default_setup,

    lua_ls = function()
      local lua_opts = lsp.nvim_lua_ls()
      require('lspconfig').lua_ls.setup(lua_opts)
    end,

    golangci_lint_ls = function()
      local lspconfig = require 'lspconfig'

      lspconfig.golangci_lint_ls.setup({
        cmd = {'golangci-lint-langserver'},
		  	root_dir = lspconfig.util.root_pattern('.git', 'go.mod'),
			  init_options = {
            command = {
                  "golangci-lint",
                  "run",
                  "--output.json.path", "stdout",
                  "--show-stats=false",
                  "--issues-exit-code=1"
            }
        },
        filetypes = {'go', 'gomod'},
      })
    end,

    tsserver = function()
      require('lspconfig').tsserver.setup({})
    end,

    eslint = function()
      local lspconfig = require 'lspconfig'
      lspconfig.eslint.setup({
        settings = {
          packageManager = 'npm'
        }
      })
    end,

  }
})

local cmp = require('cmp')
local cmp_select = {behavior = cmp.SelectBehavior.Select}

cmp.setup({
  sources = {
    {name = 'path'},
    {name = 'nvim_lsp'},
    {name = 'nvim_lua'},
    {name = 'luasnip', keyword_length = 2},
    {name = 'buffer', keyword_length = 3},
  },
  formatting = lsp.cmp_format(),
  mapping = cmp.mapping.preset.insert({
    ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
    ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
    ['<C-u>'] = cmp.mapping.scroll_docs(-4),
    ['<C-d>'] = cmp.mapping.scroll_docs(4),

    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-y>'] = cmp.mapping.confirm({ select = true }),
    ['<C-e>'] = cmp.mapping.abort(),
    ['<CR>'] = cmp.mapping.confirm({select = false})
  }),
})

local opts = { noremap=true, silent=true }

local function quickfix()
    vim.lsp.buf.code_action({
        filter = function(a) return a.isPreferred end,
        apply = true
    })
end

vim.keymap.set('n', '<leader>fq', quickfix, opts)

lsp.setup()


