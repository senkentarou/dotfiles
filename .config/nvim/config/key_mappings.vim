"
" Key mappings
"
" * If you cannot apply your key mappings, you can see like ':verbose imap <C-h>' and can trace whole settings about it
let mapleader="\<Space>"

" Show file on github
nnoremap <silent> <Leader>o :<C-u>GBrowse @upstream<CR>
nnoremap <silent> <Leader>O :<C-u>GBrowse @origin<CR>
nnoremap <silent> <Leader>, :<C-u>GGrepCurrentWordQuery<CR>
nnoremap <Leader>w :<C-u>w<CR>
nnoremap <silent> <Leader>q :<C-u>BufferClose<CR>
nmap <silent> <Leader>x :<C-u>ToggleRspecFile<CR>

nmap <Leader>c <Plug>(caw:hatpos:toggle)
vmap <Leader>c <Plug>(caw:hatpos:toggle)

" Show buffers
nnoremap <silent> ; :<C-u>Buffers<CR>
" Close buffer
nnoremap <silent> <C-q> :<C-u>BufferClose<CR>

" Find files
" by word
nnoremap <silent> <C-f><C-d> :<C-u>RG<CR>
" by file name
nnoremap <silent> <C-f><C-f> :<C-u>FZFFileList<CR>
" by git file name
nnoremap <silent> <C-f><C-g> :<C-u>GFiles<CR>
" by open history
nnoremap <silent> <C-f><C-r> :<C-u>History<CR>

" Open defx Finder
nmap <silent> <C-w><C-w> :<C-u>Defx `expand('%:p:h')` -columns=git:icons:filename:type -search=`expand('%:p')`<CR>

nmap <C-g> <Nop>
nnoremap <silent> <C-g><C-g> :<C-u>ToggleGStatus<CR>
nnoremap <silent> <C-g>b :<C-u>Git blame<CR>
nnoremap <silent> <C-g>[ :<C-u>GitGutterPrevHunk<CR>
nnoremap <silent> <C-g>] :<C-u>GitGutterNextHunk<CR>
nnoremap <silent> <C-g>d :<C-u>Gvdiffsplit<CR>

nmap j <Plug>(accelerated_jk_gj)
nmap k <Plug>(accelerated_jk_gk)
imap <C-j> <Down>
imap <C-k> <Up>
imap <C-l> <Right>
imap <C-h> <Left>

noremap H ^
noremap L $

" nmap gf open file under cursor
nmap <silent> gp :<C-u>bprevious<CR>
nmap <silent> gn :<C-u>bnext<CR>
nmap <silent> g, :<C-u>LspCodeAction<CR>
nmap <silent> ga :<C-u>LspDocumentDiagnostics<CR>
nmap <silent> g[ :<C-u>LspPreviousDiagnostic<CR>
nmap <silent> g] :<C-u>LspNextDiagnostic<CR>
nmap <silent> gd :<C-u>LspDefinition<CR>
nmap <silent> gr :<C-u>LspReferences<CR>
nmap <silent> T :<C-u>LspPeekTypeDefinition<CR>
nmap <silent> gt :<C-u>LspTypeDefinition<CR>
nmap <silent> K :<C-u>LspPeekDefinition<CR>
nmap <silent> gK :<C-u>LspDefinition<CR>

" Show line on github
vnoremap <silent> <Leader>o :GBrowse @upstream<CR>
vnoremap <silent> <Leader>O :GBrowse @origin<CR>

vmap p <Plug>(operator-replace)

" Apply ESC
inoremap <silent> jj <ESC>
" Use <Tab> / <S-Tab> to navigate through popup menu
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" floating window
nnoremap <silent> <C-a><C-a> :<C-u>FloatermToggle<CR>
tnoremap <silent> <C-a><C-a> <C-\><C-n>:<C-u>FloatermToggle<CR>

" vsnip
" Expand
imap <expr> <C-f> vsnip#expandable() ? '<Plug>(vsnip-expand)' : '<C-m>'
smap <expr> <C-f> vsnip#expandable() ? '<Plug>(vsnip-expand)' : '<C-m>'
" Jump forward or backward
imap <expr> <C-b> vsnip#available(1) ? '<Plug>(vsnip-expand-or-jump)' : '<C-b>'
smap <expr> <C-b> vsnip#available(1) ? '<Plug>(vsnip-expand-or-jump)' : '<C-b>'

" compe
inoremap <silent> <CR> compe#confirm('<CR>')

