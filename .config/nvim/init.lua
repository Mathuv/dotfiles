-- Set leader key before lazy.nvim
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Disable netrw (recommended when using nvim-tree)
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- Load core configurations
require('core.options')
require('core.keymaps')
require('core.autocmds')

-- Load plugin configurations
require('plugins')
require('plugins.coc')

-- Set colorscheme (after plugins are loaded)
vim.cmd [[colorscheme dracula]]

-- Set up nvim-tree after plugins are loaded
vim.cmd [[
if has('nvim') && executable('nvr')
  let $VISUAL="nvr -cc split --remote-wait +'set bufhidden=wipe'"
endif
]]

-- Configure test settings
vim.g['test#strategy'] = 'dispatch'
vim.g['test#python#runner'] = 'djangotest'
vim.g['test#python#djangotest#options'] = {
    ['--verbosity'] = 2,
    ['--no-input'] = true
}
vim.g['test#python#djangotest#executable'] = 'python3 manage.py test'
