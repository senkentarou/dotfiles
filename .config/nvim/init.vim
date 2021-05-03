"
" Load settings
"
source $HOME/.config/nvim/config/plugins.vim
source $HOME/.config/nvim/config/common_functions.vim
source $HOME/.config/nvim/config/git_functions.vim
source $HOME/.config/nvim/config/fzf_functions.vim
source $HOME/.config/nvim/config/defx_functions.vim
source $HOME/.config/nvim/config/completion_functions.vim
source $HOME/.config/nvim/config/key_mappings.vim
source $HOME/.config/nvim/config/auto_commands.vim

"
" Vim settings
"
set guifont=Droid\ Sans\ Mono\ for\ Powerline\ Nerd\ Font\ Complete\ 12
set undofile
set cmdheight=2
set ignorecase
set hidden
set autoread
set noshowmode
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

" WARNING here is my reforming things
" do not want use :q command (cannot input original q in command mode...)
cnoremap q w
cnoremap <C-q> q
" close without saving
nmap <C-z> :<C-u><C-q>!<CR>
nmap Q :<C-u><C-q><CR>
" add auto completion of def end in ruby file
" see https://github.com/jiangmiao/auto-pairs
autocmd FileType ruby let b:AutoPairs = AutoPairsDefine({'\v(^|\W)\zsdef': 'end//n'})

"
" Env settings
"

" rubocop a
autocmd BufWrite *.rb :call CocActionAsync('format')
