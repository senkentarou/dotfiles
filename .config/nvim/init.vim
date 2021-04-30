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

"
" Env settings
"
let g:lightline = {
      \ 'colorscheme': 'one',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'gitbranch', 'readonly', 'filename', 'modified' ] ]
      \ },
      \ 'component_function': {
      \   'gitbranch': 'gina#component#repo#branch'
      \ },
      \ }

let g:gitgutter_highlight_lines = 0
hi GitGutterDelete guifg=red

hi FloatermNF guibg=black
hi FloatermBorderNF guibg=black guifg=white
let g:floaterm_position = 'center'
let g:floaterm_width = 0.9
let g:floaterm_height = 0.8

" nvim-lspconfig
lua << EOF
require'lspconfig'.tsserver.setup{
  -- filetypes = {'typescript', 'typescript.tsx', 'typescriptreact'}
}
require'lspconfig'.solargraph.setup{}
require'lspconfig'.flow.setup{}
require'lspconfig'.yamlls.setup{}
require'lspconfig'.pyright.setup{}
EOF

" vsnip
" Expand
imap <expr> <C-f> vsnip#expandable() ? '<Plug>(vsnip-expand)'         : '<C-j>'
smap <expr> <C-f> vsnip#expandable() ? '<Plug>(vsnip-expand)'
" Jump forward or backward
imap <expr> <C-b> vsnip#available(1) ? '<Plug>(vsnip-expand-or-jump)' : '<C-b>'
smap <expr> <C-b> vsnip#available(1) ? '<Plug>(vsnip-expand-or-jump)' : '<C-b>'

" If you want to use snippet for multiple filetypes, you can `g:vsnip_filetypes` for it.
let g:vsnip_filetypes = {}
let g:vsnip_filetypes.javascriptreact = ['javascript']
let g:vsnip_filetypes.typescriptreact = ['typescript']

" nvim-compe
lua << EOF
require'compe'.setup {
  enabled = true;
  autocomplete = true;
  debug = false;
  min_length = 1;
  preselect = 'enable';
  throttle_time = 80;
  source_timeout = 200;
  incomplete_delay = 400;
  max_abbr_width = 100;
  max_kind_width = 100;
  max_menu_width = 100;
  documentation = true;
  source = {
    path = true;
    buffer = true;
    spell = true;
    calc = true;
    nvim_lsp = true;
    nvim_lua = true;
    vsnip = true;
  };
}
EOF

inoremap <silent><expr> <C-Space> compe#complete()
inoremap <silent><expr> <CR>      compe#confirm('<CR>')

" rubocop a
autocmd BufWrite *.rb :call CocActionAsync('format')
