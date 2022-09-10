-- vfiler
local action = require('vfiler/action')
require('vfiler/config').setup {
  options = {
    auto_cd = false,
    auto_resize = true,
    show_hidden_files = true,
    layout = 'floating',
    blend = 20,
    width = 150,
    name = 'explorer',
    columns = 'indent,icon,name,git,mode,size,time',
    session = 'none',
    keep = false,
    git = {
      enabled = true,
      ignored = true,
      untracked = true,
    },
    preview = {
      layout = 'floating',
    },
  },
  mappings = {
    ['.'] = action.toggle_show_hidden,
    ['q'] = action.quit,
    ['c'] = action.copy_to_filer,
    ['d'] = action.delete,
    ['m'] = action.move_to_filer,
    ['p'] = action.paste,
    ['r'] = action.rename,
    ['h'] = action.close_tree_or_cd,
    ['j'] = action.loop_cursor_down,
    ['k'] = action.loop_cursor_up,
    ['l'] = action.open_tree,
    ['y'] = action.yank_path,
    ['o'] = action.open,
    ['N'] = action.new_file,
    ['J'] = action.jump_to_directory,
    ['K'] = action.new_directory,
    ['<CR>'] = action.open,
    ['<C-p>'] = action.toggle_preview,
    ['<S-Space>'] = function(vfiler, context, view)
      action.toggle_select(vfiler, context, view)
      action.move_cursor_up(vfiler, context, view)
    end,
    ['<Space>'] = function(vfiler, context, view)
      action.toggle_select(vfiler, context, view)
      action.move_cursor_down(vfiler, context, view)
    end,
  },
}
