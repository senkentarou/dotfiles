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
nnoremap <silent> <Leader>m :<C-u>Gina grep<CR>
vnoremap <silent> <Leader>m :<C-u>GGrepVisualWordQuery<CR>

" buffers
nnoremap <Leader>w :<C-u>w<CR>
nnoremap <Leader>q :<C-u>BufferClose<CR>
" comments
nmap <Leader>c <Plug>(caw:hatpos:toggle)
vmap <Leader>c <Plug>(caw:hatpos:toggle)
" rspec (for ruby file)
nnoremap <silent> <Leader>x :<C-u>ToggleRspecFile<CR>

" <C-f> Find files
nmap <C-f> <Nop>
" by word
nnoremap <silent> <C-f><C-d> :<C-u>SearchWords<CR>
" by file name
nnoremap <silent> <C-f><C-f> :<C-u>SearchFiles<CR>
" by git file name
nnoremap <silent> <C-f><C-g> :<C-u>GFiles<CR>
" by open history
nnoremap <silent> <C-f><C-r> :<C-u>History<CR>

" <C-g> Git
nmap <C-g> <Nop>
nnoremap <silent> <C-g><C-g> :<C-u>ToggleGStatus<CR>
nnoremap <silent> <C-g><C-b> :<C-u>Git blame --date=relative<CR>
vnoremap <silent> <C-g><C-b> :Git blame<CR>
nnoremap <silent> <C-g><C-d> :<C-u>Gvdiffsplit<CR>
nnoremap <silent> <C-g><C-l> :<C-u>Gina log<CR>
nnoremap <silent> <C-g><C-u> :<C-u>GitGutterUndoHunk<CR>
nnoremap <silent> <C-g><C-p> :<C-u>GitGutterPrevHunk<CR>
nnoremap <silent> <C-g><C-n> :<C-u>GitGutterNextHunk<CR>

" <C-w>
" defx Finder
nmap <silent> <C-w><C-w> :<C-u>Defx `expand('%:p:h')` -columns=git:icons:filename:type -search=`expand('%:p')`<CR>

" <C-e>
nmap <C-e> <Nop>
nmap <silent> <C-e><C-e> :<C-u>CocDiagnostics<CR>
nmap <silent> <C-e><C-p> <Plug>(coc-diagnostic-prev)
nmap <silent> <C-e><C-n> <Plug>(coc-diagnostic-next)
nmap <silent> <C-e><C-d> <Plug>(coc-definition)
nmap <silent> <C-e><C-r> <Plug>(coc-references)

" <C-s>
" floating terminal window
nnoremap <silent> <C-s><C-s> :<C-u>FloatermToggle<CR>
tnoremap <silent> <C-s><C-s> <C-\><C-n>:<C-u>FloatermToggle<CR>

" Useful settings
" Apply ESC
inoremap <silent> jj <ESC>
" Show buffers
nnoremap <silent> ; :<C-u>Buffers<CR>
" Delete buffers
nnoremap <silent> ' :<C-u>DeleteBuffers<CR>
" Open most recent buffer
nnoremap <silent> - :<C-u>b #<CR>
" Close buffer
nnoremap <silent> <C-q> :<C-u>BufferClose<CR>
nmap <C-z> :<C-u><C-q>all!<CR>
nmap Q :<C-u><C-q>!<CR>
" Replace word
vmap p <Plug>(operator-replace)
" Use <Tab> / <S-Tab> to navigate through popup menu
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
" diff line
vnoremap <silent> <C-y> :Linediff<CR>
nnoremap <C-y> :<C-u>LinediffReset<CR>

" Cursor moving
nnoremap H ^
nnoremap L $

nmap j <Plug>(accelerated_jk_gj)
nmap k <Plug>(accelerated_jk_gk)

imap <C-j> <Down>
imap <C-k> <Up>
imap <C-l> <Right>
imap <C-h> <Left>

nnoremap <C-j> <C-w><C-j>
nnoremap <C-k> <C-w><C-k>
nnoremap <C-l> <C-w><C-l>
nnoremap <C-h> <C-w><C-h>

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
