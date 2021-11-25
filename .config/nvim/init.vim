"20180801 (Mathu) My very first vimrc config
"https://sheerun.net/2014/03/21/how-to-boost-your-vim-productivity/
"20190704: Based on https://stackoverflow.com/questions/2287440/how-to-do-case-insensitive-search-in-vim
"To ignore case 
"Case insensitive searching
set ignorecase
"Will automatically switch to case sensitive if you use any capitals
set smartcase


" Auto toggle smart case of for ex commands
" Assumes 'set ignorecase smartcase'
augroup dynamic_smartcase
 autocmd!
 autocmd CmdLineEnter : set nosmartcase
 autocmd CmdLineLeave : set smartcase
augroup END


" Substitute live preview
set inccommand=nosplit

" 20191123 
" highlights cursorline with an underline
set cursorline
" Highlight the line on which the cursor lives(research)
" set nocursorline

"" Marker fold method(research)
" 20210312
" set foldmethod=marker
" set foldmethod=syntax


" 2019-05-27 Mathu: to make python auto complete work with virtual
" environments
" let g:python_host_prog = 'python'
" let g:python3_host_prog = 'python3'

"
" Specify a directory for plugins
" - For Neovim: ~/.local/share/nvim/plugged
" - Avoid using standard Vim directory names like 'plugin'
" call plug#begin('~/.vim/plugged')

" Function to condionally install pluging
" https://github.com/asvetliakov/vscode-neovim/issues/415
function! Cond(Cond, ...)
    let opts = get(a:000, 0, {})
    return a:Cond ? opts : extend(opts, { 'on': [], 'for': [] })
endfunction

call plug#begin('~/.local/share/nvim/plugged')

Plug 'nathom/filetype.nvim'

Plug 'easymotion/vim-easymotion', Cond(!exists('g:vscode'))
Plug 'asvetliakov/vim-easymotion', Cond(exists('g:vscode'), { 'as': 'vsc-easymotion' })

" fzf + ripgrep setup for fuzzy search
" Using brew locaion below so that it can be kept updated
Plug '/opt/homebrew/opt/fzf'
" Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
" This is required to make other fzf feature available within vim
Plug 'junegunn/fzf.vim'

"Automatic quote and bracket completion
Plug 'jiangmiao/auto-pairs'




"code auto-format plugin
Plug 'sbdchd/neoformat'

"" Black code formatter
""Plug 'python/black'
" Plug 'psf/black'
Plug 'psf/black', { 'branch': 'main' }

" For code folding
" Plug 'tmhedberg/SimpylFold'

" For pyhon isort: use command :Isort
" Plug 'fisadev/vim-isort'

Plug 'machakann/vim-highlightedyank'

