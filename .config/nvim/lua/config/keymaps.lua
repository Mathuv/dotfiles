-- Load your existing keymaps
vim.cmd('source ~/.config/nvim/vim/keymaps.vim')

-- Additional Lua keymaps can be added here
local map = vim.keymap.set

-- Example of how to add new keymaps in Lua
-- map('n', '<leader>ff', ':Telescope find_files<CR>', { silent = true, desc = "Find files" })
-- map('n', '<leader>fg', ':Telescope live_grep<CR>', { silent = true, desc = "Live grep" })
