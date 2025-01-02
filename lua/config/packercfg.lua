-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'

  -- поиск
  use {
  'nvim-telescope/telescope.nvim', tag = '0.1.x',
  requires = { {'nvim-lua/plenary.nvim'} }
  }

  -----------------------------------------------------------
  -- ПЛАГИНЫ ВНЕШНЕГО ВИДА
  -----------------------------------------------------------

  -- цветовая схема 
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
  -- LSP и автодополнялка
  -----------------------------------------------------------

  use ('nvim-treesitter/nvim-treesitter', {run = ':TSUpdate'})
  use 'nvim-treesitter/nvim-treesitter-context'

  use {
	  'VonHeikemen/lsp-zero.nvim',
	  branch = 'v3.x',
	  requires = {
	    --- Uncomment these if you want to manage the language servers from neovim
	    {'williamboman/mason.nvim'},
	    {'williamboman/mason-lspconfig.nvim'},

	    -- LSP Support
	    {'neovim/nvim-lspconfig'},
	    -- Autocompletion
	    {'hrsh7th/nvim-cmp'},
	    {'hrsh7th/cmp-nvim-lsp'},
	    {'L3MON4D3/LuaSnip'},
    }
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

  -----------------------------------------------------------
  -- GO
  -----------------------------------------------------------

  use {'crispgm/nvim-go', require = {{'nvim-lua/popup.nvim'}, {'nvim-lua/plenary.nvim'}} }
  -- use 'ray-x/go.nvim'
  use 'ray-x/guihua.lua' -- recommended if need floating window support

  -----------------------------------------------------------
  -- Дебаггер
  -----------------------------------------------------------
  use {
    "mfussenegger/nvim-dap",
    config = function()
      require('dap')
    end
  }

  use {
    "leoluz/nvim-dap-go",
    config = function()
      require('dap-go').setup()
    end
  }

 use { "rcarriga/nvim-dap-ui", requires = {"mfussenegger/nvim-dap", "nvim-neotest/nvim-nio"} }

  use {
    "theHamsta/nvim-dap-virtual-text",
    requires = {"mfussenegger/nvim-dap"},
    config = function()
      require("nvim-dap-virtual-text").setup()
    end
  }

  use 'Weissle/persistent-breakpoints.nvim'


  -----------------------------------------------------------
  -- РАЗНОЕ
  -----------------------------------------------------------
  -- Даже если включена русская раскладка vim команды будут работать
  use 'powerman/vim-plugin-ruscmd'
  -- ]p - вставить на строку выше, [p - ниже
  use 'tpope/vim-unimpaired'
  -- Переводчик рус - англ
  use 'voldikss/vim-translator'
  --- popup окошки
  use 'nvim-lua/popup.nvim'
  -- Стартовая страница, если просто набрать vim в консоле
  use 'mhinz/vim-startify'
  -- Комментирует по gc все, вне зависимости от языка программирования
  use { 'numToStr/Comment.nvim',
  config = function() require('Comment').setup() end }
  -- Линтер, работает для всех языков
  -- use 'dense-analysis/ale'
  -- линия на курсоре и подсветка слов
  use 'yamatsum/nvim-cursorline'
  -- Закрывает автоматом скобки
  use 'cohama/lexima.vim'
  -- git annotations
  use 'tveskag/nvim-blame-line'
  -- git
  use 'tpope/vim-fugitive'
  use 'lewis6991/gitsigns.nvim'
end)
