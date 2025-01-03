-- Aliases for easier setting management
local opt = vim.opt
local g = vim.g

-- Disable netrw for nvim-tree
g.loaded_netrw = 1
g.loaded_netrwPlugin = 1

-- Python provider settings
g.loaded_python_provider = 0  -- Disable Python 2 provider
g.python3_host_prog = '/Users/mathu/.pyenv/versions/neovim3/bin/python3'

-- General settings
opt.ignorecase = true
opt.smartcase = true
opt.inccommand = 'nosplit'  -- Live substitution preview
opt.cursorline = true
opt.mouse = 'a'
opt.hidden = true  -- Allow switching buffers without saving
opt.number = true
opt.complete:append('kspell')
opt.updatetime = 300
opt.splitright = true  -- Split windows right by default
opt.autoread = true

-- List characters
opt.list = true
opt.listchars = {
  tab = '▸▸',
  trail = '·'
}

-- Folding
opt.foldmethod = 'expr'
opt.foldexpr = 'nvim_treesitter#foldexpr()'
opt.foldenable = false

-- Markdown settings
g.vim_markdown_folding_disabled = 1
g.vim_markdown_conceal = 0
g.tex_conceal = ''
g.vim_markdown_math = 1
g.vim_markdown_frontmatter = 1
g.vim_markdown_toml_frontmatter = 1
g.vim_markdown_json_frontmatter = 1
g.markdown_fenced_languages = {'html', 'python', 'bash=sh', 'vim', 'help'}

-- Slime configuration
g.slime_target = 'neovim'
g.slime_python_ipython = 1

-- SQL settings
g.sql_type_default = 'pgsql'

-- Black formatter settings
g.black_virtualenv = '/Users/mathu/.local/pipx/venvs/black/'
g.black_linelength = 119

-- ALE settings
g.ale_linters = {
  markdown = {'languagetool'}
}
g.ale_linters_explicit = 1

-- Grammarous settings
g.grammarous = {
  languagetool_cmd = 'languagetool --level PICKY',
  disabled_rules = {
    ['*'] = {
      'WHITESPACE_RULE', 'EN_QUOTES', 'ARROWS', 'SENTENCE_WHITESPACE',
      'WORD_CONTAINS_UNDERSCORE', 'COMMA_PARENTHESIS_WHITESPACE',
      'EN_UNPAIRED_BRACKETS', 'UPPERCASE_SENTENCE_START',
      'ENGLISH_WORD_REPEAT_BEGINNING_RULE', 'DASH_RULE', 'PLUS_MINUS',
      'PUNCTUATION_PARAGRAPH_END', 'MULTIPLICATION_SIGN', 'PRP_CHECKOUT',
      'CAN_CHECKOUT', 'SOME_OF_THE', 'DOUBLE_PUNCTUATION', 'HELL',
      'CURRENCY', 'POSSESSIVE_APOSTROPHE', 'ENGLISH_WORD_REPEAT_RULE',
      'NON_STANDARD_WORD'
    }
  }
}

-- LeaderF settings
g.Lf_WindowPosition = 'popup'
g.Lf_PreviewInPopup = 1

-- LSP and echodoc settings
g.lsp_virtual_text_enabled = 1
g.echodoc = {
  enable_at_startup = 1,
  type = 'floating'
}

-- Gutentags settings
g.gutentags_add_default_project_roots = 0
g.gutentags_project_root = {'package.json', '.git'}
g.gutentags_generate_on_new = 1
g.gutentags_generate_on_missing = 1
g.gutentags_generate_on_write = 1
g.gutentags_generate_on_empty_buffer = 0
g.gutentags_ctags_extra_args = {'--tag-relative=yes', '--fields=+ailmnS'}
g.gutentags_ctags_exclude = {
  '*.git', '*.svg', '*.hg', '*/tests/*', 'build', 'dist',
  '*sites/*/files/*', 'bin', 'node_modules', 'bower_components',
  'cache', 'compiled', 'docs', 'example', 'bundle', 'vendor',
  '*.md', '*-lock.json', '*.lock', '*bundle*.js', '*build*.js',
  '.*rc*', '*.json', '*.min.*', '*.map', '*.bak', '*.zip',
  '*.pyc', '*.class', '*.sln', '*.Master', '*.csproj', '*.tmp',
  '*.csproj.user', '*.cache', '*.pdb', 'tags*', 'cscope.*',
  '*.css', '*.less', '*.scss', '*.exe', '*.dll', '*.mp3',
  '*.ogg', '*.flac', '*.swp', '*.swo', '*.bmp', '*.gif',
  '*.ico', '*.jpg', '*.png', '*.rar', '*.zip', '*.tar',
  '*.tar.gz', '*.tar.xz', '*.tar.bz2', '*.pdf', '*.doc',
  '*.docx', '*.ppt', '*.pptx'
}

-- Test.vim settings
g['test#strategy'] = 'dispatch'
g['test#python#runner'] = 'djangotest'
g['test#python#djangotest#options'] = {
  all = '--noinput',
  nearest = '--noinput',
  file = '--noinput',
  suite = '--parallel'
}
g['test#python#djangotest#executable'] = 'python3 manage.py test'

-- Dispatch compiler settings
g.dispatch_compilers = {
  python = 'pyunit',
  python3 = 'pyunit'
}

-- Any-jump settings
g.any_jump_list_numbers = 1
g.any_jump_preview_lines_count = 30
g.any_jump_window_width_ratio = 0.8
g.any_jump_window_height_ratio = 0.8
g.any_jump_window_top_offset = 4

-- Neovim-remote settings
if vim.fn.has('nvim') == 1 and vim.fn.executable('nvr') == 1 then
  vim.env.VISUAL = "nvr -cc split --remote-wait +'set bufhidden=wipe'"
end

-- Autocommands
local create_augroup = vim.api.nvim_create_augroup
local create_autocmd = vim.api.nvim_create_autocmd

-- Dynamic smartcase for command line
local dynamic_smartcase = create_augroup('dynamic_smartcase', { clear = true })
create_autocmd('CmdLineEnter', {
  group = dynamic_smartcase,
  pattern = ':',
  callback = function() opt.smartcase = false end
})
create_autocmd('CmdLineLeave', {
  group = dynamic_smartcase,
  pattern = ':',
  callback = function() opt.smartcase = true end
})

-- Highlight on yank
local highlight_yank = create_augroup('highlight_yank', { clear = true })
create_autocmd('TextYankPost', {
  group = highlight_yank,
  callback = function()
    vim.highlight.on_yank({ higroup = 'IncSearch', timeout = 700 })
  end
})

-- Terminal settings
create_autocmd('TermOpen', {
  pattern = '*',
  command = 'startinsert'
})

-- Highlight EchoDoc float window
vim.cmd([[highlight link EchoDocFloat Pmenu]])

-- opt.termguicolors = true -- Enable true color support
-- opt.clipboard = "unnamedplus" -- Use system clipboard
-- opt.mouse = "a" -- Enable mouse support
-- opt.undofile = true -- Enable persistent undo
-- opt.ignorecase = true -- Ignore case in search
-- opt.smartcase = true -- Override ignorecase if search pattern has uppercase
