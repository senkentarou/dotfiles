" nvim-lsp-installer
lua << EOF
  require("nvim-lsp-installer").setup {}
EOF

" nvim-lspconfig: use diagnostics and formatting for ruby/rspec and nvim-compe nvim_lsp setting to auto import on typescriptreact
lua << EOF
  local nvim_lsp = require('lspconfig')
  local nvim_lsp_config = require('lspconfig.configs')

  -- For ruby (needs ruby-lsp gem on your development)
  nvim_lsp_config.ruby_lsp = {
    default_config = {
      cmd = { 'bundle', 'exec', 'ruby-lsp' },
      init_options = {
        enabledFeatures = { 'formatting', 'codeActions' },
      },
      filetypes = { 'ruby', 'rspec' },
      root_dir = require('lspconfig.util').root_pattern('Gemfile', '.git'),
    },
  }
  nvim_lsp.ruby_lsp.setup {}

  -- For nvim-compe nvim_lsp setting to auto import on typescriptreact
  nvim_lsp.tsserver.setup{
    -- filetypes = {'typescript', 'typescript.tsx', 'typescriptreact'}
    settings = { documentFormatting = false }
  }
EOF

" null-ls: use diagnostics and formatting for js/ts/jsx/tsx
"   prettier: use for formatting
"   eslint: use for diagnostics (formatting is delegated to prettier)
" see: https://zenn.dev/ryusou/articles/nodejs-prettier-eslint2021 and official documentation
lua << EOF
  local null_ls = require('null-ls')
  null_ls.setup {
    root_dir = require('lspconfig.util').root_pattern('package.json', '.git'),
    sources = {
      null_ls.builtins.diagnostics.eslint_d,
      null_ls.builtins.formatting.prettier.with {
        filetypes = { 'javascript', 'javascriptreact', 'typescript', 'typescriptreact' },
        prefer_local = 'node_modules/.bin'
      }
    }
  }
EOF

" lsp-colors
lua << EOF
  require('lsp-colors').setup{
    Error = '#db4b4b',
    Warning = '#e0af68',
    Information = '#0db9d7',
    Hint = '#10B981'
  }
EOF

" trouble
lua << EOF
  require('trouble').setup{
    position = 'bottom',
    height = 10,
    width = 50,
    icons = true,
    fold_open = '',
    fold_closed = '',
    action_keys = {
      close = 'q',
      cancel = '<esc>',
      refresh = 'r',
      jump = {'<cr>','<tab>'},
      jump_close = {'o'},
      toggle_mode = 'm',
      toggle_preview = 'P',
      hover = 'K',
      preview = 'p',
      close_folds = {'zM','zm'},
      open_folds = {'zR','zr'},
      toggle_fold = {'zA','za'},
      previous = 'k',
      next = 'j'
    },
    indent_lines = true,
    auto_open = false,
    auto_close = false,
    auto_preview = true,
    auto_fold = false,
    signs = {
      error = '',
      warning = '',
      hint = '',
      information = '',
      other = '﫠'
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

" tree-sitter
lua <<EOF
  require('nvim-treesitter.configs').setup {
    highlight = {
      enable = true
    }
  }
EOF
