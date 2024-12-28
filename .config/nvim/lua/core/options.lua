local opt = vim.opt

-- Search
opt.ignorecase = true
opt.smartcase = true

-- UI
opt.cursorline = true
opt.splitright = true

-- Command preview
opt.inccommand = 'nosplit'

-- Basic settings
opt.termguicolors = true
opt.showmatch = true
opt.number = true
opt.relativenumber = true

-- Indentation
opt.expandtab = true
opt.shiftwidth = 4
opt.tabstop = 4
opt.smartindent = true

-- Performance
opt.lazyredraw = true
opt.updatetime = 250

-- Completion
opt.completeopt = {'menuone', 'noselect', 'noinsert'}
opt.shortmess = opt.shortmess + { c = true }

-- Window
opt.splitright = true
opt.splitbelow = true
