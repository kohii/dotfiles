require "nvchad.mappings"

-- add yours here

-- local map = vim.keymap.set

-- map("n", ";", ":", { desc = "CMD enter command mode" })
-- map("i", "jk", "<ESC>")

-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")

-- U to redo
vim.keymap.set('n', 'U', '<C-r>', { noremap = true })

-- Y to yank to end of line
vim.keymap.set('n', 'Y', 'y$', { noremap = true })

-- i<space> and a<space> to select the word
vim.keymap.set('o', 'i<space>', 'iW', { noremap = true })
vim.keymap.set('x', 'i<space>', 'iW', { noremap = true })

-- {visual}p to put without yank to unnamed register
vim.keymap.set('x', 'p', 'P', { noremap = true })

-- x to delete the character under the cursor without yanking it
vim.keymap.set('n', 'x', '"_d', { noremap = true })
vim.keymap.set('n', 'X', '"_D', { noremap = true })
vim.keymap.set('x', 'x', '"_x', { noremap = true })
vim.keymap.set('o', 'x', 'd', { noremap = true })

-- start searching with very magic
vim.keymap.set('n', '/', '/\\v', { noremap = true })
vim.keymap.set('n', '?', '/\\V', { noremap = true })

-- S to replace the word under the cursor
vim.keymap.set('n', 'S', ':%s/\\V\\<<C-r><C-w>\\>//g<Left><Left>', { noremap = true })
vim.keymap.set('x', 'S', [["zy:%s/\V<C-r><C-r>=escape(@z,'/\\')<CR>//gce<Left><Left><Left><Left>"]], { noremap = true })

