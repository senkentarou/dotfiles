"
" Key mappings
"
let mapleader="\<Space>"

""" nmaps
" Show file on github
nnoremap <Leader>o :<C-u>Gbrowse @upstream<CR>
nnoremap <Leader>O :<C-u>Gbrowse @origin<CR>
nnoremap <Leader>b :<C-u>Gblame<CR>
nnoremap <Leader>g :<C-u>GGrepCurrentWordQuery<CR>
" Show buffers
nnoremap <silent> ; :<C-u>Buffers<CR>
" Close buffer
nnoremap <silent> <C-q> :<C-u>BufferClose<CR>
" Find files from current dir recursively
nnoremap <silent> <C-f><C-f> :<C-u>FZFFileList<CR>
" Find git files
nnoremap <silent> <C-f><C-g> :<C-u>GFiles<CR>
" Open Finder
nnoremap <silent> <C-t><C-t> :<C-u>Defx `expand('%:p:h')` -columns=git:icons:filename:type -search=`expand('%:p')`<CR>

" Find and open history file
nnoremap <silent> <C-g><C-r> :<C-u>History<CR>
" Jump next/prev on git change
nnoremap <silent> <C-g><C-n> <Plug>(GitGutterNextHunk)
nnoremap <silent> <C-g><C-p> <Plug>(GitGutterPrevHunk)
nnoremap <silent> <C-g><C-b> :<C-u>OpenCurrentBlameFile<CR>

nmap j <Plug>(accelerated_jk_gj)
nmap k <Plug>(accelerated_jk_gk)
nmap K :LspPeekDefinition<CR>
nmap gd :LspDefinition<CR>
nmap gl :LspReferences<CR>
nmap gr :LspRename<CR>
nmap gt :LspTypeDefinition<CR>

""" vmaps
" Show line on github
vnoremap <Leader>o :Gbrowse @upstream<CR>
vnoremap <Leader>O :Gbrowse @origin<CR>

""" imaps
" Apply ESC
inoremap <silent> jj <ESC>
" Use <Tab> / <S-Tab> to navigate through popup menu
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

