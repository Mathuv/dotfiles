-- Load your existing commands
-- vim.cmd('source ~/.config/nvim/vim/commands.vim')

-- Create autocommand groups
local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

-- Utility function for creating autocommands
local function augroup(name, commands)
    vim.api.nvim_create_augroup(name, { clear = true })
    for _, cmd in ipairs(commands) do
        vim.api.nvim_create_autocmd(cmd.events, {
            group = name,
            pattern = cmd.pattern,
            callback = cmd.callback,
            command = cmd.command,
        })
    end
end

-- Diff with saved version
local function diff_with_saved()
    local filetype = vim.bo.ft
    vim.cmd('diffthis')
    vim.cmd('vnew | r # | normal! 1Gdd')
    vim.cmd('diffthis')
    vim.cmd(string.format('setlocal bt=nofile bh=wipe nobl noswf ro ft=%s', filetype))
end

vim.api.nvim_create_user_command('DiffSaved', diff_with_saved, {})

-- FZF related functions and commands
local function line_handler(line)
    local keys = vim.split(line, ':\t')
    vim.cmd(string.format('buf %s', keys[1]))
    vim.cmd(keys[2])
    vim.cmd('normal! ^zz')
end

local function buffer_lines()
    local res = {}
    for b = 1, vim.fn.bufnr('$') do
        if vim.fn.buflisted(b) == 1 then
            local lines = vim.api.nvim_buf_get_lines(b, 0, -1, false)
            for i, line in ipairs(lines) do
                table.insert(res, string.format('%d:\t%d:\t%s', b, i, line))
            end
        end
    end
    return res
end

-- RipGrep functions
local function ripgrep_fzf(query, fullscreen)
    local command_fmt = 'rg --column --line-number --no-heading --color=always --smart-case -- %s || true'
    local initial_command = string.format(command_fmt, vim.fn.shellescape(query))
    local reload_command = string.format(command_fmt, '{q}')
    local spec = {
        options = {
            '--phony',
            '--query', query,
            '--bind', 'change:reload:' .. reload_command
        }
    }
    vim.fn['fzf#vim#grep'](initial_command, 1, vim.fn['fzf#vim#with_preview'](spec), fullscreen)
end

local function rg_both(search_term1, search_term2)
    local grep_cmd = string.format("rg -l '%s' | xargs rg -l '%s'", search_term1, search_term2)
    local source = vim.fn.split(vim.fn.system(grep_cmd), "\n")
    local preview_cmd = vim.fn.has('win32') == 1 or vim.fn.has('win64') == 1 
        and 'bat --style=numbers --color=always --line-range :500 {}' 
        or 'bat --style=numbers --color=always --line-range :500 {} || cat {}'

    local options = {
        source = source,
        sink = function(line) vim.cmd('edit ' .. line) end,
        options = string.format('--ansi --prompt "RgBoth> " --preview-window "right:60%%:wrap" --preview "%s"', preview_cmd),
        down = '100%'
    }
    vim.fn['fzf#run'](options)
end

