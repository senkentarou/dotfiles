" nvim-lspconfig
lua << EOF
require'lspconfig'.tsserver.setup{}
require'lspconfig'.yamlls.setup{}
require'lspconfig'.solargraph.setup{
  filetypes = {"ruby", "rakefile"},
  settings = {
    solargraph = {
      completion = true,
      diagnostic = true,
      folding = true,
      references = true,
      rename = true,
      symbols = true
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
require'compe'.setup {
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