if !exists('g:vscode')
    " " 2019-05-30 Disabling all below for jedi vim (use either this or jedi-vim
    " " Make sure you use single quotes
    " " 20200228 deoplete version 5.2 because the latest version requires msgpack==1.0.0+ and that doesn't seem to work.
    " if has('nvim')
    "   " Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
    "   Plug 'Shougo/deoplete.nvim', { 'tag': '5.2','do': ':UpdateRemotePlugins' }
    " else
    "   Plug 'Shougo/deoplete.nvim', { 'tag': '5.2' }
    "   " Plug 'Shougo/deoplete.nvim'
    "   Plug 'roxma/nvim-yarp'
    "   Plug 'roxma/vim-hug-neovim-rpc'
    " endif
    " Plug 'prabirshrestha/vim-lsp'
    " Plug 'Shougo/deoplete.nvim'
    " Plug 'lighttiger2505/deoplete-vim-lsp'
    " User coc.vim instead
    Plug 'neoclide/coc.nvim', {'branch': 'release'}
    
    Plug 'ludovicchabant/vim-gutentags'
    
    Plug 'chriskempson/base16-vim'

    " Displays function signatures from completions
    Plug 'Shougo/echodoc.vim'

    Plug 'junegunn/seoul256.vim'
    Plug 'joshdick/onedark.vim'

    " Plug 'sheerun/vim-polyglot'
    
    " https://github.com/airblade/vim-gitgutter
    Plug 'airblade/vim-gitgutter'
    " Plug 'mhinz/vim-signify'
    
    "comment plugin
    "Plug 'scrooloose/nerdcommenter'
    "20191125
    Plug 'tpope/vim-commentary'
    
    " " (-/+)2019-05-30 Disabling deoplete for jedi-vim
    " " Git hug address is different now
    " " Plug 'zchee/deoplete-jedi'
    " Plug 'deoplete-plugins/deoplete-jedi'
    
    " " Code jump (go-to) plugin
    " Plug 'davidhalter/jedi-vim'
    
    " Firenvim config: https://jdhao.github.io/2020/01/01/firenvim_nvim_inside_browser/
    " Disable vim-airline when firenvim starts since vim-airline takes two lines.
    "Status bar plugin: vim-airline
    if !exists('g:started_by_firenvim')
        Plug 'vim-airline/vim-airline'
        Plug 'vim-airline/vim-airline-themes'
    endif
    
    
    
    " File managing and exploration plugin
    " Plug 'scrooloose/nerdtree'
    
    " For linting
    Plug 'neomake/neomake'
    
    
    
    
    " https://medium.com/@schtoeffel/you-don-t-need-more-than-one-cursor-in-vim-2c44117d51db
    " 2019-11-25 no longer need as the same can be achieve using native vim commands.
    " hmm, seems vim-multiple-cursons does much more than what the aboe medius
    " posts suggest
    " Multiple cursor editing plugin
    " Plug 'terryma/vim-multiple-cursors'
    " check this our later and vim-multi-cursor is not longer maintianed
    Plug 'mg979/vim-visual-multi', {'branch': 'master'}
    
    " Git wrapper
    Plug 'tpope/vim-fugitive'
    " Fugitive Gbrowse handler
    " Doesn't seem to work
    " A git commit browser in Vim
    Plug 'junegunn/gv.vim'
    
    
    Plug 'tpope/vim-surround'
    
    " colorschema dracula
    Plug 'dracula/vim', { 'as': 'dracula' }
    
    " clolorscheme
    " Plug 'morhetz/gruvbox'
    " Seems to be faster/better than gruvbox
    " https://github.com/lifepillar/vim-gruvbox8/blob/master/Readme.md
    Plug 'lifepillar/vim-gruvbox8'
    
    
    " Advanced neovim terminal handling
    Plug 'kassio/neoterm'
    
    "Python semantic syntax highlighting (may slow down with deoplete)
    "https://github.com/numirias/semshi#semshi-is-slow-together-with-deopletenvim
    " Plug 'numirias/semshi', {'do': ':UpdateRemotePlugins'}
    
    
    "Adds file type icons (This is supposed to the last plugin)
    Plug 'ryanoasis/vim-devicons'
    
    
    "20191122 Smooth scrolling
    Plug 'psliwka/vim-smoothie'
    
    " 20191125 Markdown perview
    " https://jdhao.github.io/2019/01/15/markdown_edit_preview_nvim/
    " Track the engine.
    Plug 'SirVer/ultisnips'
    " Snippets are separated from the engine. Add this if you want them:
    Plug 'honza/vim-snippets'
    
    
    "20191125
    " Plug 'godlygeek/tabular'
    Plug 'plasticboy/vim-markdown'
    
    " Plug 'cespare/vim-toml'
    
    Plug 'editorconfig/editorconfig-vim'
    
    " Plug 'lifepillar/pgsql.vim'
    
    " To have ipython like feature within vim
    " Plug 'jpalardy/vim-slime', { 'for': 'python' }
    " Plug 'hanschen/vim-ipython-cell', { 'for': 'python' }
    
    "integration with dash
    Plug 'rizzatti/dash.vim'
    
    "Jump to any definition and usages
    Plug 'pechorin/any-jump.nvim'
    
    " 20200929 Disabled for Black. Fix it.
    " Rg|fzf find and replace
    " Plug 'wincent/ferret'
    
    " Case sensitive find and replace
    Plug 'tpope/vim-abolish'
    
    " Modern database interface for Vim
    Plug 'tpope/vim-dadbod'
    " Simple UI for dadbod
    Plug 'kristijanhusak/vim-dadbod-ui'
    
    " speeddating.vim: use CTRL-A/CTRL-X to increment dates, times, and more
    Plug 'tpope/vim-speeddating'
    
    " https://github.com/sakhnik/nvim-gdb
    Plug 'sakhnik/nvim-gdb', { 'do': ':!./install.sh \| UpdateRemotePlugins' }
    
    " Plug 'freitass/todo.txt-vim'
    
    " Linter for grammar check
    " Plug 'dense-analysis/ale'
    
    Plug 'rhysd/vim-grammarous'
    
    Plug 'tpope/vim-unimpaired'
    
    Plug 'Yggdroot/LeaderF', { 'do': './install.sh' }
    
    Plug 'glacambre/firenvim', { 'do': { _ -> firenvim#install(0) } }
    
    " Plug 'hashrocket/vim-macdown'
    
    Plug 'tpope/vim-obsession'
    
    " Plug 'python-mode/python-mode', { 'for': 'python', 'branch': 'develop' }
    
    Plug 'ervandew/supertab'

    Plug 'elzr/vim-json'

    " Plug 'dbeniamine/cheat.sh-vim'

    " Replacement for NERDTree together with netrw
    Plug 'tpope/vim-vinegar'

    Plug 'wlemuel/vim-tldr'


    if !has("gui_vimr")
        " 20210529 Treesitter 
        Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
        Plug 'nvim-treesitter/playground'

        " 20210529 Telescope
        Plug 'nvim-lua/popup.nvim'
        Plug 'nvim-lua/plenary.nvim'
        Plug 'nvim-telescope/telescope.nvim'

        " 20210529 Popup show the keyboard shortcut
        Plug 'folke/which-key.nvim'

        Plug 'sudormrfbin/cheatsheet.nvim'
        Plug 'kyazdani42/nvim-web-devicons'

    endif

    Plug 'preservim/tagbar'

    Plug 'phaazon/hop.nvim', Cond(!exists('g:vscode'))

    Plug 'kshenoy/vim-signature'

    " Start up screen
    Plug 'mhinz/vim-startify'
    "For better commit message intrface
    " Disabled for neovim terminal
    " Plug 'rhysd/committia.vim'
    Plug 'junegunn/vim-plug'

    Plug 'tpope/vim-dispatch'
    Plug 'tpope/vim-dotenv'

    " Testing
    Plug 'janko-m/vim-test'
    "https://linuxtut.com/en/96d4cda9074f9719bc82/
    " Plug 'tlvince/vim-compiler-python'

    "debugging
    Plug 'puremourning/vimspector'

    " Plug 'rcarriga/vim-ultest', { 'do': ':UpdateRemotePlugins' }
    " Plug 'mfussenegger/nvim-dap'
    " Plug 'mfussenegger/nvim-dap-python'

    "TODO: you may want to remap the key away from <C-E> to reclaim cursor key
    Plug 'simeji/winresizer'

    Plug 'romainl/vim-devdocs'

    Plug 'tweekmonster/startuptime.vim'

    Plug 'mhartington/formatter.nvim'

    if has('nvim')
      Plug 'gelguy/wilder.nvim', { 'do': ':UpdateRemotePlugins' }
    else
      Plug 'gelguy/wilder.nvim'
    endif

    Plug 'Xuyuanp/scrollbar.nvim'

    if !has("gui_vimr")
        Plug 'kyazdani42/nvim-tree.lua'
    endif

    Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }

endif

" Initialize plugin system
" plugend
call plug#end()

lua <<EOF
-- Do not source the default filetype.vim
vim.g.did_load_filetypes = 1
EOF


let g:airline#extensions#tabline#enabled = 1

"Use 24-bit (true-color) mode in Vim/Neovim when outside tmux.
"If you're using tmux version 2.2 or later, you can remove the outermost $TMUX check and use tmux's 24-bit color support
"(see < http://sunaku.github.io/tmux-24bit-color.html#usage > for more information.)
if (has("nvim"))
  "For Neovim 0.1.3 and 0.1.4 < https://github.com/neovim/neovim/pull/2198 >
  let $NVIM_TUI_ENABLE_TRUE_COLOR=1
endif
"For Neovim > 0.1.5 and Vim > patch 7.4.1799 < https://github.com/vim/vim/commit/61be73bb0f965a895bfb064ea3e55476ac175162 >
"Based on Vim patch 7.4.1770 (`guicolors` option) < https://github.com/vim/vim/commit/8a633e3427b47286869aa4b96f2bfc1fe65b25cd >
" < https://github.com/neovim/neovim/wiki/Following-HEAD#20160511 >
if (has("termguicolors"))
  set termguicolors
endif

"onedark.vim override: Set a custom background color in the terminal
if (has("autocmd") && !has("gui_running"))
  augroup colors
    autocmd!
    " let s:background = { "gui": "#282C34", "cterm": "235", "cterm16": "0" }
    let s:background = { "gui": "#191c1a", "cterm": "235", "cterm16": "0" }
    autocmd ColorScheme * call onedark#set_highlight("Normal", { "bg": s:background }) "No `fg` setting
  augroup END
endif

" syntax on

" VimR specific settings
if has("gui_vimr")
  " Here goes some VimR specific settings like
  " color iceberg 
  " color default 
  " set background=dark
  " syntax on
  " set termguicolors
  " colorscheme iceberg
  " colorscheme base16-dracula
  " colorscheme dracula
  colorscheme gruvbox8
  set background=light   " Setting light mode
" 20191124
else
  " colorscheme gruvbox8
  set termguicolors
  " seol256
  " " Unified color scheme (default: dark)
  " let g:seoul256_background = 233
  " colo seoul256
  " " onedark
  let g:onedark_termcolors=256
  colorscheme onedark
  " syntax on
endif


""" NERDTree configuration
"let g:NERDTreeIgnore=['\.rbc$', '\~$', '\.pyc$', '\.db$', '\.sqlite$', '__pycache__']
"let g:NERDTreeSortOrder=['^__\.py$', '\/$', '*', '\.swp$', '\.bak$', '\~$']
"let g:nerdtree_tabs_focus_on_files=1
"let g:NERDTreeWinSize = 35
""let g:NERDTreeChDirMode=2

augroup my_neomake_signs
    au!
    autocmd ColorScheme *
        \ hi NeomakeError ctermfg=red |
        \ hi NeomakeWarning ctermfg=yellow |
        \ hi NeomakeInfo ctermfg=white |
        \ hi NeomakeMessage ctermfg=white
augroup END

" grep.vim
" https://pastebin.com/u2TA9hUp
"nnoremap <silent> <leader>s :Rgrep<CR>
"let Grep_Default_Options = '-IR'
"let Grep_Skip_Files = '*.log *.db'
"let Grep_Skip_Dirs = '.git node_modules'

" Highlighted yank (-1 for persistent)
let g:highlightedyank_highlight_duration = 1000
"highlight HighlightedyankRegion cterm=reverse gui=reverse

" let g:deoplete#enable_at_startup = 1
" Disable deoplete preview window
" set completeopt-=preview

" 2021-05-26 to disable python2 provider
" let g:loaded_python_provider = 0

" 2019-05-27 Mathu: to make python auto complete work with virtual
" environments
" https://github.com/deoplete-plugins/deoplete-jedi/wiki/Setting-up-Python-for-Neovim
"let g:python_host_prog = '/usr/bin/python2.7'
let g:python_host_prog = '/Users/mathu/.pyenv/versions/neovim2/bin/python'
" let g:python_host_prog = '/Users/mathu/.pyenv/shims/python'
" let g:python_host_prog = ''
"let g:python3_host_prog = 'python3'
" let g:python3_host_prog = '/Users/mediushealth/.pyenv/versions/neovim3/bin/python'
let g:python3_host_prog = '/Users/mathu/.pyenv/versions/neovim39/bin/python'

" Jedi-Vim settings just got code jumping
" disable autocompletion, cause we use deoplete for completion
let g:jedi#completions_enabled = 0

" 20191108 Remap the leader from default \ to <space)
let mapleader = "\<Space>"

" https://github.com/jeffkreeftmeijer/neovim-sensible/blob/master/plugin/neovim-sensible.vim
" Use ,, to switch between buffers
nnoremap ,, :b#<CR>

" Show `▸▸` for tabs: 	, `·` for tailing whitespace: 
set list listchars=tab:▸▸,trail:·

" Enable mouse mode
set mouse=a


" Mapping similar to CtrlP extension
" nnoremap <C-p> :Files<Cr>

" Copy & paste to system clipboard with <Space>p and <Space>y
" https://sheerun.net/2014/03/21/how-to-boost-your-vim-productivity/
vmap <Leader>y "+y
vmap <Leader>d "+d
nmap <Leader>p "+p
nmap <Leader>P "+P
vmap <Leader>p "+p
vmap <Leader>P "+P

" Type <Space>w to save file (a lot faster than :w<Enter>):
nnoremap <Leader>w :w<CR>

nnoremap <Leader>e :LeaderfMruCwd<CR>

" open the go-to function in split, not another buffer
let g:jedi#use_splits_not_buffers = "right"

"https://jdhao.github.io/2018/09/10/nerdtree_usage/
"For example, imitating the way Sublime Text opens the side bar, we can use this setting:
"20191122 Had to turn it off sue to tmux prefix shortcut
"nnoremap <silent> <C-k><C-B> :NERDTreeToggle<CR>
" Changed to Ctrl + s as the previous one doesn't work after some other
" plugins. Investigate later. It didn't work because of Karabinar map
"nnoremap <silent> <C-s> :NERDTreeToggle<CR>
" nnoremap <Leader>b :NERDTreeToggle<CR>
"To map <Esc> to exit terminal-mode: >
if has('nvim')
  tnoremap <Esc> <C-\><C-n>
  tnoremap <C-v><Esc> <Esc>
  tnoremap <expr> <C-R> '<C-\><C-N>"'.nr2char(getchar()).'pi'
  tnoremap <C-v><C-R> <C-R>
endif

" Chage the colout of the cursot in terminal
if has('nvim')
  highlight! link TermCursor Cursor
  highlight! TermCursorNC guibg=red guifg=white ctermbg=1 ctermfg=15
endif


" Clear search highlighting with Escape key
nnoremap <silent><esc> :noh<return><esc>

" Fugitive Conflict Resolution
nnoremap <leader>gd :Gvdiff<CR>
nnoremap gdh :diffget //2<CR>
nnoremap gdl :diffget //3<CR>
set diffopt+=vertical
nnoremap <leader>gb :Git blame<CR>

"20191122 Move line up and down
"https://vim.fandom.com/wiki/Moving_lines_up_or_down
nnoremap <A-j> :m .+1<CR>==
nnoremap <A-k> :m .-2<CR>==
inoremap <A-j> <Esc>:m .+1<CR>==gi
inoremap <A-k> <Esc>:m .-2<CR>==gi
vnoremap <A-j> :m '>+1<CR>gv=gv
vnoremap <A-k> :m '<-2<CR>gv=gv


" 20191125 https://jdhao.github.io/2019/01/15/markdown_edit_preview_nvim/
" Trigger configuration. Do not use <tab> if you use https://github.com/Valloric/YouCompleteMe.
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<C-j>"
let g:UltiSnipsJumpBackwardTrigger="<C-k>"

" 20191125 vim-markdown settings (START)
" https://jdhao.github.io/2019/01/15/markdown_edit_preview_nvim/
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
" (END)

""------------------------------------------------------------------------------
"" slime configuration 
""------------------------------------------------------------------------------
"" always use tmux
"let g:slime_target = 'tmux'

"" fix paste issues in ipython
"let g:slime_python_ipython = 1

"" always send text to the top-right pane in the current tmux tab without asking
"let g:slime_default_config = {
"	    \ 'socket_name': get(split($TMUX, ','), 0),
"	    \ 'target_pane': '{top-right}' }
"let g:slime_dont_ask_default = 1

""------------------------------------------------------------------------------
"" ipython-cell configuration
""------------------------------------------------------------------------------
"" Use '##' to define cells instead of using marks
"let g:ipython_cell_delimit_cells_by = 'tags'

"let g:markdown_fenced_languages = ['html', 'python', 'bash=sh']


"20191216 Add psql syntax highlighting 
let g:sql_type_default = 'pgsql'

" Allow switching between buffers without saving
set hidden

"If you want to open the nerdtree window when opening up Nvim, but put the cursor in the file-editing window, you can use the following setting:
"autocmd VimEnter * NERDTree | wincmd p

" Black - formatting settings 
let g:black_virtualenv = '/Users/mathu/.local/pipx/venvs/black/'
let g:black_linelength = 119
" TODO
"autocmd BufWritePre *.py execute ':Black'

"neomake linting
" Neomake automatic mode
call neomake#configure#automake('nrwi', 500)
"let g:neomake_python_enabled_makers = ['pylint']
let g:neomake_python_enabled_makers = ['flake8']

"20191122 https://github.com/neomake/neomake/issues/245
let g:neomake_error_sign = {
 \ 'text': '✖',
 \ 'texthl': 'NeomakeErrorSign',
 \ }
let g:neomake_warning_sign = {
 \   'text': '‼',
 \   'texthl': 'NeomakeWarningSign',
 \ }
let g:neomake_message_sign = {
  \   'text': '➤',
  \   'texthl': 'NeomakeMessageSign',
  \ }
let g:neomake_info_sign = {
  \ 'text': 'ℹ',
  \ 'texthl': 'NeomakeInfoSign'
  \ }

":highlight NeomakeErrorMsg ctermfg=227 ctermbg=237
let g:neomake_warning_sign={'text': '⚠', 'texthl': 'NeomakeErrorMsg'}

"20191122 Semshi settingas
"https://soduu.com/numirias/semshi
" let g:semshi#error_sign = v:false
" Not to slow down semshi together with deoplete
" https://soduu.com/numirias/semshi#semshi-is-slow-together-with-deopletenvim
" let g:deoplete#auto_complete_delay = 100


"To show the buffer no next to file name
"https://jdhao.github.io/2018/09/29/Switching_buffers_quickly_Neovim/
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#buffer_nr_show = 1

" Disable default fold of SimplyFold
set nofoldenable

" 2018-08029 Mathu: show line nuber
"set relativenumber
"set number

"20191123 https://github.com/jeffkreeftmeijer/neovim-sensible/blob/master/plugin/neovim-sensible.vim
" Use "hybrid" (both absolute and relative) line numbers
set number relativenumber

" 2019-05-31 Auto close the preview window of jedi-deoplete
" https://jdhao.github.io/2018/12/24/centos_nvim_install_use_guide_en/
autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | pclose | endif

" https://pastebin.com/FjdkegRH
" https://www.reddit.com/r/neovim/comments/7r85hs/how_do_i_toggle_terminal_window/
" Toggle 'default' terminal
nnoremap <M-`> :call ChooseTerm("term-slider", 1)<CR>
" Start terminal in current pane
nnoremap <M-CR> :call ChooseTerm("term-pane", 0)<CR>
 
function! ChooseTerm(termname, slider)
    let pane = bufwinnr(a:termname)
    let buf = bufexists(a:termname)
    if pane > 0
        " pane is visible
        if a:slider > 0
            :exe pane . "wincmd c"
        else
            :exe "e #"
        endif
    elseif buf > 0
        " buffer is not in pane
        if a:slider
            " :exe "topleft split"
            :exe "belowright vsplit"
        endif
        :exe "buffer " . a:termname
    else
        " buffer is not loaded, create
        if a:slider
            " :exe "topleft split"
            :exe "belowright vsplit"
        endif
        :terminal
        :exe "f " a:termname
    endif
endfunction

"20191105 https://gist.github.com/ram535/b1b7af6cd7769ec0481eb2eed549ea23
" With this function you can reuse the same terminal in neovim.
" You can toggle the terminal and also send a command to the same terminal.

let s:monkey_terminal_window = -1
let s:monkey_terminal_buffer = -1
let s:monkey_terminal_job_id = -1

function! MonkeyTerminalOpen()
  " Check if buffer exists, if not create a window and a buffer
  if !bufexists(s:monkey_terminal_buffer)
    " Creates a window call monkey_terminal
    new monkey_terminal
    " Moves to the window the right the current one
    wincmd L
    let s:monkey_terminal_job_id = termopen($SHELL, { 'detach': 1 })

     " Change the name of the buffer to "Terminal 1"
     silent file Terminal\ 1
     " Gets the id of the terminal window
     let s:monkey_terminal_window = win_getid()
     let s:monkey_terminal_buffer = bufnr('%')

    " The buffer of the terminal won't appear in the list of the buffers
    " when calling :buffers command
    set nobuflisted
  else
    if !win_gotoid(s:monkey_terminal_window)
    sp
    " Moves to the window below the current one
    wincmd L   
    buffer Terminal\ 1
     " Gets the id of the terminal window
     let s:monkey_terminal_window = win_getid()
    endif
  endif
endfunction

function! MonkeyTerminalToggle()
  if win_gotoid(s:monkey_terminal_window)
    call MonkeyTerminalClose()
  else
    call MonkeyTerminalOpen()
  endif
endfunction

function! MonkeyTerminalClose()
  if win_gotoid(s:monkey_terminal_window)
    " close the current window
    hide
  endif
endfunction

function! MonkeyTerminalExec(cmd)
  if !win_gotoid(s:monkey_terminal_window)
    call MonkeyTerminalOpen()
  endif

  " clear current input
  call jobsend(s:monkey_terminal_job_id, "clear\n")

  " run cmd
  call jobsend(s:monkey_terminal_job_id, a:cmd . "\n")
  normal! G
  wincmd p
endfunction

" 20191120 https://vim.fandom.com/wiki/Diff_current_buffer_and_the_original_file
function! s:DiffWithSaved()
  let filetype=&ft
  diffthis
  vnew | r # | normal! 1Gdd
  diffthis
  exe "setlocal bt=nofile bh=wipe nobl noswf ro ft=" . filetype
endfunction
com! DiffSaved call s:DiffWithSaved()

" Search lines in all open vim buffers
function! s:line_handler(l)
  let keys = split(a:l, ':\t')
  exec 'buf' keys[0]
  exec keys[1]
  normal! ^zz
endfunction

function! s:buffer_lines()
  let res = []
  for b in filter(range(1, bufnr('$')), 'buflisted(v:val)')
    call extend(res, map(getbufline(b,0,"$"), 'b . ":\t" . (v:key + 1) . ":\t" . v:val '))
  endfor
  return res
endfunction

command! FZFLines call fzf#run({
\   'source':  <sid>buffer_lines(),
\   'sink':    function('<sid>line_handler'),
\   'options': '--extended --nth=3..',
\   'down':    '60%'
\})

" 20191219 RipGrep search hidden files
command! -bang -nargs=* Rgh
  \ call fzf#vim#grep(
  \   'rg --hidden --no-ignore-vcs --column --line-number --no-heading --color=always --smart-case '.shellescape(<q-args>), 1,
  \   fzf#vim#with_preview(), <bang>0)

" RipGrep with preview
command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always --smart-case '.shellescape(<q-args>), 1,
  \   fzf#vim#with_preview(), <bang>0)

" Add preview to Files command 
command! -bang -nargs=? -complete=dir FilesP
    \ call fzf#vim#files(<q-args>, fzf#vim#with_preview(), <bang>0)

command! -bang -nargs=? -complete=dir FilesP2
    \ call fzf#vim#files(<q-args>, fzf#vim#with_preview({'options': ['--layout=reverse', '--info=inline']}), <bang>0)

command! -bang -nargs=* PRg
  \ call fzf#vim#grep("rg --column --line-number --no-heading --color=always --smart-case ".shellescape(<q-args>), 1, {'dir': system('git rev-parse --show-toplevel 2> /dev/null')[:-2]}, <bang>0)

" git grep wrapper
command! -bang -nargs=* GGrep
  \ call fzf#vim#grep(
  \   'git grep --line-number -- '.shellescape(<q-args>), 0,
  \   fzf#vim#with_preview({'dir': systemlist('git rev-parse --show-toplevel')[0]}), <bang>0)

" Advanced ripgrep integration
function! RipgrepFzf(query, fullscreen)
  let command_fmt = 'rg --column --line-number --no-heading --color=always --smart-case -- %s || true'
  let initial_command = printf(command_fmt, shellescape(a:query))
  let reload_command = printf(command_fmt, '{q}')
  let spec = {'options': ['--phony', '--query', a:query, '--bind', 'change:reload:'.reload_command]}
  call fzf#vim#grep(initial_command, 1, fzf#vim#with_preview(spec), a:fullscreen)
endfunction

command! -nargs=* -bang RG call RipgrepFzf(<q-args>, <bang>0)


" to close and delete all the other buffers
command! BufOnly silent! execute '%bd|e#|bd#|normal `"'
command! B silent! execute 'Buffers'

"With this maps you can now toggle the terminal
nnoremap <F7> :call MonkeyTerminalToggle()<cr>
tnoremap <F7> <C-\><C-n>:call MonkeyTerminalToggle()<cr>


"How can I navigate through the auto-completion list with Tab?
inoremap <expr><tab> pumvisible() ? "\<c-n>" : "\<tab>"

"Keymap to paste multiple times
xnoremap p pgvy

" https://gist.github.com/berinhard/523420/89ce9864ce60b9053b31c8a26a20ae0355892f3b
" Author: Bernardo Fontes <falecomigo@bernardofontes.net>
" Website: http://www.bernardofontes.net
" This code is based on this one: http://www.cmdln.org/wp-content/uploads/2008/10/python_ipdb.vim
" I worked with refactoring and it simplifies a lot the remove breakpoint feature.
" To use this feature, you just need to copy and paste the content of this file at your .vimrc file! Enjoy!
python << EOF
import vim
import re

# ipdb_breakpoint = 'import ipdb; ipdb.set_trace()'
ipdb_breakpoint = 'breakpoint()'

def set_breakpoint():
    breakpoint_line = int(vim.eval('line(".")')) - 1

    current_line = vim.current.line
    white_spaces = re.search('^(\s*)', current_line).group(1)

    vim.current.buffer.append(white_spaces + ipdb_breakpoint, breakpoint_line)
    vim.command(':w')

vim.command('map <f6> :py set_breakpoint()<cr>')

def remove_breakpoints():
    op = 'g/^.*%s.*/d' % ipdb_breakpoint
    vim.command(op)
    vim.command(':w')

vim.command('map <f5> :py remove_breakpoints()<cr>')
EOF

" Easier  split navigation
" nnoremap <C-J> <C-W><C-J>
" nnoremap <C-K> <C-W><C-K>
" nnoremap <C-L> <C-W><C-L>
" nnoremap <C-H> <C-W><C-H>

" normal mode
nnoremap <C-h> <c-w>h
nnoremap <C-j> <c-w>j
nnoremap <C-k> <c-w>k
nnoremap <C-l> <c-w>l
if has('nvim')
  " terminal mode
  tnoremap <C-h> <c-\><c-n><c-w>h
  tnoremap <C-j> <c-\><c-n><c-w>j
  tnoremap <C-k> <c-\><c-n><c-w>k
  tnoremap <C-l> <c-\><c-n><c-w>l
  " insert mode
  inoremap <C-h> <c-\><c-n><c-w>h
  inoremap <C-j> <c-\><c-n><c-w>j
  inoremap <C-k> <c-\><c-n><c-w>k
  inoremap <C-l> <c-\><c-n><c-w>l
  " Visual mode
  vnoremap <C-h> <c-\><c-n><c-w>h
  vnoremap <C-j> <c-\><c-n><c-w>j
  vnoremap <C-k> <c-\><c-n><c-w>k
  vnoremap <C-l> <c-\><c-n><c-w>l
endif

" dasbod, dadbod-ui
" let g:db = "postgresql://db_user:@localhost/db_name"

com! FormatJSON %!python -m json.tool
com! JQFormatJSON %!jq

" https://thoughtbot.com/blog/opt-in-project-specific-vim-spell-checking-and-word-completion
" Spell Check
autocmd BufRead,BufNewFile *.md set filetype=markdown

" Spell-check Markdown files
autocmd FileType markdown setlocal spell

" Spell-check Git messages
autocmd FileType gitcommit setlocal spell

" Ignore current buffer and around
" let g:deoplete#ignore_sources = {}
" let g:deoplete#ignore_sources._ = ['buffer', 'around']
"https://jdhao.github.io/2019/06/06/nvim_deoplete_settings/
" if has("gui_vimr")
" else
"     call deoplete#custom#option('ignore_sources', {'_': ['around', 'buffer']})
" endif
" " maximum candidate window length
" call deoplete#custom#source('_', 'max_menu_width', 80)

" Autocomplete with dictionary words when spell check is on
" This doesn't seem to work.
set complete+=kspell

let g:ale_linters = {
\   'markdown': ['languagetool'],
\}

" Only run linters named in ale_linters settings.
let g:ale_linters_explicit = 1


"I want to use system global LanguageTool command
let g:grammarous#languagetool_cmd = 'languagetool'

"feret settings
" Don't bind ferret commands.
let g:FerretMap = 0

" Don't hide cursor line in quickfix.
let g:FerretQFOptions = 0

" Bind our own Ferret commands.
nmap <leader>/ <Plug>(FerretAck)
nmap <leader>* <Plug>(FerretAckWord)

" LeaderF settings
let g:Lf_WindowPosition = 'popup'
let g:Lf_PreviewInPopup = 1


" https://jdhao.github.io/2019/06/06/nvim_deoplete_settings/
" call deoplete#custom#option('ignore_sources', {'_': ['around', 'buffer']})

" Firenvim config: https://jdhao.github.io/2020/01/01/firenvim_nvim_inside_browser/
" Disable vim-airline when firenvim starts since vim-airline takes two lines.

if exists('g:started_by_firenvim') && g:started_by_firenvim
    " general options
    set laststatus=0 nonumber noruler noshowcmd

    augroup firenvim
        autocmd!
        autocmd BufEnter *.txt setlocal filetype=markdown.pandoc
    augroup END
endif


if exists('g:vscode')
    xmap gc  <Plug>VSCodeCommentary
    nmap gc  <Plug>VSCodeCommentary
    omap gc  <Plug>VSCodeCommentary
    nmap gcc <Plug>VSCodeCommentaryLine
endif

" " LSP settings START
" " https://jdhao.github.io/2020/11/04/replace_deoplete_jedi_for_LSP/
" " settings for pyls
" if executable('pyls')
"     " pip install python-language-server
"     au User lsp_setup call lsp#register_server({
"         \ 'name': 'pyls',
"         \ 'cmd': {server_info->['pyls']},
"         \ 'allowlist': ['python'],
"         \ })
" endif

" function! s:on_lsp_buffer_enabled() abort
"     " use omnifunc if you are fine with it.
"     " setlocal omnifunc=lsp#complete
"     if exists('+tagfunc') | setlocal tagfunc=lsp#tagfunc | endif
"     " some mappings to use, tweak as you wish.
"     nmap <buffer> gd <plug>(lsp-definition)
"     nmap <buffer> gr <plug>(lsp-references)
"     nmap <buffer> gi <plug>(lsp-implementation)
"     nmap <buffer> gt <plug>(lsp-type-definition)
"     nmap <buffer> <leader>rn <plug>(lsp-rename)
"     nmap <buffer> [g <Plug>(lsp-previous-diagnostic)
"     nmap <buffer> ]g <Plug>(lsp-next-diagnostic)
"     nmap <buffer> K <plug>(lsp-hover)
" endfunction

" augroup lsp_install
"     au!
"     " call s:on_lsp_buffer_enabled only for languages that has the server registered.
"     autocmd User lsp_buffer_enabled call s:on_lsp_buffer_enabled()
" augroup END


" " whether to enable diagnostics for vim-lsp (we may want to use ALE for other
" " plugins for that.
" let g:lsp_diagnostics_enabled = 1

" " show diagnostic signs
" let g:lsp_signs_enabled = 1
" let g:lsp_signs_error = {'text': '✗'}
" let g:lsp_signs_warning = {'text': '!'}
" let g:lsp_highlights_enabled = 0

" " Do not use virtual text, they are far too obtrusive.
" let g:lsp_virtual_text_enabled = 0
" " echo a diagnostic message at cursor position
" let g:lsp_diagnostics_echo_cursor = 0
" " show diagnostic in floating window
" let g:lsp_diagnostics_float_cursor = 1
" " whether to enable highlight a symbol and its references
" let g:lsp_highlight_references_enabled = 1
" let g:lsp_preview_max_width = 80

" " flake8 specific settings
" " https://jdhao.github.io/2020/11/05/pyls_flake8_setup/
" if executable('pyls')
"     " pip install python-language-server
"     au User lsp_setup call lsp#register_server({
"           \ 'name': 'pyls',
"           \ 'cmd': {server_info->['pyls']},
"           \ 'allowlist': ['python'],
"           \ 'workspace_config': {
"           \    'pyls':
"           \        {'configurationSources': ['flake8'],
"           \         'plugins': {'flake8': {'enabled': v:true},
"           \                     'pyflakes': {'enabled': v:false},
"           \                     'pycodestyle': {'enabled': v:false},
"           \                    }
"           \         }
"           \ }})
" endif


" " LSP settings END
"
" Or, you could use neovim's floating text feature.
let g:echodoc#enable_at_startup = 1
let g:echodoc#type = 'floating'
" To use a custom highlight for the float window,
" change Pmenu to your highlight group
highlight link EchoDocFloat Pmenu


" gb, gB for switching between buffers START
"  https://jdhao.github.io/2020/10/16/nvim_switch_buffer_with_mapping/
nnoremap <silent> gb :<C-U>call <SID>GoToBuffer(v:count, 'forward')<CR>
nnoremap <silent> gB :<C-U>call <SID>GoToBuffer(v:count, 'backward')<CR>

function! s:GoToBuffer(count, direction) abort
  if a:count == 0
    if a:direction ==# 'forward'
      bnext
    elseif a:direction ==# 'backward'
      bprevious
    else
      echoerr 'Bad argument ' a:direction
    endif
    return
  endif
  " Check the validity of buffer number.
  if index(s:GetBufNums(), a:count) == -1
    echohl WarningMsg | echomsg 'Invalid bufnr: ' a:count | echohl None
    return
  endif

  if a:direction ==# 'forward'
    silent execute('buffer' . a:count)
  endif
endfunction

function! s:GetBufNums() abort
  let l:buf_infos = getbufinfo({'buflisted':1})
  let l:buf_nums = map(l:buf_infos, "v:val['bufnr']")
  return l:buf_nums
endfunction
" END
"
" CoC config START
" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
" Looks like coc-jedi still doesn't support this. check back later.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType python,typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300
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

" shortcuts for Tags
nnoremap <Leader>t :BTags<CR>

" PLUGIN: FZF
" https://dev.to/iggredible/how-to-search-faster-in-vim-with-fzf-vim-36ko
" nnoremap <silent> <Leader>b :Buffers<CR>
" nnoremap <silent> <C-f> :Files<CR>
" nnoremap <silent> <Leader>f :Rg<CR>
" nnoremap <silent> <Leader>/ :BLines<CR>
" nnoremap <silent> <Leader>' :Marks<CR>
" nnoremap <silent> <Leader>g :Commits<CR>
" nnoremap <silent> <Leader>H :Helptags<CR>
nnoremap <silent> <Leader>hh :History<CR>
nnoremap <silent> <Leader>h: :History:<CR>
nnoremap <silent> <Leader>h/ :History/<CR> 
set rtp+=/opt/homebrew/opt/fzf

" https://github.com/neoclide/coc.nvim/issues/856
if $NVM_BIN != ""
  let g:coc_node_path = '$NVM_BIN/node'
endif

" nvim-treesitter config (START)
if !has("gui_vimr")
lua <<EOF
require'nvim-treesitter.configs'.setup {
  highlight = {
    enable = true,
    custom_captures = {
      -- Highlight the @foo.bar capture group with the "Identifier" highlight group.
      ["foo.bar"] = "Identifier",
    },
  },
}
EOF

lua <<EOF
require'nvim-treesitter.configs'.setup {
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = "gnn",
      node_incremental = "grn",
      scope_incremental = "grc",
      node_decremental = "grm",
    },
  },
}
EOF

lua <<EOF
require'nvim-treesitter.configs'.setup {
  indent = {
    enable = true
  }
}
EOF

set foldmethod=expr
set foldexpr=nvim_treesitter#foldexpr()
" nvim-treesitter config (END)

" 20210529 Telescope.nvim config
" Find files using Telescope command-line sugar.
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>

command L Telescope

" 20210529 Whichkay
lua << EOF
  require("which-key").setup {
    -- your configuration comes here
    -- or leave it empty to use the default settings
    -- refer to the configuration section below
  }
EOF


"web-devicon setup
lua << EOF
  require'nvim-web-devicons'.setup {
   -- your personnal icons can go here (to override)
   -- DevIcon will be appended to `name`
   override = {
    zsh = {
      icon = "",
      color = "#428850",
      name = "Zsh"
    }
   };
   -- globally enable default icons (default to false)
   -- will get overriden by `get_icons` option
   default = true;
  }

  require'nvim-web-devicons'.get_icon(filename, extension, options)
EOF

endif

" python tagbar
nmap <F8> :TagbarToggle<CR>

" " Toggle tagbar statusline
" " This doesn't seem to work
" " https://stackoverflow.com/questions/33699049/display-current-function-in-vim-status-line
" command! -nargs=0 TagbarToggleStatusline call TagbarToggleStatusline()
" " nnoremap <silent> <c-F12> :TagbarToggleStatusline<CR>
" function! TagbarToggleStatusline()
"    let tStatusline = '%{exists(''*tagbar#currenttag'')?
"             \tagbar#currenttag(''     [%s] '',''''):''''}'
"    if stridx(&statusline, tStatusline) != -1
"       let &statusline = substitute(&statusline, '\V'.tStatusline, '', '')
"    else
"       let &statusline = substitute(&statusline, '\ze%=%-', tStatusline, '')
"    endif
" endfunction

" filetype plugin indent on
" syntax on
" au User AirlineAfterInit let g:airline_section_x = airline#section#create_right(['tagbar'])

" :Rg exlucde files name match
" https://github.com/junegunn/fzf.vim/issues/714#issuecomment-428802659
" command! -bang -nargs=* Rg call fzf#vim#grep("rg --column --line-number --no-heading --color=always --smart-case ".shellescape(<q-args>), 1, {'options': '--delimiter : --nth 4..'}, <bang>0)

" Rg current word
nnoremap <silent> <Leader>rg :Rg! <C-R><C-W><CR>
nnoremap <silent> <Leader>hrg :Rgh! <C-R><C-W><CR>
nnoremap <silent> <Leader>rrg :RG <C-R><C-W><CR>

" Sourcery config
nnoremap <leader>cl :CocDiagnostics<cr>
nnoremap <leader>cf :CocFix<cr>
nnoremap <leader>ch :call CocAction('doHover')<cr>

" test.vim settings
" make test commands execute using dispatch.vim
let test#strategy = "dispatch"

" these "Ctrl mappings" work well when Caps Lock is mapped to Ctrl
nmap <silent> t<C-n> :TestNearest<CR>
nmap <silent> t<C-f> :TestFile<CR>
nmap <silent> t<C-s> :TestSuite<CR>
nmap <silent> t<C-l> :TestLast<CR>
nmap <silent> t<C-g> :TestVisit<CR>

" Plugin works without this config
let test#python#runner = 'djangotest'
" Runners available are 'pytest', 'nose', 'nose2', 'djangotest', 'djangonose', 'mamba', and Python's built-in unittest as 'pyunit'

" let test#python#djangotest#options = '--noinput --parallel 8'
" let test#python#djangotest#options = '--noinput'
let test#python#djangotest#options = {
  \ 'all': '--noinput',
  \ 'nearest': '--noinput --testrunner=stockspot.testrunner.NoDbTestRunner --keepdb',
  \ 'file': '--parallel 4',
  \ 'suite': '--parallel 8'
\}

" Vimspector
let g:vimspector_enable_mappings = 'VISUAL_STUDIO'
nmap <leader>vl :call vimspector#Launch()<CR>
nmap <leader>vr :VimspectorReset<CR>
nmap <leader>ve :VimspectorEval
nmap <leader>vw :VimspectorWatch
nmap <leader>vo :VimspectorShowOutput
nmap <leader>vi <Plug>VimspectorBalloonEval
xmap <leader>vi <Plug>VimspectorBalloonEval
let g:vimspector_install_gadgets = [ 'debugpy']

" mnemonic 'di' = 'debug inspect' (pick your own, if you prefer!)

" for normal mode - the word under the cursor
nmap <Leader>di <Plug>VimspectorBalloonEval
" for visual mode, the visually selected text
xmap <Leader>di <Plug>VimspectorBalloonEval


" Use neovim-remote as default text editor if inside :terminal
if has('nvim') && executable('nvr')
  let $VISUAL="nvr -cc split --remote-wait +'set bufhidden=wipe'"
endif

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

" diff git-gutter againse master
" <Bar> is '|' to separate multiple commands.
nmap <leader>dm :let g:gitgutter_diff_base = 'master' <Bar> GitGutter<CR>
nmap <leader>dh :let g:gitgutter_diff_base = 'head' <Bar> GitGutter<CR>

lua << EOF
require'hop'.setup()
EOF

" hop.nvim mappings
nmap <leader><leader>w :HopWordAC<CR>
nmap <leader><leader>b :HopWordBC<CR>
nmap <leader><leader>s :HopChar1AC<CR>
nmap <leader><leader>S :HopChar1BC<CR>
nmap <leader><leader>j :HopLineAC<CR>
nmap <leader><leader>k :HopLineBC<CR>
nmap <leader><leader>/ :HopPattern<CR>
nmap <leader><leader>? :HopPatternBC<CR>
nmap <leader><leader>f :HopChar1CurrentLineAC<CR>
nmap <leader><leader>F :HopChar1CurrentLineBC<CR>

lua <<EOF
require('formatter').setup(...)
EOF
" Provided by setup function
 nnoremap <silent> <leader>f :Format<CR>

lua <<EOF
require('formatter').setup({
  filetype = {
    python = {
      -- Configuration for psf/black
      function()
        return {
          exe = "black", -- this should be available on your $PATH
          args = { '-' },
          stdin = true,
        }
      end
    }
  }
})
EOF

" https://github.com/gelguy/wilder.nvim
" Key bindings can be changed, see below
call wilder#setup({'modes': [':', '/', '?']})

call wilder#set_option('pipeline', [
      \   wilder#branch(
      \     wilder#cmdline_pipeline({
      \       'fuzzy': 1,
      \       'set_pcre2_pattern': has('nvim'),
      \     }),
      \     wilder#python_search_pipeline({
      \       'pattern': 'fuzzy',
      \     }),
      \   ),
      \ ])

let s:highlighters = [
        \ wilder#pcre2_highlighter(),
        \ wilder#basic_highlighter(),
        \ ]


" 'highlighter' : applies highlighting to the candidates
call wilder#set_option('renderer', wilder#popupmenu_renderer({
      \ 'highlighter': s:highlighters,
      \ 'left': [
      \   ' ', wilder#popupmenu_devicons(),
      \ ],
      \ 'right': [
      \   ' ', wilder#popupmenu_scrollbar(),
      \ ],
      \ }))

" https://github.com/Xuyuanp/scrollbar.nvim
augroup ScrollbarInit
  autocmd!
  autocmd CursorMoved,VimResized,QuitPre * silent! lua require('scrollbar').show()
  autocmd WinEnter,FocusGained           * silent! lua require('scrollbar').show()
  autocmd WinLeave,BufLeave,BufWinLeave,FocusLost            * silent! lua require('scrollbar').clear()
augroup end


" nvim-tree config
let g:nvim_tree_gitignore = 1 "0 by default
let g:nvim_tree_quit_on_open = 1 "0 by default, closes the tree when you open a file
let g:nvim_tree_indent_markers = 1 "0 by default, this option shows indent markers when folders are open
let g:nvim_tree_git_hl = 1 "0 by default, will enable file highlight for git attributes (can be used without the icons).
let g:nvim_tree_highlight_opened_files = 1 "0 by default, will enable folder and file icon highlight for opened files/directories.
let g:nvim_tree_root_folder_modifier = ':~' "This is the default. See :help filename-modifiers for more options
let g:nvim_tree_add_trailing = 1 "0 by default, append a trailing slash to folder names
let g:nvim_tree_group_empty = 1 " 0 by default, compact folders that only contain a single folder into one node in the file tree
let g:nvim_tree_disable_window_picker = 1 "0 by default, will disable the window picker.
let g:nvim_tree_icon_padding = ' ' "one space by default, used for rendering the space between the icon and the filename. Use with caution, it could break rendering if you set an empty string depending on your font.
let g:nvim_tree_symlink_arrow = ' >> ' " defaults to ' ➛ '. used as a separator between symlinks' source and target.
let g:nvim_tree_respect_buf_cwd = 1 "0 by default, will change cwd of nvim-tree to that of new buffer's when opening nvim-tree.
let g:nvim_tree_create_in_closed_folder = 0 "1 by default, When creating files, sets the path of a file when cursor is on a closed folder to the parent folder when 0, and inside the folder when 1.
let g:nvim_tree_refresh_wait = 500 "1000 by default, control how often the tree can be refreshed, 1000 means the tree can be refresh once per 1000ms.
let g:nvim_tree_window_picker_exclude = {
    \   'filetype': [
    \     'notify',
    \     'packer',
    \     'qf'
    \   ],
    \   'buftype': [
    \     'terminal'
    \   ]
    \ }
" Dictionary of buffer option names mapped to a list of option values that
" indicates to the window picker that the buffer's window should not be
" selectable.
let g:nvim_tree_special_files = { 'README.md': 1, 'Makefile': 1, 'MAKEFILE': 1 } " List of filenames that gets highlighted with NvimTreeSpecialFile
let g:nvim_tree_show_icons = {
    \ 'git': 1,
    \ 'folders': 1,
    \ 'files': 1,
    \ 'folder_arrows': 0,
    \ }
"If 0, do not show the icons for one of 'git' 'folder' and 'files'
"1 by default, notice that if 'files' is 1, it will only display
"if nvim-web-devicons is installed and on your runtimepath.
"if folder is 1, you can also tell folder_arrows 1 to show small arrows next to the folder icons.
"but this will not work when you set indent_markers (because of UI conflict)

" default will show icon by default if no icon is provided
" default shows no icon by default
let g:nvim_tree_icons = {
    \ 'default': '',
    \ 'symlink': '',
    \ 'git': {
    \   'unstaged': "✗",
    \   'staged': "✓",
    \   'unmerged': "",
    \   'renamed': "➜",
    \   'untracked': "★",
    \   'deleted': "",
    \   'ignored': "◌"
    \   },
    \ 'folder': {
    \   'arrow_open': "",
    \   'arrow_closed': "",
    \   'default': "",
    \   'open': "",
    \   'empty': "",
    \   'empty_open': "",
    \   'symlink': "",
    \   'symlink_open': "",
    \   }
    \ }

" nnoremap <C-n> :NvimTreeToggle<CR>
" nnoremap <leader>r :NvimTreeRefresh<CR>
" nnoremap <leader>n :NvimTreeFindFile<CR>
" NvimTreeOpen, NvimTreeClose, NvimTreeFocus, NvimTreeFindFileToggle, and NvimTreeResize are also available if you need them

" set termguicolors " this variable must be enabled for colors to be applied properly

" a list of groups can be found at `:help nvim_tree_highlight`
highlight NvimTreeFolderIcon guibg=blue

nnoremap <Leader>b :NvimTreeToggle<CR>


lua <<EOF
-- following options are the default
-- each of these are documented in `:help nvim-tree.OPTION_NAME`
require'nvim-tree'.setup {
  disable_netrw       = false,
  hijack_netrw        = true,
  open_on_setup       = false,
  ignore_ft_on_setup  = {},
  auto_close          = false,
  open_on_tab         = false,
  hijack_cursor       = false,
  update_cwd          = false,
  update_to_buf_dir   = {
    enable = true,
    auto_open = true,
  },
  diagnostics = {
    enable = false,
    icons = {
      hint = "",
      info = "",
      warning = "",
      error = "",
    }
  },
  update_focused_file = {
    enable      = false,
    update_cwd  = false,
    ignore_list = {}
  },
  system_open = {
    cmd  = nil,
    args = {}
  },
  filters = {
    dotfiles = false,
    custom = {}
  },
  view = {
    width = 30,
    height = 30,
    hide_root_folder = false,
    side = 'left',
    auto_resize = false,
    mappings = {
      custom_only = false,
      list = {}
    }
  }
}
EOF

lua <<EOF
-- You dont need to set any of these options. These are the default ones. Only
-- the loading is important
require('telescope').setup {
  extensions = {
    fzf = {
      fuzzy = true,                    -- false will only do exact matching
      override_generic_sorter = true,  -- override the generic sorter
      override_file_sorter = true,     -- override the file sorter
      case_mode = "smart_case",        -- or "ignore_case" or "respect_case"
                                       -- the default case_mode is "smart_case"
    }
  }
}
-- To get fzf loaded and working with telescope, you need to call
-- load_extension, somewhere after setup function:
require('telescope').load_extension('fzf')
EOF

" https://vim.fandom.com/wiki/Automatically_fitting_a_quickfix_window_height
au FileType qf call AdjustWindowHeight(3, 15)
    function! AdjustWindowHeight(minheight, maxheight)
        let l = 1
        let n_lines = 0
        let w_width = winwidth(0)
        while l <= line('$')
            " number to float for division
            let l_len = strlen(getline(l)) + 0.0
            let line_width = l_len/w_width
            let n_lines += float2nr(ceil(line_width))
            let l += 1
        endw
        exe max([min([n_lines, a:maxheight]), a:minheight]) . "wincmd _"
    endfunction

" <CR> mapping to make coc auto import work
inoremap <silent><expr> <CR> pumvisible() ? coc#_select_confirm()
      \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

