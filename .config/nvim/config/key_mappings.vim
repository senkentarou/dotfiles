"
" Key mappings
"

" * If you cannot apply your key mappings, you can see like ':verbose imap <C-h>' and can trace whole settings about it

" Leaders
let mapleader="\<Space>"
" reload config file
nnoremap <Leader>R :so ~/.config/nvim/init.vim<CR>
" open git browser
nnoremap <silent> <Leader>o :<C-u>GBrowse @upstream<CR>
nnoremap <silent> <Leader>O :<C-u>GBrowse @origin<CR>
nnoremap <silent> <Leader>b :<C-u>OpenCurrentBlameFile<CR>
vnoremap <silent> <Leader>o :GBrowse @upstream<CR>
vnoremap <silent> <Leader>O :GBrowse @origin<CR>
" grep word
nnoremap <silent> <Leader>, :<C-u>GinaGrepCurrentWordQuery<CR>
nnoremap <silent> <Leader>< :<C-u>GGrepCurrentWordQuery<CR>
nnoremap <silent> <Leader>m :<C-u>GinaGrepInteractiveInput<CR>
nnoremap <silent> <Leader>M :<C-u>GGrepInteractiveInput<CR>
vnoremap <silent> <Leader>m :<C-u>GinaGrepVisualWordQuery<CR>
vnoremap <silent> <Leader>M :<C-u>GGrepVisualWordQuery<CR>
nnoremap <silent> <Leader>n :<C-u>GinaGrepPreviousWordQuery<CR>
nnoremap <silent> <Leader>N :<C-u>GGrepPreviousWordQuery<CR>

" buffers
nnoremap <Leader>w :<C-u>w<CR>
nnoremap <Leader>W :lua vim.lsp.buf.formatting_sync(nil, 100)<CR>
nnoremap Q <Nop>
nnoremap <Leader>q :<C-u>BufferClose<CR>
" comments
nmap <Leader>c <Plug>(caw:hatpos:toggle)
vmap <Leader>c <Plug>(caw:hatpos:toggle)
" rspec (for ruby file)
nnoremap <silent> <Leader>x :<C-u>ToggleRspecFile<CR>

" <C-f> Find files
nmap <C-f> <Nop>
" by git file name
nnoremap <silent> <C-f><C-f> :<C-u>GFiles<CR>
" by word with file preview
nnoremap <silent> <C-f><C-d> :<C-u>SearchWords<CR>
" by file name with file preview
nnoremap <silent> <C-f><C-g> :<C-u>SearchFiles<CR>
" by open history
nnoremap <silent> <C-f><C-r> :<C-u>SearchHistories<CR>

" <C-g> Git
nmap <C-g> <Nop>
nnoremap <silent> <C-g><C-g> :<C-u>ToggleGStatus<CR>
nnoremap <silent> <C-g><C-b> :<C-u>Git blame --date=relative<CR>
vnoremap <silent> <C-g><C-b> :Git blame<CR>
nnoremap <silent> <C-g><C-j> :<C-u>GitGutterStageHunk<CR>
nnoremap <silent> <C-g><C-k> :<C-u>OpenGitCommit<CR>
nnoremap <silent> <C-g><C-d> :<C-u>Gvdiffsplit<CR>
nnoremap <silent> <C-g><C-f> :<C-u>Gina diff --cached --opener=split<CR>
nnoremap <silent> <C-g><C-h> :<C-u>Gina reset<CR>
nnoremap <silent> <C-g><C-r> :<C-u>Gina reflog --opener=vsplit<CR>
nnoremap <silent> <C-g>L :<C-u>Gina log --opener=vsplit<CR>
nnoremap <silent> <C-g><C-l> :<C-u>GLogCurrentFile<CR>
nnoremap <silent> <C-g><C-m> :<C-u>GitGutterPreviewHunk<CR>
nnoremap <silent> <C-g><C-u> :<C-u>GitGutterUndoHunk<CR>
nnoremap <silent> <C-g><C-p> :<C-u>GitGutterPrevHunk<CR>
nnoremap <silent> <C-g><C-n> :<C-u>GitGutterNextHunk<CR>
nnoremap <silent> <C-g><C-o> :<C-u>GitOpenAdditionalFiles<CR>

" <C-w>
" defx Finder
nmap <silent> <C-w><C-w> :<C-u>Defx `expand('%:p:h')` -columns=git:icons:filename:type -search=`expand('%:p')`<CR>
nmap <silent> <C-w><C-q> :<C-u>close<CR>

" <C-e>
nmap <C-e> <Nop>
nmap <silent> <C-e><C-e> :<C-u>TroubleToggle<CR>
nmap <silent> <C-e><C-p> :<C-u>lua vim.lsp.diagnostic.goto_prev()<CR>
nmap <silent> <C-e><C-n> :<C-u>lua vim.lsp.diagnostic.goto_next()<CR>
nmap <silent> <C-e><C-d> :<C-u>lua vim.lsp.buf.definition()<CR>
nmap <silent> <C-e><C-r> :<C-u>lua vim.lsp.buf.references()<CR>
nmap <silent> <C-e><C-f> :<C-u>lua vim.lsp.buf.formatting()<CR>
nmap <silent> <C-e>r :<C-u>lua vim.lsp.buf.rename()<CR>

" Useful settings
" Apply ESC
inoremap <silent> jj <ESC>
" No highlight
nnoremap <Esc><Esc> :noh<CR>
" Show buffers
nnoremap <silent> ; :<C-u>Buffers<CR>
" Delete buffers
nnoremap <silent> ' :<C-u>DeleteBuffers<CR>
" Open most recent buffer
nnoremap <silent> - :<C-u>OpenLatestClosedBuffer<CR>
" Open next buffer
nnoremap <silent> + :<C-u>bn<CR>
" Close buffer
nnoremap <silent> <C-q> :<C-u>BufferClose<CR>
nmap <C-z><C-z> :<C-u>qall!<CR>
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

nmap sj <Plug>(columnskip:nonblank:next)
omap sj <Plug>(columnskip:nonblank:next)
xmap sj <Plug>(columnskip:nonblank:next)
nmap sk <Plug>(columnskip:nonblank:prev)
omap sk <Plug>(columnskip:nonblank:prev)
xmap sk <Plug>(columnskip:nonblank:prev)

nmap sJ <Plug>(columnskip:first-nonblank:next)
omap sJ <Plug>(columnskip:first-nonblank:next)
xmap sJ <Plug>(columnskip:first-nonblank:next)
nmap sK <Plug>(columnskip:first-nonblank:prev)
omap sK <Plug>(columnskip:first-nonblank:prev)
xmap sK <Plug>(columnskip:first-nonblank:prev)

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
" show compe suggestions without word input
inoremap <silent> <expr> <C-e> compe#complete()
" decide compe suggention
inoremap <silent> <expr> <CR> compe#confirm('<CR>')
" unshow compe suggentions
inoremap <silent> <expr> <C-c> compe#close('<C-c>')
