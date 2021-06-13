"
" Auto commands
"

augroup Formatting
  autocmd!
  " Delete control character on saving file
  " autocmd BufWritePre * :%s/[\x00-\x1F\x7F]//ge
  " Delete extra space on saving file
  autocmd BufWritePre * :%s/\s\+$//ge
  " lspconfig
  autocmd BufWritePre *.js lua vim.lsp.buf.formatting_sync(nil, 100)
  autocmd BufWritePre *.jsx lua vim.lsp.buf.formatting_sync(nil, 100)
  autocmd BufWritePre *.ts lua vim.lsp.buf.formatting_sync(nil, 100)
  autocmd BufWritePre *.tsx lua vim.lsp.buf.formatting_sync(nil, 100)
  autocmd BufWritePre *.rb lua vim.lsp.buf.formatting_sync(nil, 100)
augroup END

augroup DefxSettings
  autocmd!
  autocmd FileType defx :DefxMySettings
  autocmd BufWritePost * call defx#redraw()
  autocmd BufEnter * call defx#redraw()
augroup END

" Disable auto complete on comment next line
autocmd FileType * setlocal formatoptions-=ro

augroup SyntaxSettings
  autocmd!
  autocmd BufNewFile,BufRead *.tsx set filetype=typescriptreact
  autocmd BufNewFile,BufRead *.jsx set filetype=javascriptreact
  autocmd BufNewfile,BufRead *_spec.rb set filetype=rspec
augroup END

augroup ColorSchemeSettings
  autocmd!
  autocmd VimEnter,ColorScheme * highlight GitGutterDelete ctermfg=52 guifg=#ec5f67 ctermbg=NONE guibg=NONE
  autocmd VimEnter,ColorScheme * highlight GitGutterAdd ctermfg=22 guifg=#98be65 ctermbg=NONE guibg=NONE
  autocmd VimEnter,ColorScheme * highlight GitGutterChange ctermfg=58 guifg=#a9a1e1 ctermbg=NONE guibg=NONE
  autocmd VimEnter,ColorScheme * highlight GitGutterChangeDelete ctermfg=52 guifg=#ec5f67 ctermbg=NONE guibg=NONE
augroup END

augroup WindowCloseSettings
  autocmd!
  autocmd FileType help nnoremap <buffer> <C-q> <C-w><C-q>
augroup END
