--
-- Plugin settings
--
-- Before do :PlugInstall, download plug.vim
-- sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
--
-- See details: https://github.com/junegunn/vim-plug

vim.cmd([[
  call plug#begin(stdpath('data') . '/plugged')

  " Statusline
  Plug 'glepnir/galaxyline.nvim', {'branch': 'main'}
  " Color Scheme
  Plug 'w0ng/vim-hybrid'
  " Syntax highlight
  Plug 'sheerun/vim-polyglot'
  " Indent highlight
  Plug 'nathanaelkane/vim-indent-guides'
  " Auto complete
  Plug 'j-hui/fidget.nvim'
  Plug 'neovim/nvim-lspconfig'
  Plug 'williamboman/mason.nvim'
  Plug 'williamboman/mason-lspconfig.nvim'
  Plug 'kyazdani42/nvim-web-devicons'
  Plug 'folke/trouble.nvim'
  Plug 'folke/lsp-colors.nvim'
  " Snipet
  Plug 'rafamadriz/friendly-snippets'
  Plug 'onsails/lspkind.nvim'
  Plug 'L3MON4D3/LuaSnip'
  " Completion
  Plug 'saadparwaiz1/cmp_luasnip'
  Plug 'hrsh7th/cmp-nvim-lsp'
  Plug 'hrsh7th/cmp-nvim-lsp-signature-help'
  Plug 'hrsh7th/cmp-buffer'
  Plug 'hrsh7th/cmp-path'
  Plug 'hrsh7th/cmp-cmdline'
  Plug 'hrsh7th/nvim-cmp'
  " null-ls
  Plug 'nvim-lua/plenary.nvim'
  Plug 'jose-elias-alvarez/null-ls.nvim'
  " Auto complete for bracket pairs
  Plug 'windwp/nvim-autopairs'
  " Search word
  Plug 'phaazon/hop.nvim'
  " Finder
  Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.0' }
  " Filer
  Plug 'Shougo/defx.nvim'
  Plug 'roxma/nvim-yarp'
  Plug 'roxma/vim-hug-neovim-rpc'
  " Filer icons
  Plug 'ryanoasis/vim-devicons'
  Plug 'kristijanhusak/defx-icons'
  " Git
  Plug 'tpope/vim-fugitive'
  Plug 'tpope/vim-rhubarb'
  Plug 'lambdalisue/gina.vim'
  Plug 'TimUntersberger/neogit'
  Plug 'sindrets/diffview.nvim'
  Plug 'lewis6991/gitsigns.nvim'
  " Open terminal window
  Plug 'akinsho/nvim-toggleterm.lua'
  " Open browser window
  Plug 'tyru/open-browser.vim'
  " Accelerate up/down
  Plug 'rhysd/accelerated-jk'
  " Replacer
  Plug 'kana/vim-operator-user'
  Plug 'kana/vim-operator-replace'
  Plug 'tpope/vim-surround'
  Plug 'terrortylor/nvim-comment'
  " Line comparison
  Plug 'AndrewRadev/linediff.vim'
  " Start window
  Plug 'mhinz/vim-startify'
  " tree-sitter
  Plug 'nvim-treesitter/nvim-treesitter', { 'do': ':TSUpdate' }
  Plug 'windwp/nvim-ts-autotag'
  Plug 'andymass/vim-matchup'

  " my plugin
  Plug 'senkentarou/gopr.nvim'
  Plug 'senkentarou/goacf.nvim'

  call plug#end()
]])

require('options')
require('keys')
require('configs')
