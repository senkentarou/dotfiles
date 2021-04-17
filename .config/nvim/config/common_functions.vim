" bd or q command
function! s:BufferClose() abort
  if len(filter(range(1, bufnr('$')), 'buflisted(v:val)')) == 1
    execute "q"
  else
    execute "bd"
  endif
endfunction
command! -nargs=* BufferClose call s:BufferClose()

" coc
let g:coc_global_extensions = [
  \ 'coc-eslint',
  \ 'coc-prettier',
  \ ]

" indent setting
let g:indent_guides_enable_on_vim_startup = 1

