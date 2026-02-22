vim.g.mapleader = " "
vim.g.maplocalleader = " "

local map = vim.keymap.set

-- VISUAL
-- window navigation
map("x", "<C-h>", "<C-w>h")
map("x", "<C-j>", "<C-w>j")
map("x", "<C-k>", "<C-w>k")
map("x", "<C-l>", "<C-w>l")

-- COMMAND
map("c", "<C-a>", "<Home>")
map("c", "<C-e>", "<End>")

-- NORMAL
map("n", "Q", "q")
map("n", "Y", "y$")

-- window navigation
map("n", "<C-h>", "<C-w>h")
map("n", "<C-j>", "<C-w>j")
map("n", "<C-k>", "<C-w>k")
map("n", "<C-l>", "<C-w>l")

-- quickfix navigation with arrow keys
map("n", "<Up>",    "<cmd>cprevious<CR>", { silent = true })
map("n", "<Down>",  "<cmd>cnext<CR>",     { silent = true })
map("n", "<Left>",  "<cmd>cpfile<CR>",    { silent = true })
map("n", "<Right>", "<cmd>cnfile<CR>",    { silent = true })

-- Store large relative jumps in the jumplist
map("n", "k", function()
  return (vim.v.count > 5 and "m'" .. vim.v.count or "") .. "k"
end, { expr = true })
map("n", "j", function()
  return (vim.v.count > 5 and "m'" .. vim.v.count or "") .. "j"
end, { expr = true })

-- LEADER
map("n", "<Leader><Leader>", "<C-^>",                  { desc = "Alternate file" })
map("n", "<Leader>p",        function() print(vim.fn.expand("%")) end, { desc = "Show file path" })
map("n", "<Leader>e",        function()
  return ":edit " .. vim.fn.expand("%:p:h") .. "/"
end, { expr = true, desc = "Edit in same directory" })

-- VimTmuxRunner - run current paragraph
map("n", "<Leader>sp", "myvip:VtrSendLinesToRunner<CR>`y", { desc = "Send paragraph to runner" })
