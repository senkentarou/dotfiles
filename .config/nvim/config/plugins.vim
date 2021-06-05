"
" Plugin settings
"
" Before do :PlugInstall, download plug.vim
" sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
"       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
"
" See details: https://github.com/junegunn/vim-plug
call plug#begin(stdpath('data') . '/plugged')

" Statusline
Plug 'glepnir/galaxyline.nvim' , {'branch': 'main'}
" Color Scheme
Plug 'w0ng/vim-hybrid'
" Syntax highlight
Plug 'sheerun/vim-polyglot'
" Plug 'mechatroner/rainbow_csv'
" Indent highlight
Plug 'nathanaelkane/vim-indent-guides'
" Auto complete
Plug 'neovim/nvim-lspconfig'
Plug 'kyazdani42/nvim-web-devicons'
Plug 'folke/trouble.nvim'
Plug 'folke/lsp-colors.nvim'
Plug 'hrsh7th/nvim-compe'
" Snipet
Plug 'rafamadriz/friendly-snippets'
Plug 'hrsh7th/vim-vsnip'
Plug 'hrsh7th/vim-vsnip-integ'
" Auto complete for bracket pairs
Plug 'jiangmiao/auto-pairs'
" Finder
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
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
Plug 'airblade/vim-gitgutter'
" Open floating terminal window
Plug 'voldikss/vim-floaterm'
" Open browser window
Plug 'tyru/open-browser.vim'
" Accelerate up/down
Plug 'rhysd/accelerated-jk'
" Replacer
Plug 'kana/vim-operator-user'
Plug 'kana/vim-operator-replace'
Plug 'tpope/vim-surround'
Plug 'tyru/caw.vim'
" Line comparison
Plug 'AndrewRadev/linediff.vim'
" Most recentry used history
Plug 'yegappan/mru'
" Start window
Plug 'mhinz/vim-startify'

call plug#end()

