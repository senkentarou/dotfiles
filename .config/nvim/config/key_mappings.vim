"
" Key mappings
"

"
" [[Text Objects]]
" Thanks to https://shnsprk.com/entry/2015/11/12/070000
"
" Operator + a/i + Object
"
" [Operator]
" c: change
" d: delete
" y: yank
" (v: visual)
"
" [a/i]
" a: an object
" i: inner
"
" [Object]
" w: word
" W: WORD (with white space)
" s: sentence (bun)
" p: paragraph (danraku)
" t: tag (html tag)
" ' " ` [ { <: 'inner from symbol'
"
" [[vim-surround]]
" Thanks to https://github.com/tpope/vim-surround
"
" Operator + Surround
"
" [Surround]
" [e]: exist surrounding char
" [d]: desire surrounding char
" [mo]: motion (a/i + Object)
"
" [Operator]
" ds [e]: delete surround [e]
" cs [e] [d]: change surround from [e] to [d]
" ys [mo] [d]: you surround with [d] on [mo]
"
" * If you want to surround without white space, you select end part of surrounding. ) } >

"
" Custom mappings
"
"
" * If you cannot apply your key mappings, you can see like ':verbose imap <C-h>' and can trace whole settings about it.

" Leaders
let mapleader="\<Space>"
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
" buffers
nnoremap <Leader>w :<C-u>w<CR>
nnoremap <Leader>W :lua vim.lsp.buf.formatting()<CR>
nnoremap <Leader>q :<C-u>BufferClose<CR>
nnoremap Q <Nop>
" comments
nmap <Leader>c <Plug>(caw:hatpos:toggle)
vmap <Leader>c <Plug>(caw:hatpos:toggle)
" rspec (for ruby file)
nnoremap <silent> <Leader>x :<C-u>ToggleRspecFile<CR>

nmap <silent> <Leader>j <Plug>(columnskip:nonblank:next)
omap <silent> <Leader>j <Plug>(columnskip:nonblank:next)
xmap <silent> <Leader>j <Plug>(columnskip:nonblank:next)
nmap <silent> <Leader>k <Plug>(columnskip:nonblank:prev)
omap <silent> <Leader>k <Plug>(columnskip:nonblank:prev)
xmap <silent> <Leader>k <Plug>(columnskip:nonblank:prev)

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
nnoremap <silent> <C-g><C-g> :<C-u>Neogit<CR>
nnoremap <silent> <C-g><C-o> :<C-u>GitOpenAdditionalFiles<CR>
" add
nnoremap <silent> <C-g><C-p> :<C-u>Gitsigns prev_hunk<CR>
nnoremap <silent> <C-g><C-n> :<C-u>Gitsigns next_hunk<CR>
nnoremap <silent> <C-g><C-h> :<C-u>Gitsigns preview_hunk<CR>
nnoremap <silent> <C-g><C-j> :<C-u>Gitsigns stage_hunk<CR>
nnoremap <silent> <C-g><C-k> :<C-u>Gitsigns undo_stage_hunk<CR>
nnoremap <silent> <C-g><C-r> :<C-u>Gitsigns reset_hunk<CR>
" view
nnoremap <silent> <C-g><C-b> :<C-u>Git blame --date=relative<CR>
nnoremap <silent> <C-g><C-l> :<C-u>DiffviewFileHistory<CR>
nnoremap <silent> <C-g>L :<C-u>DiffviewFileHistory --merges<CR>
nnoremap <silent> <C-g>P :<C-u>TermExec cmd='git push origin HEAD'<CR>
nnoremap <silent> + :<C-u>Gitsigns diffthis<CR>

" <C-w>
" defx Finder
nmap <silent> <C-w><C-w> :<C-u>Defx `expand('%:p:h')` -columns=git:icons:filename:type -search=`expand('%:p')`<CR>
nmap <silent> <C-w><C-q> :<C-u>close<CR>

" <C-e>
nmap <C-e> <Nop>
nmap <silent> <C-e><C-e> :<C-u>lua vim.lsp.buf.definition()<CR>
nmap <silent> <C-e><C-r> :<C-u>lua vim.lsp.buf.references()<CR>
nmap <silent> <C-e>r :<C-u>lua vim.lsp.buf.rename()<CR>
nmap <silent> <C-e><C-p> :<C-u>lua vim.lsp.diagnostic.goto_prev()<CR>
nmap <silent> <C-e><C-n> :<C-u>lua vim.lsp.diagnostic.goto_next()<CR>
nmap <silent> <C-e><C-d> :<C-u>TroubleToggle<CR>
nmap <silent> K :<C-u>lua vim.lsp.buf.hover()<CR>

" Useful settings
" Apply ESC
inoremap <silent> jj <ESC>
" No highlight
nnoremap <Esc><Esc> :noh<CR>
" Show buffers
nnoremap <silent> ; :<C-u>Buffers<CR>
" Open most recent buffer
nnoremap <silent> - :<C-u>OpenLatestClosedBuffer<CR>
" Close buffer
nnoremap <silent> <C-q> :<C-u>BufferClose<CR>
nmap <C-z><C-z> :<C-u>qall!<CR>
" Replace word
vmap p <Plug>(operator-replace)
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

" moving panes
nnoremap <C-j> <C-w><C-j>
nnoremap <C-k> <C-w><C-k>
nnoremap <C-l> <C-w><C-l>
nnoremap <C-h> <C-w><C-h>
