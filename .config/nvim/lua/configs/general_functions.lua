vim.cmd([[
  command! NotQuit :bp | :sp | :bn | :bd

  " bd or q command
  function! s:BufferClose() abort
    if &filetype == 'defx'
      " close by defx command
      Defx
    elseif index(['Trouble', 'help'], &filetype) >= 0 || index(['[Command Line]'], expand('%:t')) >= 0
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
]])

-- indent guide setting
vim.g.indent_guides_enable_on_vim_startup = 1

-- toggleterm
local term = require("toggleterm")
term.setup{
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

require('gopr').setup {
  remote_base_url = 'github.com',
  default_remote = 'upstream'
}

require('godch').setup {
  remote_base_url = 'github.com',
  default_remote = 'upstream'
}
