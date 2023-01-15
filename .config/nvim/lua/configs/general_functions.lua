vim.cmd([[
  command! NotQuit :bp | :sp | :bn | :bd

  " bd or q command
  function! s:BufferClose() abort
    if &filetype == 'alpha'
      " no action
      :
    elseif index(['DiffviewFileHistory'], &filetype) >= 0
      execute 'tabclose'
    elseif index(['help', 'vim-plug'], &filetype) >= 0 || index(['[Command Line]'], expand('%:t')) >= 0
      " close pane
      execute 'close'
    elseif len(filter(range(1, bufnr('$')), 'buflisted(v:val)')) > 1
      " delete buffer
      execute 'bd'
    else
      NotQuit
      execute 'Alpha'
    endif
  endfunction
  command! -nargs=* BufferClose call s:BufferClose()
]])

local alpha = require('alpha')
local dashboard = require('alpha.themes.startify')
dashboard.section.header.val = {} -- clear header art
alpha.setup(dashboard.config)

require('indent_blankline').setup {
  show_current_context = true,
  show_current_context_start = true,
}

require('hop').setup {}

require('Comment').setup {}

require('neogen').setup {
  snippet_engine = 'luasnip',
}

require('ruby_spec').setup {
  marker_directory = '.git', -- .git is commonly seen on rails project
  rspec_commands = {
    './bin/rspec',
  },
}
