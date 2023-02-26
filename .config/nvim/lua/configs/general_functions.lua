local alpha = require('alpha')
local dashboard = require('alpha.themes.startify')
dashboard.section.header.val = {} -- clear header art
dashboard.section.mru.val = {}
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
