" bd or q command
function! s:BufferClose() abort
  if len(filter(range(1, bufnr('$')), 'buflisted(v:val)')) == 1
    execute "q"
  else
    execute "bd"
  endif
endfunction
command! -nargs=* BufferClose call s:BufferClose()

" rspec script
function! s:toggleRspecFile() abort
  let filename = expand('%:t')
  if filename =~ '\.rb$'
    let current_dir = expand('%:r')
    let basename = @%
    if current_dir =~ 'spec'
      execute 'e ' . substitute(substitute(basename, filename, '', 'g'), 'spec', 'app', 'g') . substitute(filename, '_spec.rb', '', 'g') . '.rb'
    else
      execute 'e ' . substitute(substitute(basename, filename, '', 'g'), 'app', 'spec', 'g') . substitute(filename, '.rb', '', 'g') . '_spec.rb'
    endif
  endif
endfunction
command! -nargs=* ToggleRspecFile call s:toggleRspecFile()

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
      \   'left': [
      \     [ 'mode', 'paste' ],
      \     [ 'gitbase', 'gitbranch', 'readonly', 'filename', 'modified' ]
      \   ],
      \   'right': [
      \     [ 'lineinfo' ],
      \     [ 'percent' ],
      \     [ 'cocstatus', 'currentfunction', 'fileformat', 'fileencoding', 'filetype' ]
      \   ]
      \ },
      \ 'component_function': {
      \   'gitbase': 'GitBase',
      \   'gitbranch': 'gina#component#repo#branch',
      \   'filename': 'FilePathFromGitBase',
      \   'cocstatus': 'coc#status',
      \   'currentfunction': 'CocCurrentFunction'
      \ },
      \ }

function! FilePathFromGitBase()
  let root = fnamemodify(get(b:, 'git_dir'), ':h')
  let path = expand('%:p')
  if path[:len(root)-1] ==# root
    return path[len(root)+1:]
  endif
  return expand('%')
endfunction

function! FilePathFromGitBase()
  let root = fnamemodify(get(b:, 'git_dir'), ':h')
  let path = expand('%:p')
  if path[:len(root)-1] ==# root
    return path[len(root)+1:]
  endif
  return expand('%')
endfunction

function! GitBase()
  let root = fnamemodify(fnamemodify(get(b:, 'git_dir'), ':h'), ':t')
  if root == '.'
    return '[NO GIT]'
  endif
  return root
endfunction

function! CocCurrentFunction()
  return get(b:, 'coc_current_function', '')
endfunction

" floaterm
hi FloatermNF guibg=black
hi FloatermBorderNF guibg=black guifg=white
let g:floaterm_position = 'center'
let g:floaterm_width = 0.9
let g:floaterm_height = 0.8

" auto-pair
" avoid inoremap <C-h>
let g:AutoPairsMapCh = 0
