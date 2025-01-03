-- Load your existing keymaps
-- vim.cmd('source ~/.config/nvim/vim/keymaps.vim')

-- Additional Lua keymaps can be added here
local map = vim.keymap.set
local default_opts = { silent = true }

-- Leader key
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- General mappings
map('n', ',,', ':b#<CR>', default_opts)  -- Switch between buffers
map('n', '<leader>w', ':w<CR>', default_opts)  -- Quick save
map('n', '<esc>', ':noh<return><esc>', { silent = true })  -- Clear search highlighting
map('n', '<C-;>', '<Esc>:update<CR>', default_opts)  -- Save with Ctrl+;
map('i', '<C-;>', '<Esc>:update<CR>', default_opts)

-- Copy & paste to system clipboard
map('v', '<Leader>y', '"+y', default_opts)
map('v', '<Leader>d', '"+d', default_opts)
map('n', '<Leader>p', '"+p', default_opts)
map('n', '<Leader>P', '"+P', default_opts)
map('v', '<Leader>p', '"+p', default_opts)
map('v', '<Leader>P', '"+P', default_opts)

-- Buffer management
map('n', '<leader>bd', ':bd<CR>', default_opts)
map('n', '<Leader>bh', ':hide<CR>', default_opts)

-- Window navigation
local modes = { 'n', 't', 'i', 'v' }
for _, mode in ipairs(modes) do
    map(mode, '<C-h>', mode == 'n' and '<C-w>h' or '<C-\\><C-n><C-w>h', default_opts)
    map(mode, '<C-j>', mode == 'n' and '<C-w>j' or '<C-\\><C-n><C-w>j', default_opts)
    map(mode, '<C-k>', mode == 'n' and '<C-w>k' or '<C-\\><C-n><C-w>k', default_opts)
    map(mode, '<C-l>', mode == 'n' and '<C-w>l' or '<C-\\><C-n><C-w>l', default_opts)
end

-- Terminal mappings
if vim.fn.has('nvim') == 1 then
    map('t', '<Esc>', '<C-\\><C-n>', default_opts)
    map('t', '<C-v><Esc>', '<Esc>', default_opts)
