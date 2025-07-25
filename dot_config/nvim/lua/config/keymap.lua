-- Moving whole lines
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- Recenter
vim.keymap.set("n", "J", "mzJ`z")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- Exiting :terminal
vim.keymap.set("t", "<Esc>", "<C-\\><C-n><CR>")

-- Clipboard
vim.keymap.set({ "n", "x" }, "<leader>y", [["+y]])
vim.keymap.set({ "n", "x" }, "<leader>p", [["+p]])
vim.keymap.set({ "n", "x" }, "<leader>Y", [["+Y]])
vim.keymap.set({ "n", "x" }, "<leader>P", [["+P]])

-- Delete without yank
vim.keymap.set({ "n", "x" }, "<leader>d", [["_d]],
    { desc = "delete without yank" }
)
vim.keymap.set({ "n", "x" }, "<leader>x", [["_d]],
    { desc = "delete without yank" }
)

-- Select everything quickly
vim.keymap.set("n", "<leader>a", "<Esc>ggVG", { desc = "select all text" })

-- Write a blank line
vim.keymap.set("n", "<leader>o", "o<Esc>")
vim.keymap.set("n", "<leader>O", "O<Esc>")

-- Esc is too far
vim.keymap.set({ "n", "v", "i" }, "<C-c>", "<Esc>",
    { desc = "same as pressing esc" })

-- quickfix
vim.keymap.set("n", "<C-k>", "<cmd>cnext<CR>zz")
vim.keymap.set("n", "<C-j>", "<cmd>cprev<CR>zz")
vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz")
vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz")

-- substitute everything
vim.keymap.set("n", "<leader>s",
    [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]],
    { desc = "substitute word under cursor globally on file" }
)

-- format this
vim.keymap.set("n", "<leader>w", "<CMD>%s/\\s\\+$//e<CR><CMD>:nohlsearch<CR>",
    { desc = "remove trailing spaces from file" }
)

-- Auto pairs when tab
--vim.keymap.set("i", '"<Tab>', '""<Left>')
--vim.keymap.set("i", "'<Tab>", "''<Left>")
--vim.keymap.set("i", "(<Tab>", "()<Left>")
--vim.keymap.set("i", "[<Tab>", "[]<Left>")
--vim.keymap.set("i", "{<Tab>", "{}<Left>")
-- vim.keymap.set("i", "<<Tab>", "<<Left>")

-- Auto braces when newline
--vim.keymap.set("i", '"<CR>', '"<CR>"<Esc>O')
--vim.keymap.set("i", "'<CR>", "'<CR>'<Esc>O")
--vim.keymap.set("i", "(<CR>", "(<CR>)<Esc>O")
--vim.keymap.set("i", "[<CR>", "[<CR>]<Esc>O")
--vim.keymap.set("i", "{<CR>", "{<CR>}<Esc>O")
-- vim.keymap.set("i", "{;<CR>", "{<CR>};<Esc>O<Tab>")
