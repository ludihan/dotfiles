vim.opt.mouse = ""

vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.cursorline = true
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.shiftround = true
vim.opt.expandtab = true
vim.opt.cindent = true

vim.opt.scrolloff = 5
vim.opt.sidescrolloff = 5

vim.opt.hlsearch = true
vim.opt.incsearch = true

-- vim.opt.wrap = false

vim.opt.termguicolors = true

vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.opt.guicursor = ""

vim.g.omni_sql_no_default_maps = 1

vim.g.gruvbox_material_transparent_background = 1

local colorscheme = "gruvbox-material"
local ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)
if not ok then
    vim.notify("colorscheme " .. colorscheme .. " not found!")
end

require('nvim-treesitter.configs').setup {
    auto_install = true,

    highlight = {
        enable = true,
    },
}

local lsp_zero = require('lsp-zero')

lsp_zero.on_attach(function(client, bufnr)
  lsp_zero.default_keymaps({buffer = bufnr})
end)

require('mason').setup({})
require('mason-lspconfig').setup({
    ensure_installed = {
        'html',
        'cssls',
        'tsserver',
        'emmet_language_server',
        'lua_ls',
        'rust_analyzer',
        'gopls',
        'templ',
        'pylsp'
    },
    handlers = {
        function(server_name)
            require('lspconfig')[server_name].setup({})
        end,
    },
})

-- Leader
vim.g.mapleader = " "

-- Open file explorer
vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })

-- Stop highlight
vim.keymap.set("n", "<leader>h", "<CMD>nohlsearch<CR>")

-- Moving whole lines
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- Recenter
vim.keymap.set("n", "J", "mzJ`z")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- Exiting :terminal
vim.keymap.set('t', '<Esc>', '<C-\\><C-n><CR>')

-- Telescope
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>f', builtin.find_files, {})
vim.keymap.set('n', '<leader>g', builtin.live_grep, {})
vim.keymap.set('n', '<leader>b', builtin.buffers, {})
vim.keymap.set('n', '<leader>z', builtin.help_tags, {})

-- Clipboard
vim.keymap.set({"n", "x"}, "<leader>y", [["+y]])
vim.keymap.set({"n", "x"}, "<leader>p", [["+p]])
vim.keymap.set({"n", "x"}, "<leader>Y", [["+Y]])
vim.keymap.set({"n", "x"}, "<leader>P", [["+P]])

-- Delete without yank
vim.keymap.set({"n", "x"}, "<leader>d", [["_d]])
vim.keymap.set({"n", "x"}, "<leader>x", [["_d]])

-- Select everything quickly
vim.keymap.set("n", "<leader>a", "<Esc>ggVG")

-- Whatever
vim.keymap.set("n", "<leader>o", "o<Esc>")
vim.keymap.set("n", "<leader>O", "O<Esc>")

-- Esc is too far
vim.keymap.set("n", "<C-c>", "<Esc>")

-- quickfix
vim.keymap.set("n", "<C-k>", "<cmd>cnext<CR>zz")
vim.keymap.set("n", "<C-j>", "<cmd>cprev<CR>zz")
vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz")
vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz")

-- dunno
vim.keymap.set("n", "Q", "<nop>")

-- substitute everything
vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

-- format this
vim.keymap.set("n", "<leader>w", ":sil %s/\\s\\+$//e<CR>:nohlsearch<CR>")
