vim.api.nvim_create_autocmd('LspAttach', {
    callback = function(args)
        local client = assert(vim.lsp.get_client_by_id(args.data.client_id))

        if client:supports_method('textDocument/completion') then
            vim.opt.completeopt = {
                "noselect",
                "menu",
                "menuone",
                "fuzzy",
                "popup",
            }

            vim.lsp.completion.enable(true, client.id, args.buf, { autotrigger = true })
        end
        if client:supports_method('textDocument/formatting') then
            vim.keymap.set("n", "<F3>",
                "<cmd>lua vim.lsp.buf.format({async = true})<cr>"
            )
        end
    end,
})
