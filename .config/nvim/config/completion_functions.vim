" fidget (show starting status of language server)
lua << EOF
  require('fidget').setup {}
EOF

" nvim-lsp-installer
lua << EOF
  require('nvim-lsp-installer').setup {}
EOF

" nvim-lspconfig: use diagnostics and formatting for ruby/rspec and nvim-compe nvim_lsp setting to auto import on typescriptreact
lua << EOF
  local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
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
  nvim_lsp.ruby_lsp.setup {
    capabilities = capabilities
  }

  -- For nvim-compe nvim_lsp setting to auto import on typescriptreact
  nvim_lsp.tsserver.setup{
    -- filetypes = {'typescript', 'typescript.tsx', 'typescriptreact'}
    settings = { documentFormatting = false },
    capabilities = capabilities
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
  local cmp = require('cmp')
  local luasnip = require('luasnip')
  local has_words_before = function()
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
  end

  cmp.setup({
    formatting = {
      format = require('lspkind').cmp_format({
        with_text = true,
        menu = {
          buffer = '[Buf]',
          nvim_lsp = '[LSP]',
          nvim_lua = '[API]',
          luasnip = '[Snip]',
          path = '[PATH]',
        },
      }),
    },
    snippet = {
      expand = function(args)
        luasnip.lsp_expand(args.body)
      end

    },
    window = {
      documentation = {
        border = { '╭', '─', '╮', '│', '╯', '─', '╰', '│' },
      },
    },
    mapping = cmp.mapping.preset.insert({
      ['<CR>'] = cmp.mapping.confirm({ select = true }),
      ['<C-c>'] = cmp.mapping.abort(),
      ['<Tab>'] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_next_item()
        elseif luasnip.expand_or_jumpable() then
          luasnip.expand_or_jump()
        elseif has_words_before() then
          cmp.complete()
        else
          fallback()
        end
      end, {'i', 's'}),
      ['<S-Tab>'] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_prev_item()
        else
          fallback()
        end
      end, {'i', 's'}),
    }),
    sources = cmp.config.sources({
      { name = 'buffer' },
      { name = 'nvim_lsp' },
      { name = 'nvim_lsp_signature_help' },
      { name = 'nvim_lua' },
      { name = 'luasnip' },
      { name = 'path' },
    }, {
      { name = 'buffer' },
    }),
  })

  cmp.setup.cmdline(':', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
      { name = 'cmdline' }
    }
  })

  cmp.setup.cmdline('/', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
      { name = 'buffer' }
    }
  })

  -- If you want insert `(` after select function or method item
  cmp.event:on(
    'confirm_done',
    require('nvim-autopairs.completion.cmp').on_confirm_done()
  )
EOF

" luasnip
lua <<EOF
  -- local ls = require('luasnip')

  -- load from friendly-snippets
  -- https://github.com/L3MON4D3/LuaSnip
  require('luasnip.loaders.from_vscode').lazy_load()
EOF

" tree-sitter
lua <<EOF
  require('nvim-treesitter.configs').setup {
    autoload = {
      enable = true,
      require('nvim-ts-autotag').setup({
        filetypes = { 'html', 'xml', 'tsx', 'typescript', 'typescriptreact' }
      })
    },
    highlight = {
      enable = true
    },
    matchup = {
      enable = true
    },
  }
EOF

" auto-pairs
lua << EOF
  require("nvim-autopairs").setup {}
EOF
