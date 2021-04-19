"
" Load settings
"
source $HOME/.config/nvim/config/plugins.vim
source $HOME/.config/nvim/config/common_functions.vim
source $HOME/.config/nvim/config/git_functions.vim
source $HOME/.config/nvim/config/fzf_functions.vim
source $HOME/.config/nvim/config/defx_functions.vim
source $HOME/.config/nvim/config/key_mappings.vim
source $HOME/.config/nvim/config/auto_commands.vim

"
" Vim settings
"
set guifont=Droid\ Sans\ Mono\ for\ Powerline\ Nerd\ Font\ Complete\ 12
set undofile
set cmdheight=2
set ignorecase
" Colorscheme
set termguicolors
colorscheme hybrid
" File encoding
set encoding=utf-8
" Line settings
set number
set backspace=indent,eol,start
set whichwrap=b,s,<,>,[,],h,l
" Clipboard sharing
set clipboard=unnamed
" Completion settings
set completeopt=menuone,noinsert,noselect
set shortmess+=c
" Tab settings
set expandtab
set smarttab
set shiftwidth=2
set softtabstop=2
set tabstop=2

"
" Env settings
"
hi FloatermNF guibg=black
hi FloatermBorderNF guibg=black guifg=white
let g:floaterm_position = 'center'
let g:floaterm_width = 0.9
let g:floaterm_height = 0.8

