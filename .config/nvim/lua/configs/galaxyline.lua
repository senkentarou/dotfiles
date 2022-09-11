local gl = require("galaxyline")
local gls = gl.section

local condition = require("galaxyline.condition")
local vcs = require("galaxyline.provider_vcs")
local buffer = require("galaxyline.provider_buffer")
local fileinfo = require("galaxyline.provider_fileinfo")
local lspclient = require("galaxyline.provider_lsp")

local colors = {
  bg = '#504945',
  fg = '#bdae93',
  bright_red = '#fb4934',
  bright_green = '#b8bb26',
  bright_yellow = '#fabd2f',
  bright_blue = '#83a598',
  bright_purple = '#d3869b',
  bright_aqua = '#8ec07c',
  bright_orange = '#fe8019',
  neutral_red = '#cc241d',
  neutral_green = '#98971a',
  neutral_yellow = '#d79921',
  neutral_blue = '#458588',
  neutral_purple = '#b16286',
  neutral_aqua = '#689d6a',
  neutral_orange = '#d65d0e',
  faded_red = '#9d0006',
  faded_green = '#79740e',
  faded_yellow = '#b57614',
  faded_blue = '#076678',
  faded_purple = '#8f3f71',
  faded_aqua = '#427b58',
  faded_orange = '#af3a03',
}

local mode_map = {
  ['n'] = {'NORMAL', colors.fg, colors.bg},
  ['i'] = {'INSERT', colors.bright_blue, colors.faded_blue},
  ['R'] = {'REPLACE', colors.bright_red, colors.faded_red},
  ['v'] = {'VISUAL', colors.bright_orange, colors.faded_orange},
  ['V'] = {'V-LINE', colors.bright_orange, colors.faded_orange},
  ['c'] = {'COMMAND', colors.bright_yellow, colors.faded_yellow},
  ['s'] = {'SELECT', colors.bright_orange, colors.faded_orange},
  ['S'] = {'S-LINE', colors.bright_orange, colors.faded_orange},
  ['t'] = {'TERMINAL', colors.bright_aqua, colors.faded_aqua},
  [''] = {'V-BLOCK', colors.bright_orange, colors.faded_orange},
  ['v'] = {'S-BLOCK', colors.bright_orange, colors.faded_orange},
}

local sep = {
  right_filled = '',
  left_filled = '',
  right = '',
  left = '',
}

local function highlight(group, fg, bg)
  local cmd = string.format('highlight %s guifg=%s guibg=%s', group, fg, bg)
  vim.cmd(cmd)
end

local function is_show_dir()
  local ignore_list = {'FUGITIVE', 'HELP'}
  for _, il in pairs(ignore_list) do
    if il == buffer.get_buffer_filetype() then return false end
  end
  return true
end

