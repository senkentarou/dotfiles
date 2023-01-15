vim.cmd([[
  command! NotQuit :bp | :sp | :bn | :bd

  " bd or q command
  function! s:BufferClose() abort
    if &filetype == 'startify'
      " no action
      :
    elseif index(['DiffviewFileHistory'], &filetype) >= 0
      " close diffview history
      execute 'DiffviewClose'
    elseif index(['help', 'vim-plug'], &filetype) >= 0 || index(['[Command Line]'], expand('%:t')) >= 0
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
]])

-- indent setting
require('indent_blankline').setup {
  -- for example, context is off by default, use this to turn it on
  show_current_context = true,
  show_current_context_start = true,
}

-- hop
require('hop').setup {}

-- Comment
require('Comment').setup {}

-- Annotation
require('neogen').setup {
  snippet_engine = 'luasnip',
}

-- ruby_spec
require('ruby_spec').setup {
  marker_directory = '.git', -- .git is commonly seen on rails project
  rspec_commands = {
    './bin/rspec',
  },
}
