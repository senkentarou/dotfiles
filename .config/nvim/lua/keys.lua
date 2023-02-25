--
-- Key mappings
--
--
-- [[Text Objects]]
-- Thanks to https://shnsprk.com/entry/2015/11/12/070000
--
-- Operator + a/i + Object
--
-- [Operator]
-- c: change
-- d: delete
-- y: yank
-- (v: visual)
--
-- [a/i]
-- a: an object
-- i: inner
--
-- [Object]
-- w: word
-- W: WORD (with white space)
-- s: sentence (bun)
-- p: paragraph (danraku)
-- t: tag (html tag)
-- ' " ` [ { <: 'inner from symbol'
--
-- [[vim-sandwich]]
-- Thanks to https://github.com/machakann/vim-sandwich
--   and https://machakann.hatenablog.com/entry/2015/07/25/205921
--
-- sa: surround add
--  `saiw(` pattern: foo => (foo)
-- sd: surround delete
--  `sd(` pattern: (foo) => foo
-- sr: surround replace
--  `sr("` pattern: (foo) => "foo"
--
-- Custom mappings
--
-- * If you cannot apply your key mappings, you can see like ':verbose imap <C-h>' and can trace whole settings about it.
vim.cmd([[
  " <Space> Leaders
  let mapleader="\<Space>"
  nmap <C-z> <Nop>
  nnoremap Z <Nop>
  nnoremap Q <Nop>
  nnoremap <Leader><Leader> :<C-u>lua require('global_functions').toggle_lsp_lines_text()<CR>
  nnoremap <silent> <Leader>a :<C-u>lua require('actions-preview').code_actions()<CR>
  nnoremap <silent> <Leader>r :<C-u>lua vim.lsp.buf.rename()<CR>
  nnoremap <silent> <Leader>o :<C-u>Gobf<CR>
  vnoremap <silent> <Leader>o :Gobf<CR>
  nnoremap <silent> <Leader>O :<C-u>lua require('gobf').open_git_blob_file({ target_hash = vim.fn.input('[CommitHash] ')})<CR>
  nnoremap <silent> <Leader>p :<C-u>Gocd<CR>
  nnoremap <silent> <Leader>P :<C-u>Gopr<CR>
  " grep words
  nnoremap <silent> <Leader>, :<C-u>execute 'Gina grep ' . expand('<cword>')<CR>
  nnoremap <silent> <Leader>< :<C-u>lua require('telescope.builtin').grep_string()<CR>
  nnoremap <silent> <Leader>m :<C-u>execute 'Gina grep ' . input('[GitGrep] ')<CR>
  nnoremap <silent> <Leader>M :<C-u>lua require('telescope.builtin').grep_string({ search = vim.fn.input('[GitGrep] ')})<CR>
  " buffers
  nnoremap <Leader>w :<C-u>w<CR>
  nnoremap <Leader>W :lua vim.lsp.buf.format({ async = true })<CR>
  " comments
  nmap <Leader>c <Plug>(comment_toggle_linewise_current)
  vmap <Leader>c <Plug>(comment_toggle_linewise_visual)
  " ruby
  nnoremap <silent> <Leader>y :<C-u>lua require('neogen').generate()<CR>
  nnoremap <silent> <Leader>x :<C-u>ToggleRspecFile<CR>
  nnoremap <silent> <Leader>z :<C-u>CopyRspecCommand<CR>
  nnoremap <silent> <Leader>Z :<C-u>CopyRspecAtLineCommand<CR>

  " <C-f> Find files
  nmap <C-f> <Nop>
  nnoremap <silent> <C-f><C-f> :<C-u>lua require('telescope.builtin').find_files()<CR>
  nnoremap <silent> <C-f>, :<C-u>lua require('telescope.builtin').grep_string()<CR>
  nnoremap <silent> <C-f>m :<C-u>lua require('telescope.builtin').live_grep()<CR>
  nnoremap <silent> <C-f><C-r> :<C-u>lua require('telescope.builtin').oldfiles()<CR>

  nmap <silent> <C-_> :<C-u>lua require('telescope.builtin').search_history()<CR>

  " <C-g> Git
  nmap <C-g> <Nop>
  nnoremap <silent> <C-g><C-g> :<C-u>lua require('telescope.builtin').git_status()<CR>
  nnoremap <silent> <C-g><C-o> :<C-u>Goacf<CR>
  nnoremap <silent> <C-g><C-l> :<C-u>DiffviewFileHistory %<CR>
  vnoremap <silent> <C-g><C-l> :DiffviewFileHistory %<CR>
  nnoremap <silent> <C-g><C-p> :<C-u>Gitsigns prev_hunk<CR>
  nnoremap <silent> <C-g><C-n> :<C-u>Gitsigns next_hunk<CR>
  nnoremap <silent> <C-g><C-h> :<C-u>Gitsigns preview_hunk<CR>
  nnoremap <silent> <C-g><C-j> :<C-u>Gitsigns stage_hunk<CR>
  nnoremap <silent> <C-g>j :<C-u>Gitsigns undo_stage_hunk<CR>
  nnoremap <silent> <C-g>J :<C-u>Gitsigns stage_buffer<CR>
  nnoremap <silent> <C-g><C-k> :<C-u>Gina commit --verbose<CR>
  nnoremap <silent> <C-g>r :<C-u>Gitsigns reset_hunk<CR>
  nnoremap <silent> <C-g>R :<C-u>Gitsigns reset_buffer<CR>
  nnoremap <silent> + :<C-u>lua require('telescope').extensions.gh_pr.list({ remote = 'upstream', search = 'is:pr is:open user-review-requested:@me' })<CR>
  nnoremap <silent> - :<C-u>lua require('telescope').extensions.gh_pr.list({ remote = 'upstream' })<CR>

  " <C-w> Filer
  nmap <C-w> <Nop>
  nmap <silent> <C-w><C-q> :<C-u>close<CR>
  nnoremap <silent> <C-w><C-w> :<C-u>lua require('telescope').extensions.file_browser.file_browser({ initial_mode = 'normal' })<CR>

  " <C-e> LSP
  nmap <C-e> <Nop>
  nnoremap <silent> <C-e><C-e> :<C-u>lua vim.lsp.buf.definition()<CR>
  nnoremap <silent> <C-e><C-r> :<C-u>lua vim.lsp.buf.references()<CR>
  nnoremap <silent> K :<C-u>lua vim.lsp.buf.hover()<CR>

  " Moving cursor
  nmap j <Plug>(accelerated_jk_gj)
  nmap k <Plug>(accelerated_jk_gk)
  nnoremap H ^
  nnoremap L $
  " Moving panes
  nnoremap <C-j> <C-w><C-j>
  nnoremap <C-k> <C-w><C-k>
  nnoremap <C-l> <C-w><C-l>
  nnoremap <C-h> <C-w><C-h>
  " Moving hop keyword
  nnoremap s <Nop>
  nnoremap sj <Plug>(edgemotion-j)
  vnoremap sj <Plug>(edgemotion-j)
  nnoremap sk <Plug>(edgemotion-k)
  vnoremap sk <Plug>(edgemotion-k)
  nnoremap <silent> sl :<C-u>lua require('tsht').move({ side = "end" })<CR>
  nnoremap <silent> sh :<C-u>lua require('tsht').move({ side = "start" })<CR>
  nnoremap f :<C-u>HopChar1CurrentLineAC<CR>
  vnoremap f <cmd>HopChar1CurrentLineAC<CR>
  nnoremap F :<C-u>HopChar1CurrentLineBC<CR>
  vnoremap F <cmd>HopChar1CurrentLineBC<CR>
  " Moving on insert mode
  imap <C-j> <Down>
  imap <C-k> <Up>
  imap <C-l> <Right>
  imap <C-h> <Left>
  " Apply ESC
  inoremap <silent> jj <ESC>
  " No highlight
  nnoremap <silent> <Esc><Esc> :noh<CR>
  " Show buffers
  nnoremap <silent> ; :<C-u>lua require('telescope.builtin').buffers({ sort_lastused = true, ignore_current_buffer = true })<CR>
  " Close buffer
  nnoremap <silent> <C-q> :<C-u>BufferClose<CR>
  " Diff line
  vnoremap <silent> <C-y> :Linediff<CR>
  nnoremap <C-y> :<C-u>LinediffReset<CR>
]])
