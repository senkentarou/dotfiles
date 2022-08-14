function _G.git_grep_on_input_word()
  vim.api.nvim_command('Gina grep ' .. vim.fn.input('[GitGrep] '))
end

function _G.git_grep_on_current_word()
  vim.api.nvim_command('Gina grep ' .. vim.fn.expand('<cword>'))
end

-- gitsigns
require('gitsigns').setup {
  current_line_blame = true,
  current_line_blame_formatter = '-- <summary> (<author_time:%R>) [<abbrev_sha>]'
}

-- neogit
require('neogit').setup {
  integrations = {
    diffview = true
  }
}

require('gopr').setup {
  default_remote = 'upstream'
}

require('gobf').setup {
  default_remote = 'upstream'
}