-- Python dot path function
local function copy_python_dot_path()
    local current_pos = vim.fn.getpos('.')
    local method = ''
    local class = ''

    -- Find method definition
    if vim.fn.search([[^\s*def\s\+\zs\k\+\ze\s*(]], 'bW') > 0 then
        method = vim.fn.matchstr(vim.fn.getline('.'), [[^\s*def\s\+\zs\k\+\ze\s*(]])
    end

    -- Find class definition
    if vim.fn.search([[^\s*class\s\+\zs\k\+\ze\s*(]], 'bW') > 0 then
        class = vim.fn.matchstr(vim.fn.getline('.'), [[^\s*class\s\+\zs\k\+\ze\s*(]])
    end

    -- Restore cursor position
    vim.fn.setpos('.', current_pos)

    -- Get file path components
    local relative_path = vim.fn.expand('%:.')
    local dot_path = relative_path:gsub('/', '.')
    local dot_path_no_ext = dot_path:gsub('%.[^.]*$', '')

    -- Build full path
    local full_path = dot_path_no_ext
    if class ~= '' then
        full_path = full_path .. '.' .. class
    end
    if method ~= '' then
        full_path = full_path .. '.' .. method
    end

    -- Copy to clipboard
    if vim.fn.has('clipboard') == 1 then
        vim.fn.setreg('+', full_path)
    else
        vim.api.nvim_err_writeln('Clipboard support is not available.')
    end
end

-- Register user commands
local user_commands = {
    -- FZF and search commands
    { 'FZFLines', 'lua vim.fn["fzf#run"]({ source = buffer_lines(), sink = line_handler, options = "--extended --nth=3..", down = "60%" })', {} },
    { 'Rgh', [[lua vim.fn['fzf#vim#grep']('rg --hidden --no-ignore-vcs --column --line-number --no-heading --color=always --smart-case '..vim.fn.shellescape(<q-args>), 1, vim.fn['fzf#vim#with_preview'](), <bang>0)]], { nargs = '*', bang = true } },
    { 'Rg', [[lua vim.fn['fzf#vim#grep']('rg --column --line-number --no-heading --color=always --smart-case '..vim.fn.shellescape(<q-args>), 1, vim.fn['fzf#vim#with_preview'](), <bang>0)]], { nargs = '*', bang = true } },
    { 'Rgc', [[lua vim.fn['fzf#vim#grep']('rg --column --line-number --no-heading --color=always --case-sensitive '..vim.fn.shellescape(<q-args>), 1, vim.fn['fzf#vim#with_preview'](), <bang>0)]], { nargs = '*', bang = true } },
    { 'RG', function(opts) ripgrep_fzf(opts.args, opts.bang) end, { nargs = '*', bang = true } },
    { 'RgBoth', function(opts) rg_both(opts.fargs[1], opts.fargs[2]) end, { nargs = '+' } },
    
    -- Buffer commands
    { 'BufOnly', '%bd|e#|bd#|normal `"', { bang = true } },
    { 'B', 'Buffers', { bang = true } },
    
    -- Format commands
    { 'FormatJSON', '%!python -m json.tool', {} },
    { 'JQFormatJSON', '%!jq', {} },
    { 'FormatPgsql', '<line1>,<line2>!pg_format -s 2 -u 2 -U 1 -w 80 -g -i', { range = '%' } },
    
    -- Git commands
    { 'GitGutterDiffHead', 'let g:gitgutter_diff_base = "head" | GitGutter', {} },
    { 'GGDH', 'let g:gitgutter_diff_base = "head" | GitGutter', {} },
    { 'GitGutterDiffDevelop', 'let g:gitgutter_diff_base = "develop" | GitGutter', {} },
    { 'GGDD', 'let g:gitgutter_diff_base = "origin/develop" | GitGutter', {} },
    { 'GGDM', 'let g:gitgutter_diff_base = "origin/master" | GitGutter', {} },
    
    -- Test commands
    { 'TestUseDocker', 'let test#python#djangotest#executable = "docker-compose exec app python manage.py test"', {} },
    { 'TestUserLocal', 'let test#python#djangotest#executable = "python3 manage.py test"', {} },
    { 'TestStrDispatch', 'let test#strategy = "dispatch"', {} },
    { 'TestStrNeovim', 'let test#strategy = "neovim"', {} },
    
    -- Editor integration commands
    { 'Code', function() vim.fn.system('code -g ' .. vim.fn.expand('%') .. ':' .. vim.fn.line('.')) end, {} },
    { 'Cursor', function() vim.fn.system('cursor -g ' .. vim.fn.expand('%') .. ':' .. vim.fn.line('.')) end, {} },
    { 'Pycharm', function() vim.fn.system('pycharm --line ' .. vim.fn.line('.') .. ' ' .. vim.fn.expand('%')) end, {} },
    
    -- Copy path commands
    { 'CopyFilename', function() vim.fn.setreg('+', vim.fn.expand('%:t:r')) end, {} },
    { 'CopyFilenameExt', function() vim.fn.setreg('+', vim.fn.expand('%:t')) end, {} },
    { 'CopyFilenameFullPath', function() vim.fn.setreg('+', vim.fn.expand('%:p')) end, {} },
    { 'CopyFilenameHomePath', function() vim.fn.setreg('+', vim.fn.expand('%:p:~')) end, {} },
    { 'CopyFileRelativePath', function() vim.fn.setreg('+', vim.fn.expand('%')) end, {} },
    { 'CopyFileFullPath', function() vim.fn.setreg('+', vim.fn.expand('%:p:h')) end, {} },
    { 'CopyFileHomePath', function() vim.fn.setreg('+', vim.fn.expand('%:p:~:h')) end, {} },
    { 'CopyPythonDotPath', copy_python_dot_path, {} },
    
    -- Python breakpoint commands
    { 'DisableBreakpoints', function() vim.env.PYTHONBREAKPOINT = '0' end, {} },
    { 'EnableBreakpoints', function() vim.env.PYTHONBREAKPOINT = nil end, {} },
    { 'DelBreakpoints', 'bufdo g/breakpoint()/d | update', {} },
    
    -- CoC commands
    { 'PrettierCoc', 'CocCommand prettier.forceFormatDocument', { nargs = 0 } },
    { 'FormatCoc', function() vim.fn.CocActionAsync('format') end, { nargs = 0 } },
    { 'Fold', function(opts) vim.fn.CocAction('fold', opts.args) end, { nargs = '?' } },
}

-- Register all user commands
for _, cmd in ipairs(user_commands) do
    vim.api.nvim_create_user_command(cmd[1], cmd[2], cmd[3])
end

-- Set up autocommands
augroup('custom_autocommands', {
    -- Python specific settings
    {
        events = { 'FileType' },
        pattern = { 'python' },
        callback = function()
            vim.b.coc_root_patterns = {
                '.git', '.env', '.venv', '__pycache__',
                '.pytest_cache', '.mypy_cache', '.tox', 'venv', 'env'
            }
        end
    },
    
    -- Auto-close preview window
    {
        events = { 'InsertLeave', 'CompleteDone' },
        pattern = { '*' },
        callback = function()
            if vim.fn.pumvisible() == 0 then
                vim.cmd('pclose')
            end
        end
    },
    
    -- Spell checking
    {
        events = { 'BufRead', 'BufNewFile' },
        pattern = { '*.md' },
        command = 'set filetype=markdown'
    },
    {
        events = { 'FileType' },
        pattern = { 'markdown', 'gitcommit' },
        command = 'setlocal spell'
    }
})