gls.left = {
  {
    ViMode = {
      provider = function()
        local label, fg, nested_fg = unpack(mode_map[vim.fn.mode()])
        highlight('GalaxyViMode', colors.bg, fg)
        highlight('GalaxyViModeFront', fg, colors.bg)
        highlight('GalaxyViModeInv', fg, nested_fg)
        highlight('GalaxyViModeNested', colors.fg, nested_fg)
        highlight('GalaxyViModeInvNested', nested_fg, colors.bg)
        return string.format('  %s ', label)
      end,
      separator = sep.left_filled,
      separator_highlight = 'GalaxyViModeFront',
    }
  },
  {
    GitDir = {
      provider = function()
        local cur_git_dir = vim.fn.fnamemodify(vim.fn.fnamemodify(vim.b.git_dir, ':h'), ':t')
        if cur_git_dir == '.' then
          return ' '
        end
        return string.format(" %s ", cur_git_dir)
      end,
      condition = function()
        return condition.check_git_workspace() and is_show_dir() and condition.hide_in_width()
      end,
      highlight = {colors.fg, colors.bg},
      separator = sep.left,
      separator_highlight = {colors.fg, colors.bg},
    }
  },
  {
    FileName = {
      provider = function()
        if not condition.buffer_not_empty() then
          return ' '
        end
        local fname
        if condition.hide_in_width() then
          fname = vim.fn.fnamemodify(vim.fn.expand '%', ':~:.')
        else
          fname = vim.fn.expand '%:t'
        end
        if #fname == 0 then
          return ' '
        end
        if vim.bo.readonly then
          fname = fname .. ' ' .. '[RO]'
        end
        if vim.bo.modified then
          fname = fname .. ' ' .. '[+]'
        end
        return ' ' .. fname .. ' '
      end,
      highlight = {colors.fg, colors.bg},
    },
  },
  {
    DiffAdd = {
      provider = vcs.diff_add,
      icon = "  ",
      condition = function()
        return condition.check_git_workspace() and condition.hide_in_width()
      end,
      highlight = {colors.bright_blue, colors.bg},
    },
  },
  {
    DiffModified = {
      provider = vcs.diff_modified,
      icon = "  ",
      condition = function()
        return condition.check_git_workspace() and condition.hide_in_width()
      end,
      highlight = {colors.bright_yellow, colors.bg},
    },
  },
  {
    DiffRemove = {
      provider = vcs.diff_remove,
      icon = "  ",
      condition = function()
        return condition.check_git_workspace() and condition.hide_in_width()
      end,
      highlight = {colors.bright_red, colors.bg},
      separator = sep.left,
      separator_highlight = {colors.fg, colors.bg},
    },
  },
  {
    ShowLspClient = {
      provider = function()
        return string.format(" %s ", lspclient.get_lsp_client())
      end,
      condition = function()
        return condition.hide_in_width()
      end,
      highlight = {colors.fg, colors.bg}
    }
  },
  {
    DiagnosticError = {
      provider = 'DiagnosticError',
      icon = '  ',
      highlight = {colors.bright_red, colors.bg},
    }
  },
  {
    DiagnosticWarn = {
      provider = 'DiagnosticWarn',
      icon = '  ',
      highlight = {colors.bright_yellow, colors.bg},
    }
  },
  {
    DiagnosticHint = {
      provider = 'DiagnosticHint',
      icon = '  ',
      highlight = {colors.bright_aqua, colors.bg},
    }
  },
  {
    DiagnosticInfo = {
      provider = 'DiagnosticInfo',
      icon = '  ',
      highlight = {colors.bright_blue, colors.bg},
      separator = sep.left,
      separator_highlight = {colors.fg, colors.bg},
    }
  },
}

gls.right = {
  {
    FileTypeName = {
      provider = function()
        return string.format(' %s ', buffer.get_buffer_filetype())
      end,
      condition = function()
        return condition.hide_in_width()
      end,
      highlight = {colors.fg, colors.bg},
      separator = sep.right,
      separator_highlight = {colors.fg, colors.bg},
    }
  },
  {
    FileEncode = {
      provider = function()
        return string.format('%s ', fileinfo.get_file_encode())
      end,
      condition = function()
        return condition.hide_in_width()
      end,
      highlight = {colors.fg, colors.bg},
      separator = sep.right,
      separator_highlight = {colors.fg, colors.bg},
    }
  },
  {
    FileFormat = {
      provider = function()
        return string.format(' %s ', fileinfo.get_file_format())
      end,
      condition = function()
        return condition.hide_in_width()
      end,
      highlight = {colors.fg, colors.bg},
      separator = sep.right,
      separator_highlight = {colors.fg, colors.bg},
    }
  },
  {
    LineInfo = {
      provider = function()
        return string.format(' %s ', fileinfo.line_column())
      end,
      condition = function()
        return condition.hide_in_width()
      end,
      highlight = {colors.fg, colors.bg},
      separator = sep.right,
      separator_highlight = {colors.fg, colors.bg},
    },
  },
}

gl.short_line_list = {
  "Trouble",
  "help",
  "vim-plug",
  "startify",
}

gls.short_line_left = {
  {
    FileTypeName = {
      provider = function()
        return string.format('  %s ', buffer.get_buffer_filetype())
      end,
      highlight = {colors.fg, colors.bg},
    }
  },
  {
    FileName = {
      provider = function()
        if not condition.buffer_not_empty() then
          return ' '
        end
        local fname
        if condition.hide_in_width() then
          fname = vim.fn.fnamemodify(vim.fn.expand '%', ':~:.')
        else
          fname = vim.fn.expand '%:t'
        end
        if #fname == 0 then
          return ' '
        end
        if vim.bo.readonly then
          fname = fname .. ' ' .. '[RO]'
        end
        if vim.bo.modified then
          fname = fname .. ' ' .. '[+]'
        end
        return ' ' .. fname .. ' '
      end,
      highlight = {colors.fg, colors.bg},
    },
  },
}
