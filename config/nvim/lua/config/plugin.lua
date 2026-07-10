vim.pack.add({
    'https://github.com/akinsho/toggleterm.nvim',
    'https://github.com/ellisonleao/gruvbox.nvim',
    'https://github.com/neovim/nvim-lspconfig',
    'https://github.com/stevearc/oil.nvim',
    'https://github.com/nvim-telescope/telescope.nvim',
    'https://github.com/nvim-lua/plenary.nvim',
    'https://github.com/hiphish/rainbow-delimiters.nvim',
    'https://github.com/folke/snacks.nvim',
    'https://github.com/nvim-treesitter/nvim-treesitter',
    'https://github.com/windwp/nvim-ts-autotag',
    'https://github.com/Saghen/blink.cmp',
    'https://github.com/saghen/blink.lib',
    'https://github.com/neogitorg/neogit',
})

require('blink.cmp').setup({
    -- 'default' (recommended) for mappings similar to built-in completions (C-y to accept)
    -- 'super-tab' for mappings similar to vscode (tab to accept)
    -- 'enter' for enter to accept
    -- 'none' for no mappings
    --
    -- All presets have the following mappings:
    -- C-space: Open menu or open docs if already open
    -- C-n/C-p or Up/Down: Select next/previous item
    -- C-e: Hide menu
    -- C-k: Toggle signature help (if signature.enabled = true)
    --
    -- See :h blink-cmp-config-keymap for defining your own keymap
    keymap = { preset = 'default' },

    -- (Default) Only show the documentation popup when manually triggered
    completion = {
        documentation = { auto_show = true },
        menu = {
            draw = {
                columns = { { 'label', 'label_description', gap = 1 }, { 'kind' } }
            }
        }
    },

    -- (Default) list of enabled providers defined so that you can extend it
    -- elsewhere in your config, without redefining it, due to `opts_extend`
    sources = { default = { 'lsp', 'path', 'snippets', 'buffer' } },

    -- (Default) Rust fuzzy matcher for typo resistance and significantly better performance
    -- You may use a lua implementation instead by using `implementation = "lua"`
    -- See the fuzzy documentation for more information
    fuzzy = { implementation = "lua" }
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

            local ok, _ = pcall(ts.install, { lang }, { summary = false })
            if not ok then return end
            installed_langs[lang] = true
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

require("toggleterm").setup({
    direction = "tab",
    open_mapping = nil,
    shade_terminals = false,
    start_in_insert = true,
    persist_size = false,
})

-- scala
--[[
local metals_config = require("metals").bare_config()

local nvim_metals_group =
  vim.api.nvim_create_augroup("nvim-metals", { clear = true })

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "scala", "sbt", "java" },
  callback = function()
    require("metals").initialize_or_attach(metals_config)
  end,
  group = nvim_metals_group,
})
]]
