--
-- Auto commands
--
vim.cmd([[
  " Disable auto complete on comment next line
  autocmd FileType * setlocal formatoptions-=ro

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
    autocmd BufEnter,BufWritePost * call defx#redraw()
  augroup END

  augroup SyntaxSettings
    autocmd!
    autocmd BufNewFile,BufRead *.tsx set filetype=typescriptreact
    autocmd BufNewFile,BufRead *.jsx set filetype=javascriptreact
    autocmd BufNewfile,BufRead *_spec.rb set filetype=rspec
  augroup END

  augroup ColorSchemeSettings
    autocmd!
    " General
    autocmd VimEnter,ColorScheme * highlight CursorLine cterm=NONE ctermbg=NONE ctermfg=NONE guibg=NONE guifg=NONE
    " Telescope
    autocmd VimEnter,ColorScheme * highlight TelescopeMatching ctermfg=167 guifg=#cc6666
  augroup END
]])
