"
" Auto commands
"

augroup Formatting
  autocmd!
  " Delete control character on saving file
  " autocmd BufWritePre * :%s/[\x00-\x1F\x7F]//ge
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
  autocmd BufNewfile,BufRead *_spec.rb set filetype=rspec
augroup END

augroup ColorSchemeSettings
  autocmd!
  autocmd VimEnter,ColorScheme * highlight CursorLine cterm=NONE ctermbg=NONE ctermfg=NONE guibg=NONE guifg=NONE
augroup END

augroup WindowCloseSettings
  autocmd!
  autocmd FileType help nnoremap <buffer> <C-q> <C-w><C-q>
augroup END
