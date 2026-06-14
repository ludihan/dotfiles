-- Julia
-- vim.lsp.enable('julials')

-- Haskell
vim.lsp.enable('hls')

-- Vue
local vue_language_server_path = vim.fn.expand '$MASON/packages' ..
    '/vue-language-server' .. '/node_modules/@vue/language-server'
local tsserver_filetypes = { 'typescript', 'javascript', 'javascriptreact', 'typescriptreact', 'vue' }
local vue_plugin = {
    name = '@vue/typescript-plugin',
    location = vue_language_server_path,
    languages = { 'vue' },
    configNamespace = 'typescript',
}
local vtsls_config = {
    settings = {
        vtsls = {
            tsserver = {
                globalPlugins = {
                    vue_plugin,
                },
            },
        },
    },
    filetypes = tsserver_filetypes,
}

local ts_ls_config = {
    init_options = {
        plugins = {
            vue_plugin,
        },
    },
    filetypes = tsserver_filetypes,
}

-- If you are on most recent `nvim-lspconfig`
local vue_ls_config = {}

-- nvim 0.11 or above
vim.lsp.config('vtsls', vtsls_config)
vim.lsp.config('vue_ls', vue_ls_config)
vim.lsp.config('ts_ls', ts_ls_config)
vim.lsp.enable({ 'vtsls', 'vue_ls' }) -- If using `ts_ls` replace `vtsls` to `ts_ls`
vim.lsp.config('clangd', {
    cmd = {
        'clangd',
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
    -- "svelte",
    -- "bashls",
    "jsonls",
    -- "dockerls",
    -- "docker_compose_language_service",
    "marksman",
    "yamlls",
    'dartls',
    -- "omnisharp"
    'metals'
})
