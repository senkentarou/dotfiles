command! NotQuit :bp | :sp | :bn | :bd

" bd or q command
function! s:BufferClose() abort
  if &filetype == 'defx'
    " close by defx command
    Defx
  elseif index(['fugitive', 'fugitiveblame', 'gina-log', 'Trouble'], &filetype) >= 0 || index(['[Command Line]'], expand('%:t')) >= 0
    " close pane
    execute 'close'
  elseif &filetype == 'startify'
    " no action
    :
  elseif len(filter(range(1, bufnr('$')), 'buflisted(v:val)')) > 1
    " delete buffer
    execute 'bd'
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
  let current_fname = expand('%:t')
  let current_rdir = expand('%:h')

  " Execute only rb file.
  if current_fname =~ '\.rb$'
    if current_fname =~ '_spec.rb'
      let target_fname = substitute(current_fname, '_spec.rb', '.rb', '')
    else
      let target_fname = substitute(current_fname, '.rb', '_spec.rb', '')
    endif

    if current_rdir =~ 'spec'
      let target_rdir = substitute(current_rdir, 'spec', 'app', '')

      if target_rdir =~ 'requests'
        let target_rdir = substitute(target_rdir, 'requests', 'controllers', '')
      endif
    else
      let target_rdir = substitute(current_rdir, 'app', 'spec', '')

      " Open request spec file for controllers. (Open controller spec file if it exists already.)
      if target_rdir =~ 'controllers' && !filereadable(target_rdir . '/' . target_fname)
        let target_rdir = substitute(target_rdir, 'controllers', 'requests', '')
      endif
    endif

    call mkdir(target_rdir, 'p')

    execute 'e ' . target_rdir . '/' . target_fname
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
