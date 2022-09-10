--
-- Auto commands
--
function _G.set_terminal_keymaps()
  local opts = { buffer = 0 }
  vim.keymap.set('t', '<esc>', [[<C-\><C-n>]], opts)
  vim.keymap.set('t', 'jk', [[<C-\><C-n>]], opts)
  vim.keymap.set('t', '<C-h>', [[<Cmd>wincmd h<CR>]], opts)
  vim.keymap.set('t', '<C-j>', [[<Cmd>wincmd j<CR>]], opts)
  vim.keymap.set('t', '<C-k>', [[<Cmd>wincmd k<CR>]], opts)
  vim.keymap.set('t', '<C-l>', [[<Cmd>wincmd l<CR>]], opts)
end

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

  augroup FilerSettings
    autocmd!
    autocmd BufLeave vfiler:* :bdelete
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
  augroup END

  autocmd TermOpen term://* lua set_terminal_keymaps()
]])
