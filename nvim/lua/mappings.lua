require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")
map("n", "<leader>nh", ":noh<CR>", { desc = "Clear search highlights"})

-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")
