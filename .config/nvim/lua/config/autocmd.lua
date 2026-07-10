vim.api.nvim_create_autocmd('LspAttach', {
    callback = function(ev)
        local client = assert(vim.lsp.get_client_by_id(ev.data.client_id))
        if client:supports_method('textDocument/formatting') then
            vim.keymap.set("n", "<F3>",
                "<cmd>lua vim.lsp.buf.format({async = true})<cr>"
            )
            vim.keymap.set("n", "<F2>", function()
                vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
                vim.print("inlay_hint", vim.lsp.inlay_hint.is_enabled())
            end
            )
        end
        if client:supports_method('textDocument/completion') then
            vim.lsp.completion.enable(true, client.id, ev.buf, { autotrigger = true })
        end
    end,
})
