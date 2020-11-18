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

" Function to condionally install pluging
" https://github.com/asvetliakov/vscode-neovim/issues/415
function! Cond(Cond, ...)
    let opts = get(a:000, 0, {})
    return a:Cond ? opts : extend(opts, { 'on': [], 'for': [] })
endfunction

call plug#begin('~/.local/share/nvim/plugged')

Plug 'easymotion/vim-easymotion', Cond(!exists('g:vscode'))
Plug 'asvetliakov/vim-easymotion', Cond(exists('g:vscode'), { 'as': 'vsc-easymotion' })

" fzf + ripgrep setup for fuzzy search
" Using brew locaion below so that it can be kept updated
Plug '/usr/local/opt/fzf'
" Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
" This is required to make other fzf feature available within vim
Plug 'junegunn/fzf.vim'

"Automatic quote and bracket completion
Plug 'jiangmiao/auto-pairs'




"code auto-format plugin
Plug 'sbdchd/neoformat'

"" Black code formatter
""Plug 'python/black'
"Plug 'psf/black'
Plug 'psf/black', { 'branch': 'stable' }

" For code folding
Plug 'tmhedberg/SimpylFold'

" For pyhon isort: use command :Isort
Plug 'fisadev/vim-isort'

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
    Plug 'prabirshrestha/vim-lsp'
    Plug 'Shougo/deoplete.nvim'
    Plug 'lighttiger2505/deoplete-vim-lsp'
    
    Plug 'chriskempson/base16-vim'

    " Displays function signatures from completions
    Plug 'Shougo/echodoc.vim'
    
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
    Plug 'scrooloose/nerdtree'
    
    " For linting
    Plug 'neomake/neomake'
    
    
    " 20190707 Disabled for later configuration
    " For VSCode like completion and docstring
    " https://github.com/neoclide/coc.nvim/
    " Plug 'neoclide/coc.nvim', {'branch': 'release'}
    
    
    " https://medium.com/@schtoeffel/you-don-t-need-more-than-one-cursor-in-vim-2c44117d51db
    " 2019-11-25 no longer need as the same can be achieve using native vim commands.
    " hmm, seems vim-multiple-cursons does much more than what the aboe medius
    " posts suggest
    " Multiple cursor editing plugin
    Plug 'terryma/vim-multiple-cursors'
    " check this our later and vim-multi-cursor is not longer maintianed
    " Plug 'mg979/vim-visual-multi', {'branch': 'master'}
    
    " Git wrapper
    Plug 'tpope/vim-fugitive'
    " Fugitive Gbrowse handler
    " Doesn't seem to work
    Plug 'tommcdo/vim-fubitive'
    " A git commit browser in Vim
    Plug 'junegunn/gv.vim'
    
    
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
    Plug 'godlygeek/tabular'
    Plug 'plasticboy/vim-markdown'
    
    Plug 'cespare/vim-toml'
    
    Plug 'editorconfig/editorconfig-vim'
    
    Plug 'lifepillar/pgsql.vim'
    
    " To have ipython like feature within vim
    Plug 'jpalardy/vim-slime', { 'for': 'python' }
    Plug 'hanschen/vim-ipython-cell', { 'for': 'python' }
    
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
    
    " speeddating.vim: use CTRL-A/CTRL-X to increment dates, times, and more
    Plug 'tpope/vim-speeddating'
    
    " https://github.com/sakhnik/nvim-gdb
    Plug 'sakhnik/nvim-gdb', { 'do': ':!./install.sh \| UpdateRemotePlugins' }
    
    Plug 'freitass/todo.txt-vim'
    
    " Linter for grammar check
    " Plug 'dense-analysis/ale'
    
    Plug 'rhysd/vim-grammarous'
    
    Plug 'tpope/vim-unimpaired'
    
    Plug 'Yggdroot/LeaderF', { 'do': './install.sh' }
    
    Plug 'glacambre/firenvim', { 'do': { _ -> firenvim#install(0) } }
    
    " Plug 'hashrocket/vim-macdown'
    
    Plug 'ms-jpq/chadtree', {'branch': 'chad', 'do': ':UpdateRemotePlugins'}
    
    Plug 'tpope/vim-obsession'
    
    " Plug 'python-mode/python-mode', { 'for': 'python', 'branch': 'develop' }
    
    Plug 'ervandew/supertab'
endif

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
else
  " colorscheme gruvbox8
  set termguicolors
  syntax on
endif


"" NERDTree configuration
let g:NERDTreeIgnore=['\.rbc$', '\~$', '\.pyc$', '\.db$', '\.sqlite$', '__pycache__']
let g:NERDTreeSortOrder=['^__\.py$', '\/$', '*', '\.swp$', '\.bak$', '\~$']
let g:nerdtree_tabs_focus_on_files=1
let g:NERDTreeWinSize = 35
"let g:NERDTreeChDirMode=2

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

let g:deoplete#enable_at_startup = 1
" Disable deoplete preview window
set completeopt-=preview


" 2019-05-27 Mathu: to make python auto complete work with virtual
" environments
" https://github.com/deoplete-plugins/deoplete-jedi/wiki/Setting-up-Python-for-Neovim
"let g:python_host_prog = '/usr/bin/python2.7'
let g:python_host_prog = '/Users/mediushealth/.pyenv/versions/neovim2/bin/python'
"let g:python3_host_prog = 'python3'
" let g:python3_host_prog = '/Users/mediushealth/.pyenv/versions/neovim3/bin/python'
let g:python3_host_prog = '/Users/mediushealth/.pyenv/versions/neovim37/bin/python'

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

"------------------------------------------------------------------------------
" slime configuration 
"------------------------------------------------------------------------------
" always use tmux
let g:slime_target = 'tmux'

" fix paste issues in ipython
let g:slime_python_ipython = 1

" always send text to the top-right pane in the current tmux tab without asking
let g:slime_default_config = {
	    \ 'socket_name': get(split($TMUX, ','), 0),
	    \ 'target_pane': '{top-right}' }
let g:slime_dont_ask_default = 1

"------------------------------------------------------------------------------
" ipython-cell configuration
"------------------------------------------------------------------------------
" Use '##' to define cells instead of using marks
let g:ipython_cell_delimit_cells_by = 'tags'

let g:markdown_fenced_languages = ['html', 'python', 'bash=sh']


"20191216 Add psql syntax highlighting 
let g:sql_type_default = 'pgsql'

" Allow switching between buffers without saving
set hidden

"If you want to open the nerdtree window when opening up Nvim, but put the cursor in the file-editing window, you can use the following setting:
"autocmd VimEnter * NERDTree | wincmd p

" Black - formatting settings 
let g:black_virtualenv = '/Users/mediushealth/.pyenv/versions/neovim37'
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
let g:semshi#error_sign = v:false
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

" https://github.com/junegunn/fzf/wiki/Examples-(vim)
" Simple MRU search
command! FZFMru call fzf#run({
\ 'source':  reverse(s:all_files()),
\ 'sink':    'edit',
\ 'options': '-m -x +s',
\ 'down':    '40%' })

