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
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = "<CR>",
      node_incremental = "<CR>",
      scope_incremental = "<S-CR>",
      node_decremental = "<BS>",
    },
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

require("nvim-autopairs").setup {}

require("symbols-outline").setup {}
