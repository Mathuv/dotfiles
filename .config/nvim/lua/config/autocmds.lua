-- Load your existing commands
vim.cmd('source ~/.config/nvim/vim/commands.vim')

-- Create autocommand groups
local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

-- Example of how to create autocommands in Lua
-- local highlight_group = augroup('YankHighlight', { clear = true })
-- autocmd('TextYankPost', {
--   callback = function()
--     vim.highlight.on_yank()
--   end,
--   group = highlight_group,
--   pattern = '*',
-- })
