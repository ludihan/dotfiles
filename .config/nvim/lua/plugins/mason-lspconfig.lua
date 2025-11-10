return {
    "mason-org/mason-lspconfig.nvim",
    opts = {
        ensure_installed = {
            "cssls",
            "emmet_language_server",
            "gopls",
            "html",
            "lua_ls",
            "pylsp",
            "rust_analyzer",
            "taplo",
            "templ",
            -- "ts_ls",
            "vtsls",
            "vue_ls",
            "bashls",
            "jsonls",
            "dockerls",
            "docker_compose_language_service",
            "marksman",
            "yamlls",
            "omnisharp"
        },
    },
    dependencies = {
        { "mason-org/mason.nvim", opts = {} },
        { "neovim/nvim-lspconfig" },
    },
}
