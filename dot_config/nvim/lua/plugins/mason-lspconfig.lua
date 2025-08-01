return {
    "mason-org/mason-lspconfig.nvim",
    opts = {
        ensure_installed = {
            "cssls",
            "emmet_language_server",
            "gopls",
            -- "hls",
            "html",
            "lua_ls",
            "pylsp",
            "rust_analyzer",
            -- "bacon-ls",
            "taplo",
            "templ",
            "ts_ls",
            "bashls",
            "jsonls",
            "dockerls",
            "docker_compose_language_service",
            --"clangd",
            "yamlls",
        },
    },
    dependencies = {
        { "mason-org/mason.nvim", opts = {} },
        "neovim/nvim-lspconfig",
    },
}
