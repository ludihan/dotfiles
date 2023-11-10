vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

vim.opt.mouse = ""

vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.cursorline = true
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.shiftround = true
vim.opt.expandtab = true
vim.opt.smartindent = true

vim.opt.scrolloff = 10
vim.opt.sidescrolloff = 10

vim.opt.hlsearch = true
vim.opt.incsearch = true

vim.opt.wrap = false

vim.opt.termguicolors = true

vim.api.nvim_create_autocmd({ "BufWritePre" }, {
    pattern = { "*" },
    command = ":%s/\\s\\+$//e",
})

if vim.g.neovide then
    vim.o.guifont = "Hack Nerd Font:h8"
end

local colorscheme = "kanagawa-dragon"
local ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)
if not ok then
    vim.notify("colorscheme " .. colorscheme .. " not found!")
    return
end

require('nvim-treesitter.configs').setup {
    ensure_installed = { "c", "lua", "vim", "vimdoc", "query", "go" },

    sync_install = false,

    auto_install = true,

    highlight = {
        enable = true,
    },
}

local lsp_zero = require('lsp-zero')

lsp_zero.on_attach(function(client, bufnr)
    -- see :help lsp-zero-keybindings
    -- to learn the available actions
    lsp_zero.default_keymaps({ buffer = bufnr })
end)

require('mason').setup({})
require('mason-lspconfig').setup({
    ensure_installed = {},
    handlers = {
        lsp_zero.default_setup,
    },
})

-- nvimtree
require("nvim-tree").setup({
    view = {
        width = {},
        float = {
            enable = true,
            quit_on_focus_loss = true,
            open_win_config = {
                border = "solid",
            },
        },
    },
    actions = {
        open_file = {
            window_picker = {
                enable = false
            }
        }
    }
})

-- html
require('nvim-ts-autotag').setup()

-- remaps
vim.g.mapleader = " "
local api = require("nvim-tree.api")
vim.keymap.set("n", "<leader>e", api.tree.toggle)

vim.keymap.set("n", "<leader>h", "<CMD>nohlsearch<CR>")

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

vim.keymap.set('t', '<Esc>', '<C-\\><C-n><CR>')

local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})

--clipboard
vim.keymap.set({"n", "v"}, "<leader>y", [["+y]])
vim.keymap.set({"n", "v"}, "<leader>p", [["+p]])
vim.keymap.set({"n", "v"}, "<leader>Y", [["+Y]])
vim.keymap.set({"n", "v"}, "<leader>P", [["+P]])

--delete without yank
vim.keymap.set({"n", "v"}, "<leader>d", [["_d]])
vim.keymap.set({"n", "v"}, "<leader>x", [["_d]])

--select everything quickly
vim.keymap.set("n", "<leader>a", "<Esc>ggVG")

vim.keymap.set("n", "<leader>o", "o<Esc>")
vim.keymap.set("n", "<leader>O", "O<Esc>")

vim.keymap.set("n", "<C-c>", "<Esc>")
