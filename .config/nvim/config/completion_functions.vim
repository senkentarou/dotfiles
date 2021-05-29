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
