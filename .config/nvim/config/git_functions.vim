" Git grep on current word
function! s:GGrepCurrentWordQuery() abort
  let cword = expand('<cword>')
  execute 'Gina grep ' . cword
endfunction
command! -nargs=* GGrepCurrentWordQuery call s:GGrepCurrentWordQuery()

function! s:GGrepVisualWordQuery() abort
  execute "normal! `<v`>y"
  let vtext = @@
  execute 'Gina grep ' . vtext
endfunction
command! -nargs=* GGrepVisualWordQuery call s:GGrepVisualWordQuery()

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
