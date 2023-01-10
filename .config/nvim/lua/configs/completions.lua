-- fidget (show starting status of language server)
require('fidget').setup {
  text = {
    spinner = 'pipe', -- animation shown when tasks are ongoing
    done = '✔', -- character shown when all tasks are complete
    commenced = 'Started', -- message shown when task starts
    completed = 'Completed', -- message shown when task completes
  },
}

-- mason (lsp server installer)
require('mason').setup {}
require('mason-lspconfig').setup {}
require('mason-tool-installer').setup {
  ensure_installed = {
    'jq',
    'bash-language-server',
    'eslint-lsp',
    'eslint_d',
    'json-lsp',
    'lua-language-server',
    'luaformatter',
    'luacheck',
    'shellcheck',
    'shfmt',
    'solargraph',
    'typescript-language-server',
    'yaml-language-server',
    'yamlfmt',
    'yamllint',
  },
}

-- lspsaga
local saga = require("lspsaga")
saga.init_lsp_saga({
  -- preview lines of lsp_finder and definition preview
  max_preview_lines = 10,
  -- use emoji lightbulb in default
  code_action_icon = "💡",
  -- if true can press number to execute the codeaction in codeaction window
  code_action_num_shortcut = true,
  -- same as nvim-lightbulb but async
  code_action_lightbulb = {
    enable = true,
    enable_in_insert = true,
    cache_code_action = true,
    sign = true,
    update_time = 800,
    sign_priority = 20,
    virtual_text = false,
  },
  finder_action_keys = {
    open = '<CR>',
    quit = '<C-q>',
  },
  code_action_keys = {
    exec = '<CR>',
    quit = '<C-q>',
  },
  definition_action_keys = {
    edit = 'e',
    quit = '<C-q>',
  },
  rename_action_quit = '<C-q>',
  rename_in_select = true,
})

-- nvim-lspconfig: use diagnostics and formatting for ruby/rspec and nvim-compe nvim_lsp setting to auto import on typescriptreact
local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())
local nvim_lsp = require('lspconfig')
local nvim_lsp_config = require('lspconfig.configs')

-- For ruby (needs ruby-lsp gem on your development)
nvim_lsp_config.ruby_lsp = {
  default_config = {
    cmd = {
      'bundle',
      'exec',
      'ruby-lsp',
    },
    init_options = {
      enabledFeatures = {
        'formatting',
        'codeActions',
      },
    },
    filetypes = {
      'ruby',
      'rspec',
    },
    root_dir = require('lspconfig.util').root_pattern('Gemfile', '.git'),
  },
}
nvim_lsp.ruby_lsp.setup {
  capabilities = capabilities,
}

nvim_lsp.solargraph.setup {
  cmd = {
    'solargraph',
    'stdio',
  },
  init_options = {
    formatting = false,
  },
  filetypes = {
    'ruby',
    'rspec',
  },
  root_dir = require('lspconfig.util').root_pattern('Gemfile', '.git'),
  settings = {
    solargraph = {
      diagnostics = true,
    },
  },
  capabilities = capabilities,
}

nvim_lsp.sumneko_lua.setup {
  capabilities = capabilities,
  root_dir = require('lspconfig.util').root_pattern('.luarc.json', '.git'),
  settings = {
    Lua = {
      runtime = {
        -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
        version = 'LuaJIT',
      },
      diagnostics = {
        -- Get the language server to recognize the `vim` global
        globals = {
          'vim',
        },
      },
      workspace = {
        -- Make the server aware of Neovim runtime files
        library = vim.api.nvim_get_runtime_file("", true),
      },
      -- Do not send telemetry data containing a randomized but unique identifier
      telemetry = {
        enable = false,
      },
    },
  },
  on_attach = function(client)
    client.server_capabilities.documentFormattingProvider = false
  end,
}

nvim_lsp.bashls.setup {}
nvim_lsp.yamlls.setup {}
nvim_lsp.jsonls.setup {}

-- null-ls: use diagnostics and formatting for js/ts/jsx/tsx
--   prettier: use for formatting
--   eslint: use for diagnostics (formatting is delegated to prettier)
-- see: https://zenn.dev/ryusou/articles/nodejs-prettier-eslint2021 and official documentation
local null_ls = require('null-ls')
local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
null_ls.setup {
  root_dir = require('lspconfig.util').root_pattern('package.json', '.git'),
  sources = {
    null_ls.builtins.diagnostics.eslint_d.with {
      filetypes = {
        'javascript',
        'javascriptreact',
        'typescript',
        'typescriptreact',
      },
      prefer_local = 'node_modules/.bin',
    },
    null_ls.builtins.formatting.prettier.with {
      filetypes = {
        'javascript',
        'javascriptreact',
        'typescript',
        'typescriptreact',
      },
      prefer_local = 'node_modules/.bin',
    },
    null_ls.builtins.formatting.lua_format.with {
      args = {
        '--column-limit=180',
        '--column-table-limit=20',
        '--indent-width=2',
        '--continuation-indent-width=2',
        '--no-keep-simple-control-block-one-line',
        '--no-keep-simple-function-one-line',
        '--spaces-inside-table-braces',
        '--chop-down-table',
        '--chop-down-kv-table',
        '--extra-sep-at-table-end',
      },
    },
    null_ls.builtins.formatting.shfmt,
    null_ls.builtins.code_actions.shellcheck,
    null_ls.builtins.diagnostics.yamllint,
    null_ls.builtins.formatting.yamlfmt,
    null_ls.builtins.formatting.jq,
    require('typescript.extensions.null-ls.code-actions'),
  },
}

