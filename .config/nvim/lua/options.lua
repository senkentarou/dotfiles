--
-- Vim options
--
vim.cmd([[ colorscheme hybrid ]])
vim.opt.undofile = true
vim.opt.cmdheight = 2
vim.opt.ignorecase = true
vim.opt.hidden = true
vim.opt.autoread = true
vim.opt.termguicolors = true
vim.opt.encoding = 'utf-8'
vim.opt.number = true
vim.opt.backspace = [[indent,eol,start]]
vim.opt.whichwrap = [[b,s,<,>,[,],h,l]]
vim.opt.cursorline = true
vim.opt.clipboard = 'unnamed'
vim.opt.completeopt = [[menuone,noinsert,noselect]]
vim.opt.shortmess:append({ c = true })
vim.opt.expandtab = true
vim.opt.smarttab = true
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 2
vim.opt.tabstop = 2
