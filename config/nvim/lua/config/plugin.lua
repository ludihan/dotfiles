vim.pack.add({
    'https://github.com/ellisonleao/gruvbox.nvim',
    'https://github.com/neovim/nvim-lspconfig',
    'https://github.com/stevearc/oil.nvim',
    'https://github.com/nvim-telescope/telescope.nvim',
    'https://github.com/nvim-lua/plenary.nvim',
    'https://github.com/hiphish/rainbow-delimiters.nvim',
    'https://github.com/folke/snacks.nvim',
    'https://github.com/nvim-treesitter/nvim-treesitter',
    'https://github.com/windwp/nvim-ts-autotag',
})

local ts = require('nvim-treesitter')
local installed_langs = {}
for _, v in ipairs(ts.get_installed()) do
    installed_langs[v] = true
end


vim.api.nvim_create_autocmd("FileType", {
    group = vim.api.nvim_create_augroup("EnableTreesitterHighlighting", { clear = true }),
    desc = "Try to enable tree-sitter syntax highlighting",
    pattern = ts.get_available(),
    callback = function(event)
        local lang = event.match
        if not installed_langs[lang] then
            local choice = vim.fn.confirm("Treesitter parser for " .. lang .. " not found, do you want to install it?",
                "&Yes\n&No")
            if choice == 0 then return end
            if choice == 1 or choice == 2 then
                if choice == 2 then
                    installed_langs[lang] = true
                    return
                end
            end

            local ok, task = pcall(ts.install, { lang }, { summary = false })
            if not ok then return end
            installed_langs[lang] = true

            task:wait(300000)
        end

        local ok, _ = pcall(vim.treesitter.start, event.buf, lang)
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

require("oil").setup({
    default_file_explorer = true,
    columns = {
        -- "icon",
        "permissions",
        "size",
        "mtime",
    },
})

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
