" Disable netrw for neovim-tree
let g:loaded_netrw = 1
let g:loaded_netrwPlugin = 1

set ignorecase
set smartcase
" Substitute live preview
set inccommand=nosplit
" highlights cursorline with an underline
set cursorline

" Auto toggle smart case of for ex commands
" Assumes 'set ignorecase smartcase'
augroup dynamic_smartcase
 autocmd!
 autocmd CmdLineEnter : set nosmartcase
 autocmd CmdLineLeave : set smartcase
augroup END




augroup highlight_yank
    autocmd!
    au TextYankPost * silent! lua vim.highlight.on_yank{higroup="IncSearch", timeout=700}
augroup END



" 2021-05-26 to disable python2 provider
let g:loaded_python_provider = 0
" let g:loaded_python3_provider = 1

" let g:python3_host_prog = '/Users/mathu/.pyenv/versions/neovim3/bin/python3'
let g:python3_host_prog = '/Users/mathu/.pyenv/versions/neovim3/bin/python3'

" Show `▸▸` for tabs: 	, `·` for tailing whitespace: 
set list listchars=tab:▸▸,trail:·

" Enable mouse mode
set mouse=a

" Chage the colout of the cursot in terminal
if has('nvim')
  highlight! link TermCursor Cursor
  highlight! TermCursorNC guibg=red guifg=white ctermbg=1 ctermfg=15
endif

" disable header folding
let g:vim_markdown_folding_disabled = 1

" do not use conceal feature, the implementation is not so good
let g:vim_markdown_conceal = 0

" disable math tex conceal feature
let g:tex_conceal = ""
let g:vim_markdown_math = 1

" support front matter of various format
let g:vim_markdown_frontmatter = 1  " for YAML format
let g:vim_markdown_toml_frontmatter = 1  " for TOML format
let g:vim_markdown_json_frontmatter = 1  " for JSON format

let g:markdown_fenced_languages = ['html', 'python', 'bash=sh', 'vim', 'help']

""------------------------------------------------------------------------------
"" slime configuration 
""------------------------------------------------------------------------------
"" always use tmux
let g:slime_target = 'neovim'

"" fix paste issues in ipython
let g:slime_python_ipython = 1

"20191216 Add psql syntax highlighting 
let g:sql_type_default = 'pgsql'

" Allow switching between buffers without saving
set hidden

"If you want to open the nerdtree window when opening up Nvim, but put the cursor in the file-editing window, you can use the following setting:
"autocmd VimEnter * NERDTree | wincmd p

" Black - formatting settings 
let g:black_virtualenv = '/Users/mathu/.local/pipx/venvs/black/'
let g:black_linelength = 119

" Disable default fold of SimplyFold
set nofoldenable
" set foldenable
" autocmd BufReadPost,FileReadPost * normal zR


" 2018-08029 Mathu: show line nuber
"set relativenumber
set number

"20191123 https://github.com/jeffkreeftmeijer/neovim-sensible/blob/master/plugin/neovim-sensible.vim
" Use "hybrid" (both absolute and relative) line numbers
" set number relativenumber
"
" Autocomplete with dictionary words when spell check is on
" This doesn't seem to work.
set complete+=kspell

let g:ale_linters = {
\   'markdown': ['languagetool'],
\}

" Only run linters named in ale_linters settings.
let g:ale_linters_explicit = 1

""""""""""""""""""""""""vim-grammarous settings""""""""""""""""""""""""""""""

"I want to use system global LanguageTool command
"let g:grammarous#languagetool_cmd = 'languagetool'
let g:grammarous#languagetool_cmd = 'languagetool --level PICKY'

let g:grammarous#disabled_rules = {
         \ '*' : ['WHITESPACE_RULE', 'EN_QUOTES', 'ARROWS', 'SENTENCE_WHITESPACE',
         \        'WORD_CONTAINS_UNDERSCORE', 'COMMA_PARENTHESIS_WHITESPACE',
         \        'EN_UNPAIRED_BRACKETS', 'UPPERCASE_SENTENCE_START',
         \        'ENGLISH_WORD_REPEAT_BEGINNING_RULE', 'DASH_RULE', 'PLUS_MINUS',
         \        'PUNCTUATION_PARAGRAPH_END', 'MULTIPLICATION_SIGN', 'PRP_CHECKOUT',
         \        'CAN_CHECKOUT', 'SOME_OF_THE', 'DOUBLE_PUNCTUATION', 'HELL',
         \        'CURRENCY', 'POSSESSIVE_APOSTROPHE', 'ENGLISH_WORD_REPEAT_RULE',
         \        'NON_STANDARD_WORD'],
         \ }

"feret settings
" Don't bind ferret commands.
let g:FerretMap = 0

" Don't hide cursor line in quickfix.
let g:FerretQFOptions = 0

" LeaderF settings
let g:Lf_WindowPosition = 'popup'
let g:Lf_PreviewInPopup = 1



" " Do not use virtual text, they are far too obtrusive.
let g:lsp_virtual_text_enabled = 1


" " LSP settings END
"
" Or, you could use neovim's floating text feature.
let g:echodoc#enable_at_startup = 1
let g:echodoc#type = 'floating'
" To use a custom highlight for the float window,
" change Pmenu to your highlight group
highlight link EchoDocFloat Pmenu

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Add (Neo)Vim's native statusline support
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline
" set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}
" let g:airline#extensions#coc#enabled = 1

