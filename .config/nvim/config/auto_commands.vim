"
" Auto commands
"

" Delete extra space on saving file
autocmd! BufWritePre * :%s/\s\+$//ge
" Delete control character on saving file
autocmd! BufWritePre * :%s/[\x00-\x1F\x7F]//ge
" Defx settings
autocmd! FileType defx :DefxMySettings
" Disable auto complete on comment next line
autocmd! FileType * setlocal formatoptions-=ro

augroup SyntaxSettings
  autocmd!
  autocmd BufNewFile,BufRead *.tsx set filetype=typescriptreact
  autocmd BufNewFile,BufRead *.jsx set filetype=javascriptreact
augroup END

" Use completion-nvim in every buffer
augroup LuaSettings
  autocmd!
  autocmd BufEnter * lua require'completion'.on_attach()
augroup END
