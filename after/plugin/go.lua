local golang_opts = {
  auto_format = true,
  -- linters: revive, errcheck, staticcheck, golangci-lint
  -- linter = 'golangci_lint',
  auto_lint = false,
  -- qf or vt
  lint_prompt_style = 'qf',
  -- formatter =  ['gofumpt', 'goimports', 'gofmt'],
  -- formatter =  'goimports',
  test_flags = {'-v'},
  test_timeout = '30s',
  test_env = {},
  test_popup = true,
  test_popup_width = 80,
  test_popup_height = 10,
  test_open_cmd = 'edit',
  tags_name = 'json',
  tags_options = {'json=omitempty'},
  tags_transform = 'snakecase',
  tags_flags = {'-skip-unexported'},
  quick_type_flags = {'--just-types'},
}
-- setup nvim-go
require('go').setup(golang_opts)

local format_sync_grp = vim.api.nvim_create_augroup("GoFormat", {})
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*.go",
  callback = function()
    require('go.format').goimports()
  end,
  group = format_sync_grp,
})
