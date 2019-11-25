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
set foldmethod=marker


" 2019-05-27 Mathu: to make python auto complete work with virtual
" environments
" let g:python_host_prog = 'python'
" let g:python3_host_prog = 'python3'

"
" Specify a directory for plugins
" - For Neovim: ~/.local/share/nvim/plugged
" - Avoid using standard Vim directory names like 'plugin'
" call plug#begin('~/.vim/plugged')

call plug#begin('~/.local/share/nvim/plugged')

" 2019-05-30 Disabling all below for jedi vim (use either this or jedi-vim
" Make sure you use single quotes
if has('nvim')
  Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
else
  Plug 'Shougo/deoplete.nvim'
  Plug 'roxma/nvim-yarp'
  Plug 'roxma/vim-hug-neovim-rpc'
endif

Plug 'chriskempson/base16-vim'

" https://github.com/airblade/vim-gitgutter
Plug 'airblade/vim-gitgutter'
" Plug 'mhinz/vim-signify'


" (-/+)2019-05-30 Disabling deoplete for jedi-vim
" Git hug address is different now
" Plug 'zchee/deoplete-jedi'
Plug 'deoplete-plugins/deoplete-jedi'

" Code jump (go-to) plugin
Plug 'davidhalter/jedi-vim'

"Status bar plugin: vim-airline
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'


"Automatic quote and bracket completion
Plug 'jiangmiao/auto-pairs'

"comment plugin
"Plug 'scrooloose/nerdcommenter'
"20191125
Plug 'tpope/vim-commentary'



"code auto-format plugin
Plug 'sbdchd/neoformat'

" Black code formatter
Plug 'python/black'

" File managing and exploration plugin
Plug 'scrooloose/nerdtree'

" For linting
Plug 'neomake/neomake'

" For code folding
Plug 'tmhedberg/SimpylFold'

" For pyhon isort: use command :Isort
Plug 'fisadev/vim-isort'

" 20190707 Disabled for later configuration
" For VSCode like completion and docstring
" https://github.com/neoclide/coc.nvim/
" Plug 'neoclide/coc.nvim', {'branch': 'release'}

" fzf + ripgrep setup for fuzzy search
Plug '/usr/local/opt/fzf'
Plug 'junegunn/fzf.vim'

" https://medium.com/@schtoeffel/you-don-t-need-more-than-one-cursor-in-vim-2c44117d51db
" 2019-11-25 no longer need as the same can be achieve using native vim commands.
" hmm, seems vim-multiple-cursons does much more than what the aboe medius
" posts suggest
" Multiple cursor editing plugin
Plug 'terryma/vim-multiple-cursors'

" Git wrapper
Plug 'tpope/vim-fugitive'

Plug 'machakann/vim-highlightedyank'

Plug 'tpope/vim-surround'

" colorschema dracula
Plug 'dracula/vim', { 'as': 'dracula' }

" clolorscheme
Plug 'morhetz/gruvbox'
" Seems to be faster/better than gruvbox
" https://github.com/lifepillar/vim-gruvbox8/blob/master/Readme.md
Plug 'lifepillar/vim-gruvbox8'


" Advanced neovim terminal handling
Plug 'kassio/neoterm'

"Python semantic syntax highlighting (may slow down with deoplete)
"https://github.com/numirias/semshi#semshi-is-slow-together-with-deopletenvim
Plug 'numirias/semshi', {'do': ':UpdateRemotePlugins'}


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
Plug 'godlygeek/tabular'
Plug 'plasticboy/vim-markdown'


" Initialize plugin system
call plug#end()


let g:airline#extensions#tabline#enabled = 1

" VimR specific settings
if has("gui_vimr")
  " Here goes some VimR specific settings like
  " color iceberg 
  " color default 
  " set background=dark
  syntax on
  " set termguicolors
  " colorscheme iceberg
  " colorscheme base16-dracula
  " colorscheme dracula
  colorscheme gruvbox8
  set background=light   " Setting light mode
