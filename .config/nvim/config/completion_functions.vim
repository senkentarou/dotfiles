" nvim-lspconfig
lua << EOF
local nvim_lsp = require "lspconfig"

nvim_lsp.yamlls.setup{}
nvim_lsp.tsserver.setup{
  -- filetypes = {'typescript', 'typescript.tsx', 'typescriptreact'}
  settings = {documentFormatting = false}
}
nvim_lsp.solargraph.setup{
  init_options = {codeAction = false},
  filetypes = {"ruby", "rakefile", "rspec"},
  settings = {
    solargraph = {
      completion = true,
      diagnostic = false,
      folding = true,
      references = true,
      rename = true,
      symbols = true
    }
  }
}

-- efm
local eslint = {
  lintCommand = "eslint_d -f unix --stdin --stdin-filename ${INPUT}",
  lintIgnoreExitCode = true,
  lintStdin = true,
  lintFormats = {"%f:%l:%c: %m"},
  formatCommand = "eslint_d --fix ${INPUT}",
  formatStdin = true
}

-- If you get warning or error on rubocop setup,
-- please confirm rubocop version and install its correct version
local rubocop = {
  formatCommand = "rubocop-daemon exec ${INPUT} --auto-correct",
  formatStdin = true
}

nvim_lsp.efm.setup {
  init_options = {documentFormatting = true, codeAction = false},
  filetypes = {"javascript", "javascriptreact", "typescript", "typescriptreact", "ruby", "rspec"},
  settings = {
    rootMarkers = {".git/"},
    languages = {
      javascript = {
        eslint
      },
      javascriptreact = {
        eslint
      },
      typescript = {
        eslint
      },
      typescriptreact = {
        eslint
      },
      ruby = {
        rubocop
      },
      rspec = {
        rubocop
      }
    }
  }
}
EOF

" lsp-colors
lua << EOF
  require("lsp-colors").setup{
    Error = "#db4b4b",
    Warning = "#e0af68",
    Information = "#0db9d7",
    Hint = "#10B981"
  }
EOF

" trouble
lua << EOF
  require("trouble").setup{
    position = "bottom",
    height = 10,
    width = 50,
    icons = true,
    mode = "lsp_workspace_diagnostics",
    fold_open = "",
    fold_closed = "",
    action_keys = {
      close = "q",
      cancel = "<esc>",
      refresh = "r",
      jump = {"<cr>","<tab>"},
      jump_close = {"o"},
      toggle_mode = "m",
      toggle_preview = "P",
      hover = "K",
      preview = "p",
      close_folds = {"zM","zm"},
      open_folds = {"zR","zr"},
      toggle_fold = {"zA","za"},
      previous = "k",
      next = "j"
    },
    indent_lines = true,
    auto_open = false,
    auto_close = false,
    auto_preview = true,
    auto_fold = false,
    signs = {
      error = "",
      warning = "",
      hint = "",
      information = "",
      other = "﫠"
    },
    use_lsp_diagnostic_signs = false
  }
EOF

" nvim-compe
lua << EOF
require('compe').setup {
  enabled = true;
  autocomplete = true;
  debug = false;
  min_length = 1;
  preselect = 'enable';
  throttle_time = 80;
  source_timeout = 200;
  incomplete_delay = 400;
  max_abbr_width = 100;
  max_kind_width = 100;
  max_menu_width = 100;
  documentation = true;
  source = {
    path = true;
    buffer = true;
    calc = true;
    nvim_lsp = true;
    nvim_lua = true;
    vsnip = true;
  };
}
EOF
