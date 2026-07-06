-- Julia
-- vim.lsp.enable('julials')

-- Haskell
vim.lsp.enable('hls')

vim.lsp.config('clangd', {
    cmd = {
        'clangd',
    },
})
vim.lsp.config('elixir-ls', {
    cmd = {
        'elixir-ls',
    },
})

vim.lsp.enable({
    -- 'julials',
    'clangd',
    'gopls',
    -- 'hls,',
    'nil_ls',
    'rust_analyzer',
    'qmlls',
    'tinymist',
    "cssls",
    "emmet_language_server",
    "html",
    "lua_ls",
    "pylsp",
    "taplo",
    "templ",
    "vtsls",
    -- "vue_ls",
    "svelte",
    -- "bashls",
    "jsonls",
    -- "dockerls",
    -- "docker_compose_language_service",
    "marksman",
    "yamlls",
    'tailwindcss',
    'eslint',
    'dartls',
    'elp',
    'elixirls',
    -- "omnisharp"
    -- 'metals'
})
