vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

vim.opt.mouse = ""

vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.opt.synmaxcol = 300
vim.opt.updatetime = 300
vim.opt.redrawtime = 10000
vim.opt.maxmempattern = 20000

vim.o.background = "dark"

--vim.opt.smartindent = true
--vim.opt.autoindent = true
--vim.opt.cindent = true

vim.filetype.add({
  extension = {
    env = "dotenv",
  },
  filename = {
    [".env"] = "dotenv",
    ["env"] = "dotenv",
  },
  pattern = {
    ["[jt]sconfig.*.json"] = "jsonc",
    ["%.env%.[%w_.-]+"] = "dotenv",
  },
})

vim.opt.signcolumn = "yes"
vim.opt.cursorline = true
vim.opt.colorcolumn = "80"

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.shiftround = true
vim.opt.expandtab = true

vim.opt.scrolloff = 5
vim.opt.sidescrolloff = 5
vim.opt.hlsearch = true
vim.opt.incsearch = true
-- vim.opt.wrap = false
vim.opt.termguicolors = true
vim.opt.guicursor = "i:block"

vim.g.omni_sql_no_default_maps = 1
vim.opt.completeopt = { "menuone", "popup", "noinsert" }
