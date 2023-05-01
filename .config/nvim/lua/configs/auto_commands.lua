vim.cmd([[
  " Disable auto complete comment literal on next line
  autocmd FileType * setlocal formatoptions-=ro

  augroup Formatting
    autocmd!
    " Delete control character on saving file
    " autocmd BufWritePre * :%s/[\x00-\x1F\x7F]//ge
    " Delete extra space on saving file
    autocmd BufWritePre * :%s/\s\+$//ge
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
    " Gitsigns
    autocmd VimEnter,ColorScheme * highlight GitSignsCurrentLineBlame ctermfg=243 guifg=#707880
    " Github copilot highlight
    autocmd VimEnter,ColorScheme * highlight CopilotSuggestion cterm=underline ctermfg=139 ctermbg=53 gui=underline guifg=#b294bb guibg=#5f005f guisp=Magenta
  augroup END
]])
