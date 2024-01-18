local function my_on_attach(bufnr)
  local api = require "nvim-tree.api"

  local function opts(desc)
    return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
  end

  -- default mappings
  api.config.mappings.default_on_attach(bufnr)

  vim.keymap.set('n', '<C-t>', api.tree.change_root_to_parent, opts('Up'))
  vim.keymap.set('n', '?',     api.tree.toggle_help, opts('Help'))

  -- <F6> дерево файлов.
  vim.keymap.set('n', '<silent><Tab>', ':NvimTreeRefresh<CR>:NvimTreeToggle<CR>')
end


require'nvim-tree'.setup({
  sort = {
    sorter = "case_sensitive",
  },
  view = {
    width = 30,
  },
  renderer = {
    group_empty = true,
    icons = {
      web_devicons = {
        file = {
          enable = true,
          color = true,
        },
        folder = {
          enable = false,
          color = true,
        },
      },
      show = {
        file = true,
        folder = true,
      },
    },
  },
  filters = {
    -- dotfiles = true,
  },
  update_focused_file = {
    enable = true,
    update_cwd = false,
  },
  on_attach = my_on_attach,
  diagnostics = {
    enable = true,
  },
  actions= {
    open_file = {
      quit_on_open = true,
    },
  }
})
