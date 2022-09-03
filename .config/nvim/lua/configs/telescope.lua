local telescope = require("telescope")
local actions = require("telescope.actions")

telescope.setup {
  defaults = {
    mappings = {
      i = {
        ["<C-a>"] = function() vim.cmd ":norm! I" end,
        ["<C-e>"] = function() vim.cmd ":norm! D" end,
        ["<C-u>"] = function() vim.cmd ":norm! c0" end,
        ["<C-q>"] = actions.close,
        ["<C-f>"] = actions.which_key,
        ["<C-u>"] = false,
      },
      n = {
        ["<C-q>"] = actions.close,
      },
    },
    color_devicons = true,
    set_env = { ["COLORTERM"] = "truecolor" }, -- default = nil, },
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
      find_command = { 'rg', '--files', '--hidden' },
      file_ignore_patterns = { 'node_modules', '.git/' },
    },
    live_grep = {
      cwd = vim.fn.systemlist("git rev-parse --show-toplevel")[1],
      glob_pattern = '!.git/*/**',
      additional_args = function(opts)
        return { '--hidden' }
      end,
    },
    grep_string = {
      cwd = vim.fn.systemlist("git rev-parse --show-toplevel")[1],
      additional_args = function(opts)
        return { '--hidden' }
      end,
    },
  },
}

telescope.load_extension('gh')
