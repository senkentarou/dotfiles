" mhinz/vim-startify
lua << EOF
  vim.g.startify_custom_header = {}
  vim.g.startify_change_to_dir = 0
  vim.g.startify_update_oldfiles = 1
  vim.g.startify_lists = {
    { type = 'files', header = {'   MRU files'} },
    { type = 'dir', header = {'   MRU in ' .. vim.fn['getcwd']()} },
    { type = 'bookmarks', header = {'   Bookmarks'} },
    { type = 'commands', header = {'   Commands'} },
  }
  vim.g.startify_bookmarks = {
    { i = '~/.config/nvim/init.vim'},
    { c = '~/.config/nvim/config/completion_functions.vim'},
    { m = '~/.config/nvim/config/key_mappings.vim'},
    { z = '~/.zsh.d/.zshrc'}
  }
EOF
