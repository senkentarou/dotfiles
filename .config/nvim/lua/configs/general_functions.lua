vim.cmd([[
  command! NotQuit :bp | :sp | :bn | :bd

  " bd or q command
  function! s:BufferClose() abort
    if &filetype == 'startify'
      " no action
      :
    elseif index(['Trouble', 'help', 'vim-plug'], &filetype) >= 0 || index(['[Command Line]'], expand('%:t')) >= 0
      " close pane
      execute 'close'
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
  command! -nargs=0 OpenLatestClosedBuffer call s:OpenLatestClosedBuffer()
]])

-- indent guide setting
vim.g.indent_guides_enable_on_vim_startup = 1

-- hop
require('hop').setup {}

-- nvim_comment
require('nvim_comment').setup {}

-- ruby_spec
require('ruby_spec').setup {
  marker_directory = '.git',  -- .git is commonly seen on rails project
  rspec_commands = {
    'bundle',
    'exec',
    'rspec'
  }
}