function! s:all_files()
  return extend(
  \ filter(copy(v:oldfiles),
  \        "v:val !~ 'fugitive:\\|NERD_tree\\|^/tmp/\\|.git/'"),
  \ map(filter(range(1, bufnr('$')), 'buflisted(v:val)'), 'bufname(v:val)'))
endfunction

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
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

let g:db = "postgresql://medius:TcdSXjzYhD63rM@quro-nonprod.cdlree0m10um.ap-southeast-2.rds.amazonaws.com/mediuschatserver_dev"

com! FormatJSON %!python -m json.tool

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
if has("gui_vimr")
else
    call deoplete#custom#option('ignore_sources', {'_': ['around', 'buffer']})
endif
" maximum candidate window length
call deoplete#custom#source('_', 'max_menu_width', 80)

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
call deoplete#custom#option('ignore_sources', {'_': ['around', 'buffer']})

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

" https://github.com/ms-jpq/chadtree
nnoremap <leader>v <cmd>CHADopen<cr>
if exists('g:vscode')
    xmap gc  <Plug>VSCodeCommentary
    nmap gc  <Plug>VSCodeCommentary
    omap gc  <Plug>VSCodeCommentary
    nmap gcc <Plug>VSCodeCommentaryLine
endif

" LSP settings START
" https://jdhao.github.io/2020/11/04/replace_deoplete_jedi_for_LSP/
" settings for pyls
if executable('pyls')
    " pip install python-language-server
    au User lsp_setup call lsp#register_server({
        \ 'name': 'pyls',
        \ 'cmd': {server_info->['pyls']},
        \ 'allowlist': ['python'],
        \ })
endif

function! s:on_lsp_buffer_enabled() abort
    " use omnifunc if you are fine with it.
    " setlocal omnifunc=lsp#complete
    if exists('+tagfunc') | setlocal tagfunc=lsp#tagfunc | endif
    " some mappings to use, tweak as you wish.
    nmap <buffer> gd <plug>(lsp-definition)
    nmap <buffer> gr <plug>(lsp-references)
    nmap <buffer> gi <plug>(lsp-implementation)
    nmap <buffer> gt <plug>(lsp-type-definition)
    nmap <buffer> <leader>rn <plug>(lsp-rename)
    nmap <buffer> [g <Plug>(lsp-previous-diagnostic)
    nmap <buffer> ]g <Plug>(lsp-next-diagnostic)
    nmap <buffer> K <plug>(lsp-hover)
endfunction

augroup lsp_install
    au!
    " call s:on_lsp_buffer_enabled only for languages that has the server registered.
    autocmd User lsp_buffer_enabled call s:on_lsp_buffer_enabled()
augroup END


" whether to enable diagnostics for vim-lsp (we may want to use ALE for other
" plugins for that.
let g:lsp_diagnostics_enabled = 1

" show diagnostic signs
let g:lsp_signs_enabled = 1
let g:lsp_signs_error = {'text': '✗'}
let g:lsp_signs_warning = {'text': '!'}
let g:lsp_highlights_enabled = 0

" Do not use virtual text, they are far too obtrusive.
let g:lsp_virtual_text_enabled = 0
" echo a diagnostic message at cursor position
let g:lsp_diagnostics_echo_cursor = 0
" show diagnostic in floating window
let g:lsp_diagnostics_float_cursor = 1
" whether to enable highlight a symbol and its references
let g:lsp_highlight_references_enabled = 1
let g:lsp_preview_max_width = 80

" flake8 specific settings
" https://jdhao.github.io/2020/11/05/pyls_flake8_setup/
if executable('pyls')
    " pip install python-language-server
    au User lsp_setup call lsp#register_server({
          \ 'name': 'pyls',
          \ 'cmd': {server_info->['pyls']},
          \ 'allowlist': ['python'],
          \ 'workspace_config': {
          \    'pyls':
          \        {'configurationSources': ['flake8'],
          \         'plugins': {'flake8': {'enabled': v:true},
          \                     'pyflakes': {'enabled': v:false},
          \                     'pycodestyle': {'enabled': v:false},
          \                    }
          \         }
          \ }})
endif


" LSP settings END
"
" Or, you could use neovim's floating text feature.
let g:echodoc#enable_at_startup = 1
let g:echodoc#type = 'floating'
" To use a custom highlight for the float window,
" change Pmenu to your highlight group
highlight link EchoDocFloat Pmenu
