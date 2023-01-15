local telescope = require("telescope")
local actions = require("telescope.actions")
local file_browser_actions = telescope.extensions.file_browser.actions

telescope.setup {
  defaults = {
    mappings = {
      i = {
        ["<Up>"] = actions.cycle_history_prev,
        ["<Down>"] = actions.cycle_history_next,
        ["<C-k>"] = actions.move_selection_previous,
        ["<C-j>"] = actions.move_selection_next,
        ["<C-a>"] = function()
          vim.cmd ":norm! I"
        end,
        ["<C-e>"] = function()
          vim.cmd ":norm! D"
        end,
        ["<C-q>"] = actions.close,
        ["<C-f>"] = actions.which_key,
        ["<C-u>"] = false,
      },
      n = {
        ["<C-q>"] = actions.close,
      },
    },
    color_devicons = true,
    set_env = {
      ["COLORTERM"] = "truecolor",
    },
    initial_mode = "insert",
    selection_strategy = "reset",
    sorting_strategy = "ascending",
    layout_strategy = "horizontal",
    layout_config = {
      horizontal = {
        prompt_position = "top",
        preview_width = 0.55,
        results_width = 0.8,
      },
      vertical = {
        mirror = false,
      },
      width = 0.87,
      height = 0.80,
      preview_cutoff = 120,
    },
  },
  vimgrep_arguments = {
    "rg",
    "--column",
    "--hidden",
    "--line-number",
    "--no-heading",
    "--color=always",
    "--smart-case",
    "--with-filename",
    "--trim",
  },
  pickers = {
    find_files = {
      cwd = vim.fn.systemlist("git rev-parse --show-toplevel")[1],
      find_command = {
        'rg',
        '--files',
        '--hidden',
      },
      file_ignore_patterns = {
        'node_modules',
        '.git/',
      },
    },
    live_grep = {
      cwd = vim.fn.systemlist("git rev-parse --show-toplevel")[1],
      glob_pattern = '!.git/*/**',
      additional_args = function()
        return {
          '--hidden',
        }
      end,
    },
    grep_string = {
      cwd = vim.fn.systemlist("git rev-parse --show-toplevel")[1],
      additional_args = function()
        return {
          '--hidden',
        }
      end,
    },
  },
  extensions = {
    file_browser = {
      hijack_netrw = true,
      path = "%:p:h",
      cwd = vim.fn.expand("%:p:h"),
      respect_gitignore = false,
      hidden = true,
      grouped = true,
      all_previewer = true,
      select_buffer = true,
      hide_parent_dir = true,
      mappings = {
        n = {
          ["f"] = false,
          ["w"] = actions.which_key,
          ["r"] = file_browser_actions.rename,
          ["m"] = file_browser_actions.move,
          ["y"] = file_browser_actions.copy,
          ["d"] = file_browser_actions.remove,
          ["N"] = file_browser_actions.create,
          ["h"] = file_browser_actions.goto_parent_dir,
          ["o"] = actions.select_default,
          ["l"] = actions.select_default,
          ["<C-q>"] = actions.close,
        },
        i = {
          ["<C-q>"] = actions.close,
          ["<C-w>"] = actions.which_key,
          ["<C-r>"] = file_browser_actions.rename,
          ["<C-m>"] = file_browser_actions.move,
          ["<C-y>"] = file_browser_actions.copy,
          ["<C-d>"] = file_browser_actions.remove,
          ["<C-h>"] = file_browser_actions.goto_parent_dir,
          ["<C-o>"] = actions.select_default,
          ["<C-l>"] = actions.select_default,
        },
      },
    },
  },
}

telescope.load_extension("file_browser")
telescope.load_extension("gh_pr")
