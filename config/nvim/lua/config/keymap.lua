-- Moving whole lines
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

local function set_wrap()
    vim.opt.wrap = true
    vim.opt.linebreak = true
    --vim.keymap.set('n', 'j', 'gj')
    --vim.keymap.set('n', 'k', 'gk')
end

local function set_nowrap()
    vim.opt.wrap = false
    vim.opt.linebreak = false
    --vim.keymap.set('n', 'j', 'j')
    --vim.keymap.set('n', 'k', 'k')
end

-- Toggle wrap
vim.keymap.set('n', '<leader>w', set_wrap)
vim.keymap.set('n', '<leader>W', set_nowrap)

-- Recenter
vim.keymap.set("n", "J", "mzJ`z")
-- vim.keymap.set("n", "<C-d>", "<C-d>zz")
-- vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- Exiting :terminal
vim.keymap.set("t", "<Esc>", "<C-\\><C-n><CR>")

-- Clipboard
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])
vim.keymap.set({ "n", "v" }, "<leader>p", [["+p]])
vim.keymap.set({ "n", "v" }, "<leader>Y", [["+Y]])
vim.keymap.set({ "n", "v" }, "<leader>P", [["+P]])

-- Delete without yank
vim.keymap.set({ "n", "v" }, "<leader>d", [["_d]])
vim.keymap.set({ "n", "v" }, "<leader>x", [["_d]])

-- Select everything quickly
vim.keymap.set("n", "<leader>a", "<Esc>ggVG")

-- Write a blank line
vim.keymap.set("n", "<leader>o", "o<Esc>")
vim.keymap.set("n", "<leader>O", "O<Esc>")

-- Esc is too far
vim.keymap.set({ "n", "v", "i" }, "<C-c>", "<Esc>")

-- quickfix
vim.keymap.set("n", "<C-k>", "<cmd>cnext<CR>zz")
vim.keymap.set("n", "<C-j>", "<cmd>cprev<CR>zz")
vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz")
vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz")

-- substitute everything
vim.keymap.set("n", "<leader>s",
    [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]]
)

-- format this
vim.keymap.set("n", "<leader>t", "<CMD>%s/\\s\\+$//e<CR><CMD>:nohlsearch<CR>")

-- Navigate tabs
vim.keymap.set('n', '<A-o>', '<cmd>tabnext<cr>')
vim.keymap.set('n', '<A-i>', '<cmd>tabprevious<cr>')
vim.keymap.set('n', '<tab>', '<cmd>tabnext<cr>')
vim.keymap.set('n', '<S-tab>', '<cmd>tabprevious<cr>')

-- Create/Close tabs
vim.keymap.set('n', '<A-t>', '<cmd>tabnew<cr>')
vim.keymap.set('n', '<A-w>', '<cmd>tabclose<cr>')

-- Move tabs
vim.keymap.set('n', '<A-O>', '<cmd>tabmove +1<cr>')
vim.keymap.set('n', '<A-I>', '<cmd>tabmove -1<cr>')
vim.keymap.set('n', '<C-tab>', '<cmd>tabmove +1<cr>')
vim.keymap.set('n', '<C-S-tab>', '<cmd>tabmove -1<cr>')

-- Change tabs
for i=1,9 do
    vim.keymap.set('n', '<A-' .. i .. '>', '<cmd>tabn '.. (i) .. '<cr>')
end
vim.keymap.set('n', '<A-0>', '<cmd>tabn 10<cr>')

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

local builtin = require("telescope.builtin")
vim.keymap.set("n", "<leader>f", builtin.find_files)
vim.keymap.set("n", "<leader>g", builtin.live_grep)
vim.keymap.set("n", "<leader>b", builtin.buffers)
vim.keymap.set("n", "<leader>z", builtin.help_tags)
vim.keymap.set("n", "<leader>h", builtin.diagnostics)

vim.keymap.set("n", "-", "<CMD>Oil<CR>")

-- my terminal is messing me up
vim.keymap.set('n', '<C-i>', '<C-i>', { noremap = true })