" END
"
" Gutentag START
" https://www.reddit.com/r/vim/comments/d77t6j/guide_how_to_setup_ctags_with_gutentags_properly/
" Specifically configure what a "new project" is for Gutentags.
let g:gutentags_add_default_project_roots = 0
let g:gutentags_project_root = ['package.json', '.git']

" Make Gutentags generate in most cases
let g:gutentags_generate_on_new = 1
let g:gutentags_generate_on_missing = 1
let g:gutentags_generate_on_write = 1
let g:gutentags_generate_on_empty_buffer = 0

" Let Gutentags generate more info for the tags.
let g:gutentags_ctags_extra_args = [
      \ '--tag-relative=yes',
      \ '--fields=+ailmnS',
      \ ]

" Making Gutentags faster by ignoring a lot of unnecessary filetypes.
let g:gutentags_ctags_exclude = [
      \ '*.git', '*.svg', '*.hg',
      \ '*/tests/*',
      \ 'build',
      \ 'dist',
      \ '*sites/*/files/*',
      \ 'bin',
      \ '.venv',
      \ '.env',
      \ '.vscode',
      \ '.idea',
      \ '.temp',
      \ '__pycache__',
      \ 'node_modules',
      \ 'bower_components',
      \ 'cache',
      \ 'compiled',
      \ 'docs',
      \ 'example',
      \ 'bundle',
      \ 'vendor',
      \ '*.md',
      \ '*-lock.json',
      \ '*.lock',
      \ '*bundle*.js',
      \ '*build*.js',
      \ '.*rc*',
      \ '*.json',
      \ '*.min.*',
      \ '*.map',
      \ '*.bak',
      \ '*.zip',
      \ '*.pyc',
      \ '*.class',
      \ '*.sln',
      \ '*.Master',
      \ '*.csproj',
      \ '*.tmp',
      \ '*.csproj.user',
      \ '*.cache',
      \ '*.pdb',
      \ 'tags*',
      \ 'cscope.*',
      \ '*.css',
      \ '*.less',
      \ '*.scss',
      \ '*.exe', '*.dll',
      \ '*.mp3', '*.ogg', '*.flac',
      \ '*.swp', '*.swo',
      \ '*.bmp', '*.gif', '*.ico', '*.jpg', '*.png',
      \ '*.rar', '*.zip', '*.tar', '*.tar.gz', '*.tar.xz', '*.tar.bz2',
      \ '*.pdf', '*.doc', '*.docx', '*.ppt', '*.pptx',
      \ ]

" END 
"

" https://github.com/neoclide/coc.nvim/issues/856
if $NVM_BIN != ""
  let g:coc_node_path = '$NVM_BIN/node'
endif


" Treesitter settings
set foldmethod=expr
set foldexpr=nvim_treesitter#foldexpr()

" test.vim settings
" make test commands execute using dispatch.vim
let test#strategy = "dispatch"


" Plugin works without this config
let test#python#runner = 'djangotest'
" let test#python#runner = 'pyunit'
" Runners available are 'pytest', 'nose', 'nose2', 'djangotest', 'djangonose', 'mamba', and Python's built-in unittest as 'pyunit'

" let test#python#djangotest#options = '--noinput --parallel 8'
" let test#python#djangotest#options = '--noinput'
"
" 20230418 TODO: check this configuration in favour of adtrac project
" let test#python#djangotest#options = {
"   \ 'all': '--noinput',
"   \ 'nearest': '--noinput --testrunner=stockspot.testrunner.NoDbTestRunner --keepdb',
"   \ 'file': '--noinput --testrunner=stockspot.testrunner.NoDbTestRunner --keepdb --parallel 4',
"   \ 'suite': '--parallel 8'
" \}

let test#python#djangotest#options = {
  \ 'all': '--noinput',
  \ 'nearest': '--noinput',
  \ 'file': '--noinput',
  \ 'suite': '--parallel'
\}

let test#python#djangotest#executable = 'python3 manage.py test'
" let test#python#djangotest#executable = 'docker-compose exec app python manage.py test'
" let test#python#djangotest#executable = 'docker exec -t dev_app_1 python manage.py test'

" map the python unittest compiler 'pyunit' for the executable python
" for 'python3' vim-dispatch picks it up automatically
let g:dispatch_compilers = {}
let g:dispatch_compilers['python'] = 'pyunit'
let g:dispatch_compilers['python3'] = 'pyunit'
" let g:dispatch_compilers['docker exec -t dev_app_1 python'] = 'pyunit'


" Use neovim-remote as default text editor if inside :terminal
if has('nvim') && executable('nvr')
  let $VISUAL="nvr -cc split --remote-wait +'set bufhidden=wipe'"
  " let $GIT_EDITOR = 'nvr -cc split --remote-wait' 
endif

" autocmd FileType gitcommit,gitrebase,gitconfig set bufhidden=delete

" Set default :vsplit to split right.
set splitright

" Show line numbers in search rusults
let g:any_jump_list_numbers = 1

" Amount of preview lines for each search result
let g:any_jump_preview_lines_count = 30

" Any-jump window size & position options
let g:any_jump_window_width_ratio  = 0.8
let g:any_jump_window_height_ratio = 0.8
let g:any_jump_window_top_offset   = 4

autocmd TermOpen * startinsert





" https://github.com/Xuyuanp/scrollbar.nvim
augroup ScrollbarInit
  autocmd!
  autocmd CursorMoved,VimResized,QuitPre * silent! lua require('scrollbar').show()
  autocmd WinEnter,FocusGained           * silent! lua require('scrollbar').show()
  autocmd WinLeave,BufLeave,BufWinLeave,FocusLost            * silent! lua require('scrollbar').clear()
augroup end


set autoread
