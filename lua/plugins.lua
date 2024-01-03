vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function()
  -- Packer сам себя
  use 'wbthomason/packer.nvim'

  -----------------------------------------------------------
  -- ПЛАГИНЫ ВНЕШНЕГО ВИДА
  -----------------------------------------------------------

  -- Цветовая схема
  -- use 'joshdick/onedark.vim'
  use {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    opts = {},
  }
  --- Информационная строка внизу
  use { 'nvim-lualine/lualine.nvim',
    requires = {'nvim-tree/nvim-web-devicons', opt = true}
  }
  -- Табы вверху
  use {'akinsho/bufferline.nvim', requires = 'nvim-tree/nvim-web-devicons',
  config = function()
      end, }
  -- Иконки расширений файлов
  use {
    'nvim-tree/nvim-web-devicons',
    config = function()
      require('nvim-web-devicons').setup({ default = true; })
    end
  }
  -----------------------------------------------------------
  -- НАВИГАЦИЯ
  -----------------------------------------------------------
  -- Файловый менеджер
  use {
    'nvim-tree/nvim-tree.lua',
    requires = {
      'nvim-tree/nvim-web-devicons', -- optional
    },
  }
  -- Навигация внутри файла по классам и функциям
  use 'majutsushi/tagbar'
  -- Замена fzf и ack
  use { 'nvim-telescope/telescope.nvim',
  requires = { {'nvim-lua/plenary.nvim'} },
  config = function() require'telescope'.setup {} end, }


  -----------------------------------------------------------
  -- LSP и автодополнялка
  -----------------------------------------------------------


  -- Highlight, edit, and navigate code using a fast incremental parsing library
  use 'nvim-treesitter/nvim-treesitter'
  -- Collection of configurations for built-in LSP client
  use 'neovim/nvim-lspconfig'
  use 'williamboman/mason.nvim'
  -- Автодополнялка
  use 'hrsh7th/nvim-cmp'
  use 'hrsh7th/cmp-nvim-lsp'
  use 'hrsh7th/cmp-buffer'
  use 'saadparwaiz1/cmp_luasnip'
  --- Автодополнлялка к файловой системе
  use 'hrsh7th/cmp-path'
  -- Snippets plugin
  use 'L3MON4D3/LuaSnip'

  -----------------------------------------------------------
  -- GOLANG
  -----------------------------------------------------------

  use 'ray-x/go.nvim'
  use 'ray-x/guihua.lua' -- recommended if need floating window support

  use {'crispgm/nvim-go', require = {{'nvim-lua/popup.nvim'}, {'nvim-lua/plenary.nvim'}} }

  -----------------------------------------------------------
  -- For golang and rust
  -----------------------------------------------------------

  use 'nvim-lua/plenary.nvim'

  -----------------------------------------------------------
  -- HTML и CSS
  -----------------------------------------------------------
  -- Подсвечивает закрывающий и откры. тэг. Если, где-то что-то не закрыто, то не подсвечивает.
  use 'idanarye/breeze.vim'
  -- Закрывает автоматом html и xml тэги. Пишешь <h1> и он автоматом закроется </h1>
  use 'alvan/vim-closetag'
  -- Подсвечивает #ffffff
  use 'ap/vim-css-color'

  -----------------------------------------------------------
  -- РАЗНОЕ
  -----------------------------------------------------------
  -- Даже если включена русская раскладка vim команды будут работать
  use 'powerman/vim-plugin-ruscmd'
  -- 'Автоформатирование' кода для всех языков
  use 'Chiel92/vim-autoformat'
  -- ]p - вставить на строку выше, [p - ниже
  use 'tpope/vim-unimpaired'
  -- Переводчик рус - англ
  use 'skanehira/translate.vim'
  --- popup окошки
  use 'nvim-lua/popup.nvim'
  -- Обрамляет или снимает обрамление. Выдели слово, нажми S и набери <h1>
  use 'tpope/vim-surround'
  -- Считает кол-во совпадений при поиске
  use 'google/vim-searchindex'
  -- Может повторять через . vimsurround
  use 'tpope/vim-repeat'
  -- Стартовая страница, если просто набрать vim в консоле
  use 'mhinz/vim-startify'
  -- Комментирует по gc все, вне зависимости от языка программирования
  use { 'numToStr/Comment.nvim',
  config = function() require('Comment').setup() end }
  -- Обрамляет строку в теги по ctrl- y + ,
  use 'mattn/emmet-vim'
  -- Закрывает автоматом скобки
  use 'cohama/lexima.vim'
  -- Линтер, работает для всех языков
  use 'dense-analysis/ale'
  -- Дебаггер
  use { "rcarriga/nvim-dap-ui", requires = {"mfussenegger/nvim-dap"} }
  use 'theHamsta/nvim-dap-virtual-text'
end)
