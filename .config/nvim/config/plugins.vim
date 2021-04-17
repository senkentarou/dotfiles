"
" Plugin settings
"
call plug#begin(stdpath('data') . '/plugged')

" Color Scheme
Plug 'w0ng/vim-hybrid'

" Syntax highlight
Plug 'sheerun/vim-polyglot'
" Indent highlight
Plug 'nathanaelkane/vim-indent-guides'

" Language server
Plug 'prabirshrestha/vim-lsp'
" LSP client for js/ts
Plug 'neoclide/coc.nvim', {'branch': 'release', 'for': ['javascript', 'javascriptreact', 'typescript', 'typescriptreact']}

" Auto complete
Plug 'nvim-lua/completion-nvim'
Plug 'neovim/nvim-lspconfig'
Plug 'mattn/vim-lsp-settings'
" Auto complete for bracket pairs
Plug 'jiangmiao/auto-pairs'
Plug 'tpope/vim-endwise'

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

" Open floating window
Plug 'voldikss/vim-floaterm'
" Open browser window
Plug 'tyru/open-browser.vim'
" Accelerate up/down
Plug 'rhysd/accelerated-jk'

call plug#end()

