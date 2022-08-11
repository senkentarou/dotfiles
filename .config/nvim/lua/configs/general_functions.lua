vim.cmd([[
  command! NotQuit :bp | :sp | :bn | :bd
]])

vim.cmd([[
  " bd or q command
  function! s:BufferClose() abort
    if &filetype == 'defx'
      " close by defx command
      Defx
    elseif index(['fugitive', 'fugitiveblame', 'gina-log', 'Trouble', 'help'], &filetype) >= 0 || index(['[Command Line]'], expand('%:t')) >= 0
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

function _G.set_terminal_keymaps()
  local opts = {buffer = 0}
  vim.keymap.set('t', '<esc>', [[<C-\><C-n>]], opts)
  vim.keymap.set('t', 'jk', [[<C-\><C-n>]], opts)
  vim.keymap.set('t', '<C-h>', [[<Cmd>wincmd h<CR>]], opts)
  vim.keymap.set('t', '<C-j>', [[<Cmd>wincmd j<CR>]], opts)
  vim.keymap.set('t', '<C-k>', [[<Cmd>wincmd k<CR>]], opts)
  vim.keymap.set('t', '<C-l>', [[<Cmd>wincmd l<CR>]], opts)
end

-- if you only want these mappings for toggle term use term://*toggleterm#* instead
vim.cmd('autocmd! TermOpen term://* lua set_terminal_keymaps()')

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
