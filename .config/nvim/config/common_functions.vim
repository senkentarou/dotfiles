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
  \ 'coc-solargraph',
  \ ]

" indent setting
let g:indent_guides_enable_on_vim_startup = 1

" lightline
let g:lightline = {
      \ 'colorscheme': 'one',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'gitbranch', 'readonly', 'filename', 'modified' ] ]
      \ },
      \ 'component_function': {
      \   'gitbranch': 'gina#component#repo#branch'
      \ },
      \ }

" floaterm
hi FloatermNF guibg=black
hi FloatermBorderNF guibg=black guifg=white
let g:floaterm_position = 'center'
let g:floaterm_width = 0.9
let g:floaterm_height = 0.8
