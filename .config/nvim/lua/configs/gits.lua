function _G.git_grep_on_input_word()
  vim.api.nvim_command('Gina grep ' .. vim.fn.input('[GitGrep] '))
end

function _G.git_grep_on_current_word()
  vim.api.nvim_command('Gina grep ' .. vim.fn.expand('<cword>'))
end

-- gitsigns
require('gitsigns').setup {
  current_line_blame = true,
  current_line_blame_formatter = '-- <summary> (<author_time:%R>) [<abbrev_sha>]',
}

local actions = require("diffview.actions")
require("diffview").setup({
  keymaps = {
    disable_defaults = false, -- Disable the default keymaps
    file_history_panel = {
      {
        "n",
        "j",
        actions.select_next_entry,
      },
      {
        "n",
        "<down>",
        actions.select_next_entry,
      },
      {
        "n",
        "k",
        actions.select_prev_entry,
      },
      {
        "n",
        "<up>",
        actions.select_prev_entry,
      },
      {
        "n",
        "<cr>",
        actions.select_entry,
      },
      {
        "n",
        "o",
        actions.select_entry,
      },
      {
        "n",
        "<tab>",
        actions.next_entry,
      },
      {
        "n",
        "<s-tab>",
        actions.prev_entry,
      },
    },
  },
})

require('gopr').setup {
  default_remote = 'upstream',
}

require('gobf').setup {
  default_remote = 'upstream',
  default_branches = {
    'main',
    'master',
    'develop',
  },
}
