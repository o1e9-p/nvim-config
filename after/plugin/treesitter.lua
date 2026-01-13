-- Check if nvim-treesitter is available
local ok, configs = pcall(require, 'nvim-treesitter.configs')
if not ok then
  return
end

configs.setup {
  ensure_installed = { "c", "lua", "vim", "vimdoc", "query", "go", "gomod", "gosum", "javascript", "typescript", "tsx", "html", "css" },
  sync_install = false,  -- install asynchronously
  auto_install = true,   -- auto install when entering buffer
  highlight = { enable = true },
}
