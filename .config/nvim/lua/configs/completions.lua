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

-- Disable virtual_text since it's redundant due to lsp_lines.
vim.diagnostic.config({
  update_in_insert = false,
  virtual_lines = false,
})

require('lsp_lines').setup()

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

require('lsp-colors').setup {
  Error = '#db4b4b',
  Warning = '#e0af68',
  Information = '#0db9d7',
  Hint = '#10B981',
}

require('fidget').setup {
  text = {
    spinner = 'pipe', -- animation shown when tasks are ongoing
    done = '✔', -- character shown when all tasks are complete
    commenced = 'Started', -- message shown when task starts
    completed = 'Completed', -- message shown when task completes
  },
}
