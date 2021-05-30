"
" Auto commands
"

augroup Formatting
  autocmd!
  " Delete control character on saving file
  autocmd BufWritePre * :%s/[\x00-\x1F\x7F]//ge
  " Delete extra space on saving file
  autocmd BufWritePre * :%s/\s\+$//ge
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
augroup END

augroup ColorSchemeSettings
  autocmd!
  autocmd VimEnter,ColorScheme * highlight GitGutterDelete ctermfg=52 guifg=#ff2222 ctermbg=NONE guibg=NONE
  autocmd VimEnter,ColorScheme * highlight GitGutterAdd ctermfg=22 guifg=#009900 ctermbg=NONE guibg=NONE
  autocmd VimEnter,ColorScheme * highlight GitGutterChange ctermfg=58 guifg=#bbbb00 ctermbg=NONE guibg=NONE
  autocmd VimEnter,ColorScheme * highlight GitGutterChangeDelete ctermfg=52 guifg=#ff2222 ctermbg=NONE guibg=NONE
augroup END
