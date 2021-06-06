" mhinz/vim-startify
let g:startify_custom_header = []
let g:startify_lists = [
  \ { 'type': 'files', 'header': ['   MRU files']            },
  \ { 'type': 'dir', 'header': ['   MRU in '. getcwd()] },
  \ { 'type': 'bookmarks', 'header': ['   Bookmarks']      },
  \ { 'type': 'commands', 'header': ['   Commands']       },
  \ ]
let g:startify_bookmarks = [ {'c': '~/.config/nvim/init.vim'}, {'m': '~/.config/nvim/config/key_mappings.vim'} ]
