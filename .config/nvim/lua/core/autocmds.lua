local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

-- Dynamic smartcase for command line
local dynamic_smartcase = augroup('dynamic_smartcase', { clear = true })
autocmd('CmdLineEnter', {
    group = dynamic_smartcase,
    pattern = ':',
    command = 'set nosmartcase'
})
autocmd('CmdLineLeave', {
    group = dynamic_smartcase,
    pattern = ':',
    command = 'set smartcase'
})

-- Terminal settings
autocmd('TermOpen', {
    pattern = '*',
    command = 'startinsert'
})

-- CoC highlight
if not vim.g.gui_vimr then
    autocmd('CursorHold', {
        pattern = '*',
        callback = function()
            vim.fn['CocActionAsync']('highlight')
        end,
        desc = 'Highlight symbol under cursor on CursorHold'
    })
end
