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

" Defx settings
autocmd! FileType defx :DefxMySettings
autocmd! BufWritePost * call defx#redraw()
autocmd! BufEnter * call defx#redraw()
" Disable auto complete on comment next line
autocmd! FileType * setlocal formatoptions-=ro

augroup SyntaxSettings
  autocmd!
  autocmd BufNewFile,BufRead *.tsx set filetype=typescriptreact
  autocmd BufNewFile,BufRead *.jsx set filetype=javascriptreact
augroup END