-- null-ls typescript integration
require('typescript').setup({
  disable_commands = false, -- prevent the plugin from creating Vim commands
  debug = false, -- enable debug logging for commands
  go_to_source_definition = {
    fallback = true, -- fall back to standard LSP definition on failure
  },
  server = { -- pass options to lspconfig's setup method
    -- filetypes = {'typescript', 'typescript.tsx', 'typescriptreact'}
    settings = {
      documentFormatting = false,
    },
    capabilities = capabilities,
    on_attach = function(client)
      client.server_capabilities.documentFormattingProvider = false
    end,
  },
})

-- lsp-colors
require('lsp-colors').setup {
  Error = '#db4b4b',
  Warning = '#e0af68',
  Information = '#0db9d7',
  Hint = '#10B981',
}

-- lsp-lines
require('lsp_lines').setup()

-- actions-preview
require('actions-preview').setup {
  -- options for vim.diff(): https://neovim.io/doc/user/lua.html#vim.diff()
  diff = {
    algorithm = 'patience',
    ignore_whitespace = true,
  },
  backend = {
    'telescope',
  },
  telescope = {
    width = '100%',
    height = '100%',
  },
}

-- Disable virtual_text since it's redundant due to lsp_lines.
vim.diagnostic.config({
  update_in_insert = false,
  virtual_lines = false,
})

-- trouble
require('trouble').setup {
  position = 'bottom',
  height = 10,
  width = 50,
  icons = true,
  fold_open = '',
  fold_closed = '',
  action_keys = {
    close = 'q',
    cancel = '<esc>',
    jump = {
      '<cr>',
      '<tab>',
    },
    hover = 'K',
    previous = 'k',
    next = 'j',
  },
  indent_lines = true,
  auto_open = false,
  auto_close = true,
  auto_preview = true,
  auto_fold = false,
  signs = {
    error = '',
    warning = '',
    hint = '',
    information = '',
    other = '﫠',
  },
  use_diagnostic_signs = true,
}

-- nvim-compe
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
        path = '[Path]',
      },
    }),
  },
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  window = {
    documentation = {
      border = {
        '╭',
        '─',
        '╮',
        '│',
        '╯',
        '─',
        '╰',
        '│',
      },
    },
  },
  mapping = cmp.mapping.preset.insert({
    ['<CR>'] = cmp.mapping.confirm({
      select = false,
    }),
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
    end, { 'i', 's' }),
    ['<S-Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      else
        fallback()
      end
    end, { 'i', 's' }),
  }),
  sources = cmp.config.sources({
    {
      name = 'buffer',
    },
    {
      name = 'nvim_lsp',
    },
    {
      name = 'nvim_lsp_signature_help',
    },
    {
      name = 'nvim_lua',
    },
    {
      name = 'luasnip',
    },
    { name = 'path' },
  }, {
    {
      name = 'buffer',
    },
  }),
})

cmp.setup.cmdline(':', {
  mapping = cmp.mapping.preset.cmdline(),
  sources = {
    {
      name = 'cmdline',
    },
  },
})

cmp.setup.cmdline('/', {
  mapping = cmp.mapping.preset.cmdline(),
  sources = {
    {
      name = 'buffer',
    },
  },
})

-- If you want insert `(` after select function or method item
cmp.event:on('confirm_done', require('nvim-autopairs.completion.cmp').on_confirm_done())

-- luasnip
-- load from friendly-snippets
-- https://github.com/L3MON4D3/LuaSnip
require('luasnip.loaders.from_vscode').lazy_load()

-- tree-sitter
require('nvim-treesitter.configs').setup {
  autoload = {
    enable = true,
    require('nvim-ts-autotag').setup({
      enable_rename = false,
      filetypes = {
        'html',
        'xml',
        'tsx',
        'typescript',
        'typescriptreact',
      },
    }),
  },
  ensure_installed = {
    'help',
    'ruby',
    'html',
    'lua',
    'typescript',
    'javascript',
    'tsx',
    'vim',
    'markdown',
    'bash',
  },
  highlight = {
    enable = true,
  },
  matchup = {
    enable = true,
  },
  endwise = {
    enable = true,
  },
}

-- auto-pairs
require("nvim-autopairs").setup {}
