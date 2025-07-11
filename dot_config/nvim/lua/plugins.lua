-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    local lazyrepo = "https://github.com/folke/lazy.nvim.git"
    local out = vim.fn.system(
        { "git", "clone", "--filter=blob:none", "--branch=stable",
            lazyrepo,
            lazypath
        }
    )
    if vim.v.shell_error ~= 0 then
        vim.api.nvim_echo({
            { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
            { out,                            "WarningMsg" },
            { "\nPress any key to exit..." },
        }, true, {})
        vim.fn.getchar()
        os.exit(1)
    end
end
vim.opt.rtp:prepend(lazypath)

-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Setup lazy.nvim
require("lazy").setup({
    -- LSP Stuff
    { 'neovim/nvim-lspconfig' },
    { 'hrsh7th/cmp-nvim-lsp' },
    { 'hrsh7th/nvim-cmp' },
    {
        'williamboman/mason.nvim',
        config = true,
    },
    {
        'williamboman/mason-lspconfig.nvim',
        opts = {
            ensure_installed = {
                'cssls',
                'emmet_language_server',
                'gopls',
                -- 'hls',
                'html',
                'lua_ls',
                'pylsp',
                -- 'rust_analyzer',
                -- 'bacon-ls',
                'taplo',
                'templ',
                'ts_ls',
                'bashls',
                'jsonls',
                'dockerls',
                'docker_compose_language_service',
                --'clangd',
                'ruff',
                'pyright',
                'yamlls',
            },
            handlers = {
                function(server_name)
                    require('lspconfig')[server_name].setup({})
                end,
            },
        },
    },

    -- Themes
    { 'sainnhe/gruvbox-material' },
    { 'HiPhish/rainbow-delimiters.nvim' },

    --Telescope
    {
        'nvim-telescope/telescope.nvim',
        tag = '0.1.8',
        dependencies = { 'nvim-lua/plenary.nvim' },
        opts = {
            defaults = {
                border = false,
                layout_config = {
                    width = { padding = 0 },
                    height = { padding = 0 }
                },
                results_title = false,
                prompt_title = false,
                prompt_prefix = '>>> ',
                sorting_strategy = 'ascending',
                layout_strategy = "bottom_pane",
            },
        },
    },
    {
        'nvim-treesitter/nvim-treesitter',
        build = ':TSUpdate',
        config = function()
            require('nvim-treesitter.configs').setup({
                auto_install = true,

                highlight = {
                    enable = true,
                },
                indent = {
                    enable = true,
                },
            })
        end,
    },
    --{
    --'windwp/nvim-autopairs',
    --event = 'InsertEnter',
    --config = true,
    --},
    {
        'windwp/nvim-ts-autotag',
        config = true,
    },
    {
        'stevearc/oil.nvim',
        config = true,
    },
    {
        'LunarVim/bigfile.nvim',
        config = true,
    },
})
