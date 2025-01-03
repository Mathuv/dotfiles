-- Options from your previous Vim configuration
local opt = vim.opt

-- Load your existing vim options
vim.cmd('source ~/.config/nvim/vim/options.vim')

-- Additional Lua-specific options can be added here
opt.termguicolors = true -- Enable true color support
opt.clipboard = "unnamedplus" -- Use system clipboard
opt.mouse = "a" -- Enable mouse support
opt.undofile = true -- Enable persistent undo
opt.ignorecase = true -- Ignore case in search
opt.smartcase = true -- Override ignorecase if search pattern has uppercase
