command! NotQuit :bp | :sp | :bn | :bd

" bd or q command
function! s:BufferClose() abort
  if len(filter(range(1, bufnr('$')), 'buflisted(v:val)')) > 1
    " delete buffer
    execute 'bd'
  elseif index(['fugitive', 'gina-log', 'gina-reflog'], &filetype) >= 0
    " close pane
    execute 'close'
  elseif &filetype == 'startify'
    " no action
    :
  else
    " set mhinz/vim-startify
    NotQuit
    execute 'Startify'
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
command -nargs=* OpenLatestClosedBuffer call s:OpenLatestClosedBuffer()

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

" auto-pair
" avoid inoremap <C-h>
let g:AutoPairsMapCh = 0

lua << EOF
require("toggleterm").setup{
  -- size can be a number or function which is passed the current terminal
  size = 15,
  open_mapping = [[<c-\>]],
  hide_numbers = true, -- hide the number column in toggleterm buffers
  shade_filetypes = {},
  shade_terminals = true,
  start_in_insert = true,
  insert_mappings = true, -- whether or not the open mapping applies in insert mode
  persist_size = true,
  direction = 'horizontal',
  close_on_exit = true, -- close the terminal window when the process exits
  shell = vim.o.shell, -- change the default shell
}
EOF