" 20191124
"else
  colorscheme gruvbox8
endif


"" NERDTree configuration
let g:NERDTreeIgnore=['\.rbc$', '\~$', '\.pyc$', '\.db$', '\.sqlite$', '__pycache__']
let g:NERDTreeSortOrder=['^__\.py$', '\/$', '*', '\.swp$', '\.bak$', '\~$']
let g:nerdtree_tabs_focus_on_files=1
let g:NERDTreeWinSize = 35
"let g:NERDTreeChDirMode=2


" grep.vim
" https://pastebin.com/u2TA9hUp
"nnoremap <silent> <leader>s :Rgrep<CR>
"let Grep_Default_Options = '-IR'
"let Grep_Skip_Files = '*.log *.db'
"let Grep_Skip_Dirs = '.git node_modules'

" Highlighted yank (-1 for persistent)
let g:highlightedyank_highlight_duration = 1000
"highlight HighlightedyankRegion cterm=reverse gui=reverse

let g:deoplete#enable_at_startup = 1


" 2019-05-27 Mathu: to make python auto complete work with virtual
" environments
" https://github.com/deoplete-plugins/deoplete-jedi/wiki/Setting-up-Python-for-Neovim
"let g:python_host_prog = '/usr/bin/python2.7'
let g:python_host_prog = '/Users/mediushealth/.pyenv/versions/neovim2/bin/python'
"let g:python3_host_prog = 'python3'
let g:python3_host_prog = '/Users/mediushealth/.pyenv/versions/neovim3/bin/python'

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

" open the go-to function in split, not another buffer
let g:jedi#use_splits_not_buffers = "right"

"https://jdhao.github.io/2018/09/10/nerdtree_usage/
"For example, imitating the way Sublime Text opens the side bar, we can use this setting:
"20191122 Had to turn it off sue to tmux prefix shortcut
"nnoremap <silent> <C-k><C-B> :NERDTreeToggle<CR>
" Changed to Ctrl + s as the previous one doesn't work after some other
" plugins. Investigate later. It didn't work because of Karabinar map
"nnoremap <silent> <C-s> :NERDTreeToggle<CR>
nnoremap <Leader>b :NERDTreeToggle<CR>
"To map <Esc> to exit terminal-mode: >
tnoremap <Esc> <C-\><C-n>

" Clear search highlighting with Escape key
nnoremap <silent><esc> :noh<return><esc>

" Fugitive Conflict Resolution
nnoremap <leader>gd :Gvdiff<CR>
nnoremap gdh :diffget //2<CR>
nnoremap gdl :diffget //3<CR>

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


" Allow switching between buffers without saving
set hidden

"If you want to open the nerdtree window when opening up Nvim, but put the cursor in the file-editing window, you can use the following setting:
"autocmd VimEnter * NERDTree | wincmd p

" Black - formatting settings 
let g:black_linelength = 119
autocmd BufWritePre *.py execute ':Black'

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
 \   'texthl': 'NeomakeErrorSign',
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
"let g:neomake_warning_sign={'text': '⚠', 'texthl': 'NeomakeErrorMsg'}

"20191122 Semshi settingas
"https://soduu.com/numirias/semshi
let g:semshi#error_sign = v:false
" Not to slow down semshi together with deoplete
" https://soduu.com/numirias/semshi#semshi-is-slow-together-with-deopletenvim
let g:deoplete#auto_complete_delay = 100


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


" With this maps you can now toggle the terminal
nnoremap <F7> :call MonkeyTerminalToggle()<cr>
tnoremap <F7> <C-\><C-n>:call MonkeyTerminalToggle()<cr>


"How can I navigate through the auto-completion list with Tab?
inoremap <expr><tab> pumvisible() ? "\<c-n>" : "\<tab>"

"Keymap to paste multiple times
xnoremap p pgvy
