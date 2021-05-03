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
