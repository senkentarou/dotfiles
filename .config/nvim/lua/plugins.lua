--
-- Plugin settings
--
-- Before do :PlugInstall, download plug.vim
-- sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
--
-- See details: https://github.com/junegunn/vim-plug
vim.cmd([[
  call plug#begin(stdpath('data') . '/plugged')

  " Color Scheme
  Plug 'w0ng/vim-hybrid'
  " Start window
  Plug 'goolord/alpha-nvim'
  " Statusline
  Plug 'nvim-lualine/lualine.nvim'
  Plug 'nvim-tree/nvim-web-devicons'
  " LSP
  Plug 'nvim-lua/plenary.nvim'
  Plug 'williamboman/mason.nvim'
  Plug 'williamboman/mason-lspconfig.nvim'
  Plug 'WhoIsSethDaniel/mason-tool-installer.nvim'
  Plug 'j-hui/fidget.nvim'
  Plug 'neovim/nvim-lspconfig'
  Plug 'folke/lsp-colors.nvim'
  Plug 'Maan2003/lsp_lines.nvim'
  Plug 'rafamadriz/friendly-snippets'
  Plug 'onsails/lspkind.nvim'
  Plug 'L3MON4D3/LuaSnip'
  Plug 'saadparwaiz1/cmp_luasnip'
  Plug 'hrsh7th/cmp-nvim-lsp'
  Plug 'hrsh7th/cmp-nvim-lsp-signature-help'
  Plug 'hrsh7th/cmp-buffer'
  Plug 'hrsh7th/cmp-path'
  Plug 'hrsh7th/cmp-cmdline'
  Plug 'hrsh7th/nvim-cmp'
  Plug 'aznhe21/actions-preview.nvim'
  Plug 'jose-elias-alvarez/null-ls.nvim'
  Plug 'jose-elias-alvarez/typescript.nvim'
  " Finder
  Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.0' }
  " Git
  Plug 'kdheepak/lazygit.nvim'
  Plug 'sindrets/diffview.nvim'
  Plug 'lewis6991/gitsigns.nvim'
  " Accelerate up/down
  Plug 'rhysd/accelerated-jk'
  Plug 'haya14busa/vim-edgemotion'
  " Replacer
  Plug 'machakann/vim-sandwich'
  Plug 'numToStr/Comment.nvim'
  " Annotation
  Plug 'danymat/neogen'
  Plug 'folke/todo-comments.nvim'
  " Line comparison
  Plug 'AndrewRadev/linediff.vim'
  " Open browser window
  Plug 'tyru/open-browser.vim'
  " Parsing
  Plug 'sheerun/vim-polyglot'
  Plug 'nvim-treesitter/nvim-treesitter', { 'do': ':TSUpdate' }
  Plug 'simrat39/symbols-outline.nvim'
  " Indent highlight
  Plug 'lukas-reineke/indent-blankline.nvim'
  " Search word
  Plug 'phaazon/hop.nvim'
  Plug 'mfussenegger/nvim-treehopper'
  " Auto complete for bracket pairs
  Plug 'windwp/nvim-autopairs'
  Plug 'andymass/vim-matchup'
  Plug 'RRethy/nvim-treesitter-endwise'
  " Copilot
  Plug 'github/copilot.vim'

  " My plugin
  Plug 'senkentarou/gopr.nvim'
  Plug 'senkentarou/goacf.nvim'
  Plug 'senkentarou/gobf.nvim'
  Plug 'senkentarou/ruby_spec.nvim'
  Plug 'senkentarou/telescope-gh-pr.nvim'
  Plug 'senkentarou/telescope-git-log.nvim'

  " Plug 'nvim-telescope/telescope-file-browser.nvim' " disable until https://github.com/nvim-telescope/telescope-file-browser.nvim/issues/104 is as fixed
  Plug 'senkentarou/telescope-file-browser.nvim' " Use instead of nvim-telescope/telescope-file-browser.nvim

  " Plug 'windwp/nvim-ts-autotag' " disable until https://github.com/windwp/nvim-ts-autotag/pull/83 is merged
  Plug 'sifu/nvim-ts-autotag' " Use instead of windwp/nvim-ts-autotag

  call plug#end()
]])

require('options')
require('keys')
require('configs')
