local map = vim.keymap.set

-- Leader key
vim.g.mapleader = ' '

-- FZF mappings
map('n', '<Leader>hh', ':History<CR>', { silent = true })
map('n', '<Leader>h:', ':History:<CR>', { silent = true })
map('n', '<Leader>h/', ':History/<CR>', { silent = true })
map('n', '<Leader>h?', ':History?<CR>', { silent = true })
map('n', '<Leader>hs', ':History:<C-R><C-W><CR>', { silent = true })
map('n', '<Leader>hS', ':History!<C-R><C-W><CR>', { silent = true })
map('n', '<Leader>hr', ':Rg! <C-R><C-W><CR>', { silent = true })
map('n', '<Leader>hrg', ':Rgh! <C-R><C-W><CR>', { silent = true })

-- Testing mappings
map('n', 't<C-n>', ':TestNearest<CR>', { silent = true })
map('n', 't<C-f>', ':TestFile<CR>', { silent = true })
map('n', 't<C-s>', ':TestSuite<CR>', { silent = true })
map('n', 't<C-l>', ':TestLast<CR>', { silent = true })
map('n', 't<C-v>', ':TestVisit<CR>', { silent = true })
map('n', 't<C-d>', ':TestDiagnostic<CR>', { silent = true })

-- Iron REPL mappings
map('n', '<space>ii', '<cmd>IronRepl<cr>', { silent = true })
map('n', '<space>ir', '<cmd>IronRestart<cr>', { silent = true })
map('n', '<space>if', '<cmd>IronFocus<cr>', { silent = true })
map('n', '<space>ih', '<cmd>IronHide<cr>', { silent = true })