--     map('t', '<expr> <C-R>', '<C-\\><C-N>"'..'nr2char(getchar())..'pi', default_opts)
    map('t', '<C-v><C-R>', '<C-R>', default_opts)
end

-- Line movement
map('n', '<A-j>', ':m .+1<CR>==', default_opts)
map('n', '<A-k>', ':m .-2<CR>==', default_opts)
map('i', '<A-j>', '<Esc>:m .+1<CR>==gi', default_opts)
map('i', '<A-k>', '<Esc>:m .-2<CR>==gi', default_opts)
map('v', '<A-j>', ":m '>+1<CR>gv=gv", default_opts)
map('v', '<A-k>', ":m '<-2<CR>gv=gv", default_opts)

-- Git (Fugitive) mappings
map('n', '<leader>gd', ':Gvdiff<CR>', default_opts)
map('n', 'gdh', ':diffget //2<CR>', default_opts)
map('n', 'gdl', ':diffget //3<CR>', default_opts)
map('n', '<leader>gb', ':Git blame<CR>', default_opts)
map('n', '<leader>gdd', ':Gdiffsplit! origin/develop<CR>', default_opts)
map('n', '<leader>gdm', ':Gdiffsplit! origin/master<CR>', default_opts)
map('n', '<leader>gdu', ':Gdiffsplit! @{u}<CR>', default_opts)
map('n', '<leader>gp', ':Git push<CR>', default_opts)
map('n', '<leader>gs', ':Git<CR><C-w>8-', default_opts)
map('n', '<leader>gg', ':ToggleGStatus<CR>', default_opts)

-- CoC mappings
local coc_opts = { silent = true, noremap = true, expr = true, replace_keycodes = false }
map('i', '<c-space>', 'coc#refresh()', coc_opts)
map('n', '[g', '<Plug>(coc-diagnostic-prev)', default_opts)
map('n', ']g', '<Plug>(coc-diagnostic-next)', default_opts)
map('n', 'gd', '<Plug>(coc-definition)', default_opts)
map('n', 'gy', '<Plug>(coc-type-definition)', default_opts)
map('n', 'gi', '<Plug>(coc-implementation)', default_opts)
map('n', 'gr', '<Plug>(coc-references)', default_opts)
map('n', 'K', ':call v:lua.ShowDocumentation()<CR>', default_opts)
map('x', '<leader>a', '<Plug>(coc-codeaction-selected)', default_opts)
map('n', '<leader>a', '<Plug>(coc-codeaction-selected)', default_opts)
map('n', '<leader>rn', '<Plug>(coc-rename)', default_opts)
map('x', '<leader>f', '<Plug>(coc-format-selected)', default_opts)
map('n', '<leader>f', '<Plug>(coc-format-selected)', default_opts)
map('n', '<leader>ac', '<Plug>(coc-codeaction-cursor)', default_opts)
map('n', '<leader>as', '<Plug>(coc-codeaction-source)', default_opts)
map('n', '<leader>qf', '<Plug>(coc-fix-current)', default_opts)
map('n', '<leader>re', '<Plug>(coc-codeaction-refactor)', default_opts)
map('x', '<leader>r', '<Plug>(coc-codeaction-refactor-selected)', default_opts)
map('n', '<leader>r', '<Plug>(coc-codeaction-refactor-selected)', default_opts)
map('x', '<leader>rf', '<Plug>(coc-refactor)', default_opts)
map('n', '<leader>rf', '<Plug>(coc-refactor)', default_opts)
map('n', '<leader>cl', '<Plug>(coc-codelens-action)', default_opts)

-- FZF mappings
map('n', '<Leader>hh', ':History<CR>', default_opts)
map('n', '<Leader>h:', ':History:<CR>', default_opts)
map('n', '<Leader>h/', ':History/<CR>', default_opts)

-- Telescope mappings
map('n', '<leader>ff', '<cmd>Telescope find_files<cr>', default_opts)
map('n', '<leader>fg', '<cmd>Telescope live_grep<cr>', default_opts)
map('n', '<leader>fb', '<cmd>Telescope buffers<cr>', default_opts)
map('n', '<leader>fh', '<cmd>Telescope help_tags<cr>', default_opts)
map('n', '<leader>tt', '<cmd>Telescope tags<cr>', default_opts)
map('n', '<leader>tb', '<cmd>Telescope current_buffer_tags<cr>', default_opts)
map('n', '<leader>fo', '<cmd>Telescope oldfiles<cr>', default_opts)
map('n', '<leader>fF', ":execute 'Telescope find_files default_text=' . \"'\" . expand('<cword>')<cr>", default_opts)
map('n', '<leader>fG', ":execute 'Telescope live_grep default_text=' . expand('<cword>')<cr>", default_opts)
map('n', '<leader>tT', ":execute 'Telescope tags default_text=' . expand('<cword>')<cr>", default_opts)

-- Tagbar
map('n', '<F8>', ':TagbarToggle<CR>', default_opts)

-- Test.vim mappings
map('n', 't<C-n>', ':TestNearest<CR>', default_opts)
map('n', 't<C-f>', ':TestFile<CR>', default_opts)
map('n', 't<C-s>', ':TestSuite<CR>', default_opts)
map('n', 't<C-l>', ':TestLast<CR>', default_opts)
map('n', 't<C-g>', ':TestVisit<CR>', default_opts)

-- Hop.nvim mappings
map('n', '<leader><leader>w', ':HopWordAC<CR>', default_opts)
map('n', '<leader><leader>b', ':HopWordBC<CR>', default_opts)
map('n', '<leader><leader>s', ':HopChar1AC<CR>', default_opts)
map('n', '<leader><leader>S', ':HopChar1BC<CR>', default_opts)
map('n', '<leader><leader>j', ':HopLineAC<CR>', default_opts)
map('n', '<leader><leader>k', ':HopLineBC<CR>', default_opts)
map('n', '<leader><leader>/', ':HopPattern<CR>', default_opts)
map('n', '<leader><leader>?', ':HopPatternBC<CR>', default_opts)
map('n', '<leader><leader>f', ':HopChar1CurrentLineAC<CR>', default_opts)
map('n', '<leader><leader>F', ':HopChar1CurrentLineBC<CR>', default_opts)

-- NvimTree
map('n', '<Leader>b', ':NvimTreeFindFileToggle<CR>', default_opts)

-- Quickfix and Location list
map('n', '<Leader>cc', ':ccl<CR>', default_opts)
map('n', '<Leader>co', ':Copen<CR>', default_opts)
map('n', '<Leader>lc', ':lclose<CR>', default_opts)
map('n', '<Leader>lo', ':lopen<CR>', default_opts)

-- System copy
map('n', 'cy', '<Plug>SystemCopy', default_opts)
map('x', 'cy', '<Plug>SystemCopy', default_opts)
map('n', 'cY', '<Plug>SystemCopyLine', default_opts)
map('n', 'cp', '<Plug>SystemPaste', default_opts)
map('x', 'cp', '<Plug>SystemPaste', default_opts)
map('n', 'cP', '<Plug>SystemPasteLine', default_opts)

-- Terminal commands
if vim.fn.has('nvim') == 1 then
    vim.cmd([[
        command! Spt sp|terminal
        command! Vspt vsp|terminal
    ]])
    local term_modes = { 'n', 't', 'i', 'v' }
    for _, mode in ipairs(term_modes) do
        map(mode, '<C-w>t', '<c-\\><c-n>:Vspt<CR>', default_opts)
    end
end

-- Custom functions
_G.ShowDocumentation = function()
    if vim.fn.CocAction('hasProvider', 'hover') then
        vim.fn.CocActionAsync('doHover')
    else
        vim.fn.feedkeys('K', 'in')
    end
end

-- Create the OpenIssueURL function
_G.OpenIssueURL = function()
    local current_word = vim.fn.expand('<cword>')
    local base_url = "https://adtrac.atlassian.net/browse/INDY-"
    local full_url = base_url .. current_word
    
    vim.api.nvim_echo({{string.format("Opening URL: %s", full_url)}}, false, {})
    
    if vim.fn.has("unix") == 1 then
        if vim.fn.system("uname"):match("^Darwin") then
            vim.fn.system(string.format("open %s", full_url))
        else
            vim.fn.system(string.format("xdg-open %s", full_url))
        end
    elseif vim.fn.has("win32") == 1 then
        vim.fn.system(string.format("start %s", full_url))
    end
end

map('n', '<Leader>o', ':lua OpenIssueURL()<CR>', default_opts)

-- Zen mode
map('n', '<leader>z', ':ZenMode<CR>', default_opts)
