" Git grep on current word
function! s:gGrepCurrentWordQuery() abort
  let cword = expand('<cword>')
  execute 'Gina grep ' . cword
endfunction
command! -nargs=* GGrepCurrentWordQuery call s:gGrepCurrentWordQuery()

function! ToggleGStatus()
  if buflisted(bufname('.git/index'))
    bd .git/index
  else
    execute 'vertical Git'
  endif
endfunction
command!  -nargs=* ToggleGStatus call ToggleGStatus()

" gitgutter
let g:gitgutter_highlight_lines = 0
hi GitGutterDelete guifg=#ff2222 ctermfg=1
