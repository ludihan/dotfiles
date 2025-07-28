return {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.8",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
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
        local builtin = require("telescope.builtin")
        vim.keymap.set("n", "<leader>f", builtin.find_files)
        vim.keymap.set("n", "<leader>g", builtin.live_grep)
        vim.keymap.set("n", "<leader>b", builtin.buffers)
        vim.keymap.set("n", "<leader>z", builtin.help_tags)
        vim.keymap.set("n", "<leader>h", builtin.diagnostics)
    end,
}
