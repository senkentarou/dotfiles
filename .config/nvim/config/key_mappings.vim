"
" Key mappings
"

" * If you cannot apply your key mappings, you can see like ':verbose imap <C-h>' and can trace whole settings about it

" Leaders
let mapleader="\<Space>"
" open git browser
nnoremap <silent> <Leader>o :<C-u>GBrowse @upstream<CR>
nnoremap <silent> <Leader>O :<C-u>GBrowse @origin<CR>
vnoremap <silent> <Leader>o :GBrowse @upstream<CR>
vnoremap <silent> <Leader>O :GBrowse @origin<CR>
" grep word
nnoremap <silent> <Leader>, :<C-u>GGrepCurrentWordQuery<CR>
nnoremap <silent> <Leader>n :<C-u>Gina grep<CR>
" buffers
nnoremap <Leader>w :<C-u>w<CR>
nnoremap <Leader>q :<C-u>BufferClose<CR>
nnoremap <silent> <Leader>m :<C-u>b #<CR>
" comments
nmap <Leader>c <Plug>(caw:hatpos:toggle)
vmap <Leader>c <Plug>(caw:hatpos:toggle)
" rspec (for ruby file)
nnoremap <silent> <Leader>x :<C-u>ToggleRspecFile<CR>

" <C-f> Find files
nmap <C-f> <Nop>
" by word
nnoremap <silent> <C-f><C-d> :<C-u>RG<CR>
" by file name
nnoremap <silent> <C-f><C-f> :<C-u>FZFFileList<CR>
" by git file name
nnoremap <silent> <C-f><C-g> :<C-u>GFiles<CR>
" by open history
nnoremap <silent> <C-f><C-r> :<C-u>History<CR>

" <C-g> Git
nmap <C-g> <Nop>
nnoremap <silent> <C-g><C-g> :<C-u>ToggleGStatus<CR>
nnoremap <silent> <C-g><C-b> :<C-u>Git blame<CR>
nnoremap <silent> <C-g><C-d> :<C-u>Gvdiffsplit<CR>
nnoremap <silent> <C-g><C-l> :<C-u>Gina log<CR>

" <C-w>
nmap <C-w> <Nop>
" defx Finder
nmap <silent> <C-w><C-w> :<C-u>Defx `expand('%:p:h')` -columns=git:icons:filename:type -search=`expand('%:p')`<CR>

" <C-e>
nmap <C-e> <Nop>
" nmap gf open file under cursor
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

" <C-s>
" floating terminal window
nnoremap <silent> <C-s><C-s> :<C-u>FloatermToggle<CR>
tnoremap <silent> <C-s><C-s> <C-\><C-n>:<C-u>FloatermToggle<CR>

" Useful settings
" Apply ESC
inoremap <silent> jj <ESC>
" Show buffers
nnoremap <silent> ; :<C-u>Buffers<CR>
" Close buffer
nnoremap <silent> <C-q> :<C-u>BufferClose<CR>
" Replace word
vmap p <Plug>(operator-replace)
" Use <Tab> / <S-Tab> to navigate through popup menu
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" Cursor moving
nnoremap H ^
nnoremap L $

nmap j <Plug>(accelerated_jk_gj)
nmap k <Plug>(accelerated_jk_gk)

imap <C-j> <Down>
imap <C-k> <Up>
imap <C-l> <Right>
imap <C-h> <Left>

" vsnip
" Expand
imap <expr> <C-e> vsnip#expandable() ? '<Plug>(vsnip-expand)' : '<C-m>'
smap <expr> <C-e> vsnip#expandable() ? '<Plug>(vsnip-expand)' : '<C-m>'
" Jump forward or backward
imap <expr> <C-b> vsnip#available(1) ? '<Plug>(vsnip-expand-or-jump)' : '<C-b>'
smap <expr> <C-b> vsnip#available(1) ? '<Plug>(vsnip-expand-or-jump)' : '<C-b>'

" compe
inoremap <silent> <expr> <C-Space> compe#complete()
inoremap <silent> <expr> <CR> compe#confirm('<CR>')
