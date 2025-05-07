vim.g.mapleader = ' '
vim.g.maplocalleader = '\\'

vim.opt.mouse = ''
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.signcolumn = 'yes'
vim.opt.cursorline = true
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.shiftround = true
vim.opt.expandtab = true
-- vim.opt.cindent = true
vim.opt.scrolloff = 5
vim.opt.sidescrolloff = 5
vim.opt.hlsearch = true
vim.opt.incsearch = true
-- vim.opt.wrap = false
vim.opt.termguicolors = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.guicursor = ''

vim.g.omni_sql_no_default_maps = 1

vim.cmd.colorscheme('gruvbox-material')

--vim.g.gruvbox_material_transparent_background = 1

local lspconfig_defaults = require('lspconfig').util.default_config
lspconfig_defaults.capabilities = vim.tbl_deep_extend(
    'force',
    lspconfig_defaults.capabilities,
    require('cmp_nvim_lsp').default_capabilities()
)

-- This is where you enable features that only work
-- if there is a language server active in the file
vim.api.nvim_create_autocmd('LspAttach', {
    desc = 'LSP actions',
    callback = function(event)
        local opts = { buffer = event.buf }

        vim.keymap.set('n', 'K', '<cmd>lua vim.lsp.buf.hover()<cr>', opts)
        vim.keymap.set('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>', opts)
        vim.keymap.set('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>', opts)
        vim.keymap.set('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<cr>', opts)
        vim.keymap.set('n', 'go', '<cmd>lua vim.lsp.buf.type_definition()<cr>', opts)
        vim.keymap.set('n', 'gr', '<cmd>lua vim.lsp.buf.references()<cr>', opts)
        vim.keymap.set('n', 'gs', '<cmd>lua vim.lsp.buf.signature_help()<cr>', opts)
        vim.keymap.set('n', '<F2>', '<cmd>lua vim.lsp.buf.rename()<cr>', opts)
        vim.keymap.set({ 'n', 'x' }, '<F3>', '<cmd>lua vim.lsp.buf.format({async = true})<cr>', opts)
        vim.keymap.set('n', '<F4>', '<cmd>lua vim.lsp.buf.code_action()<cr>', opts)
        vim.keymap.set('n', 'gh', '<cmd>lua vim.diagnostic.open_float()<cr>', opts)
        vim.keymap.set('n', 'g.', '<cmd>lua vim.diagnostic.setloclist()<cr><cmd>lopen<cr>', opts)
        vim.keymap.set('n', 'g,', '<cmd>lua vim.diagnostic.setqflist()<cr><cmd>copen<cr>', opts)
    end,
})

local cmp = require('cmp')

require('cmp').setup({
    sources = {
        { name = 'nvim_lsp' },
    },
    snippet = {
        expand = function(args)
            -- You need Neovim v0.10 to use vim.snippet
            vim.snippet.expand(args.body)
        end,
    },
    mapping = cmp.mapping.preset.insert({}),
})

vim.lsp.enable('hls')

-- Open file explorer
vim.keymap.set('n', '-', '<CMD>Oil<CR>', { desc = 'Open directory (oil)' })

-- Moving whole lines
vim.keymap.set('v', 'J', ":m '>+1<CR>gv=gv")
vim.keymap.set('v', 'K', ":m '<-2<CR>gv=gv")

-- Recenter
vim.keymap.set('n', 'J', 'mzJ`z')
vim.keymap.set('n', '<C-d>', '<C-d>zz')
vim.keymap.set('n', '<C-u>', '<C-u>zz')
vim.keymap.set('n', 'n', 'nzzzv')
vim.keymap.set('n', 'N', 'Nzzzv')

-- Exiting :terminal
vim.keymap.set('t', '<Esc>', '<C-\\><C-n><CR>')

-- Telescope
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>f', builtin.find_files)
vim.keymap.set('n', '<leader>g', builtin.live_grep)
vim.keymap.set('n', '<leader>b', builtin.buffers)
vim.keymap.set('n', '<leader>z', builtin.help_tags)
vim.keymap.set('n', '<leader>h', builtin.diagnostics)

-- Clipboard
vim.keymap.set({ 'n', 'x' }, '<leader>y', [["+y]])
vim.keymap.set({ 'n', 'x' }, '<leader>p', [["+p]])
vim.keymap.set({ 'n', 'x' }, '<leader>Y', [["+Y]])
vim.keymap.set({ 'n', 'x' }, '<leader>P', [["+P]])

-- Delete without yank
vim.keymap.set({ 'n', 'x' }, '<leader>d', [["_d]], { desc = 'delete without yank' })
vim.keymap.set({ 'n', 'x' }, '<leader>x', [["_d]], { desc = 'delete without yank' })

-- Select everything quickly
vim.keymap.set('n', '<leader>a', '<Esc>ggVG', { desc = 'select all text' })

-- Write a blank line
vim.keymap.set('n', '<leader>o', 'o<Esc>')
vim.keymap.set('n', '<leader>O', 'O<Esc>')

-- Esc is too far
vim.keymap.set({ 'n', 'v', 'i' }, '<C-c>', '<Esc>', { desc = 'same as pressing esc' })

-- quickfix
vim.keymap.set('n', '<C-k>', '<cmd>cnext<CR>zz')
vim.keymap.set('n', '<C-j>', '<cmd>cprev<CR>zz')
vim.keymap.set('n', '<leader>k', '<cmd>lnext<CR>zz')
vim.keymap.set('n', '<leader>j', '<cmd>lprev<CR>zz')

-- substitute everything
vim.keymap.set('n', '<leader>s', [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]],
    { desc = 'substitute word under cursor globally on file' })

-- format this
vim.keymap.set('n', '<leader>w', '<CMD>%s/\\s\\+$//e<CR><CMD>:nohlsearch<CR>',
    { desc = 'remove trailing spaces from file' })
