--
-- Vim options
--
vim.cmd([[ colorscheme hybrid ]])
vim.opt.mouse = ""
vim.opt.undofile = true
vim.opt.cmdheight = 2
vim.opt.ignorecase = true
vim.opt.hidden = true
vim.opt.autoread = true
vim.opt.termguicolors = true
vim.opt.encoding = 'utf-8'
vim.opt.number = true
vim.opt.backspace = [[indent,eol,start]]
vim.opt.wrap = true
vim.opt.whichwrap = [[b,s,<,>,[,],h,l]]
vim.opt.cursorline = true
vim.opt.clipboard = 'unnamed'
vim.opt.completeopt = [[menuone,noinsert,noselect]]
vim.opt.shortmess:append({
  c = true,
})
vim.opt.expandtab = true
vim.opt.smarttab = true
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 2
vim.opt.tabstop = 2

local ns = vim.api.nvim_create_namespace('toggle_hlsearch')
local function toggle_hlsearch(char)
  if vim.fn.mode() == 'n' then
    local keys = {
      '<CR>',
      'n',
      'N',
      '*',
      '#',
      '?',
      '/',
    }
    local new_hlsearch = vim.tbl_contains(keys, vim.fn.keytrans(char))

    if vim.opt.hlsearch:get() ~= new_hlsearch then
      vim.opt.hlsearch = new_hlsearch
    end
  end
end

vim.on_key(toggle_hlsearch, ns)

vim.g.copilot_no_tab_map = true
vim.g.copilot_filetypes = {
  ['*'] = false,
  ruby = true,
  rspec = true,
  javascript = true,
  javascriptreact = true,
  typescript = true,
  typescriptreact = true,
  yaml = true,
  json = true,
  lua = true,
  markdown = true,
  text = true,
}
