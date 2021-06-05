command! NotQuit :bp | :sp | :bn | :bd

" bd or q command
function! s:BufferClose() abort
  if len(filter(range(1, bufnr('$')), 'buflisted(v:val)')) == 1
    NotQuit
    echo 'Please do :q'
    " I do NOT want to quit vim.
    " execute "q"
  else
    execute "bd"
  endif
endfunction
command! -nargs=* BufferClose call s:BufferClose()

" re-open delete buffer (Using https://github.com/yegappan/mru)
function! s:OpenLatestClosedBuffer() abort
  let mru_files = MruGetFiles()
  if len(mru_files) > 1
    execute 'e ' . mru_files[1]
  endif
endfunction
command -nargs=0 OpenLatestClosedBuffer call s:OpenLatestClosedBuffer()

" Open all additional change files in buffer
function! s:GitOpenAdditionalFiles() abort
  let goafs = systemlist("git status --porcelain | grep -wv D | awk '{print $2}'")
  let length = len(goafs)
  if length == 0
    echo 'No git additional files.'
    return
  endif
  " Open each file in buffer
  for goaf in goafs
    execute 'e ' . goaf
  endfor
  echo 'Opened ' . length . ' git additional files.'
endfunction
command! -nargs=* GitOpenAdditionalFiles call s:GitOpenAdditionalFiles()

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

" indent setting
let g:indent_guides_enable_on_vim_startup = 1

" floaterm
hi FloatermNF guibg=black
hi FloatermBorderNF guibg=black guifg=white
let g:floaterm_position = 'center'
let g:floaterm_width = 0.9
let g:floaterm_height = 0.8

" auto-pair
" avoid inoremap <C-h>
let g:AutoPairsMapCh = 0
