vim.pack.add({
    'https://github.com/ellisonleao/gruvbox.nvim',
    'https://github.com/neovim/nvim-lspconfig',
    'https://github.com/stevearc/oil.nvim',
    'https://github.com/nvim-telescope/telescope.nvim',
    'https://github.com/nvim-lua/plenary.nvim',
    'https://github.com/hiphish/rainbow-delimiters.nvim',
    'https://github.com/folke/snacks.nvim',
    'https://github.com/Saghen/blink.cmp',
    'https://github.com/nvim-treesitter/nvim-treesitter',
    'https://github.com/windwp/nvim-ts-autotag',
    'https://github.com/saghen/blink.lib',
})

local ts = require('nvim-treesitter')
vim.api.nvim_create_autocmd("FileType", {
    group = vim.api.nvim_create_augroup("EnableTreesitterHighlighting", { clear = true }),
    desc = "Try to enable tree-sitter syntax highlighting",
    pattern = ts.get_available(),
    callback = function(event)
        local lang = event.match

        if ts.get_installed()[lang] == nil then
            local ok, task = pcall(ts.install, { lang }, { summary = false })
            if not ok then return end

            task:wait(300000)
        end

        ok, _ = pcall(vim.treesitter.start, event.buf, lang)
        if not ok then return end

        vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"

        -- vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
    end,
})

require('nvim-ts-autotag').setup({
    opts = {
        enable_close = true,         -- Auto close tags
        enable_rename = true,        -- Auto rename pairs of tags
        enable_close_on_slash = true -- Auto close on trailing </
    },
})

require("gruvbox").setup()
vim.cmd.colorscheme('gruvbox')

require("snacks").setup({
    bigfile = { enabled = true }
})

require("oil").setup()

require("telescope").setup({
    defaults = {
        border = false,
        layout_config = {
            width = { padding = 0 },
            height = { padding = 0 }
        },
        results_title = false,
        prompt_title = false,
        prompt_prefix = ">>> ",
        sorting_strategy = "ascending",
        layout_strategy = "bottom_pane",
    },
})


require('blink.cmp').setup({
    appearance = {
        nerd_font_variant = 'mono',
        kind_icons = {
            Text = '',
            Method = '',
            Function = '',
            Constructor = '',

            Field = '',
            Variable = '',
            Property = '',

            Class = '',
            Interface = '',
            Struct = '',
            Module = '',

            Unit = '',
            Value = '',
            Enum = '',
            EnumMember = '',

            Keyword = '',
            Constant = '',

            Snippet = '',
            Color = '',
            File = '',
            Reference = '',
            Folder = '',
            Event = '',
            Operator = '',
            TypeParameter = '',
        },
    },

    completion = { documentation = { auto_show = true } },

    sources = {
        default = { 'lsp', 'path', 'snippets', 'buffer' },
    },

    fuzzy = { implementation = "lua" }
})
