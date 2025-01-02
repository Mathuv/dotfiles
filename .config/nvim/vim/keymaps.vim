
" 20191108 Remap the leader from default \ to <space)
let mapleader = "\<Space>"

" https://github.com/jeffkreeftmeijer/neovim-sensible/blob/master/plugin/neovim-sensible.vim
" Use ,, to switch between buffers
nnoremap ,, :b#<CR>

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

"To map <Esc> to exit terminal-mode: >
if has('nvim')
  tnoremap <Esc> <C-\><C-n>
  tnoremap <C-v><Esc> <Esc>
  tnoremap <expr> <C-R> '<C-\><C-N>"'.nr2char(getchar()).'pi'
  tnoremap <C-v><C-R> <C-R>
endif


" Clear search highlighting with Escape key
nnoremap <silent><esc> :noh<return><esc>

" Fugitive Conflict Resolution
nnoremap <leader>gd :Gvdiff<CR>
nnoremap gdh :diffget //2<CR>
nnoremap gdl :diffget //3<CR>
set diffopt+=vertical
nnoremap <leader>gb :Git blame<CR>
" map <leader>gdd to Gdiffsplit against develop
nnoremap <leader>gdd :Gdiffsplit! origin/develop<CR>
nnoremap <leader>gdm :Gdiffsplit! origin/master<CR>
" map <leader>gdu to Gdiffsplit against current branch's upstream
nnoremap <leader>gdu :Gdiffsplit! @{u}<CR>

"20191122 Move line up and down
"https://vim.fandom.com/wiki/Moving_lines_up_or_down
nnoremap <A-j> :m .+1<CR>==
nnoremap <A-k> :m .-2<CR>==
inoremap <A-j> <Esc>:m .+1<CR>==gi
inoremap <A-k> <Esc>:m .-2<CR>==gi
vnoremap <A-j> :m '>+1<CR>gv=gv
vnoremap <A-k> :m '<-2<CR>gv=gv


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
    30 wincmd <
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
    30 wincmd <
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

"With this maps you can now toggle the terminal
" nnoremap <F7> :call MonkeyTerminalToggle()<cr>
" tnoremap <F7> <C-\><C-n>:call MonkeyTerminalToggle()<cr>
nnoremap <C-`> :call MonkeyTerminalToggle()<cr>
tnoremap <C-`> <C-\><C-n>:call MonkeyTerminalToggle()<cr>


"How can I navigate through the auto-completion list with Tab?
" inoremap <expr><tab> pumvisible() ? "\<c-n>" : "\<tab>"

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

" Bind our own Ferret commands.
nmap <leader>/ <Plug>(FerretAck)
nmap <leader>* <Plug>(FerretAckWord)


" gb, gB for switching between buffers START
"  https://jdhao.github.io/2020/10/16/nvim_switch_buffer_with_mapping/
" nnoremap <silent> gb :<C-U>call <SID>GoToBuffer(v:count, 'forward')<CR>
" nnoremap <silent> gB :<C-U>call <SID>GoToBuffer(v:count, 'backward')<CR>

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


" CoC config START
" Use <c-space> to trigger completion
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)


" Use K to show documentation in preview window
nnoremap <silent> K :call ShowDocumentation()<CR>

function! ShowDocumentation()
  if CocAction('hasProvider', 'hover')
    call CocActionAsync('doHover')
  else
    call feedkeys('K', 'in')
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
" https://github.com/neoclide/coc.nvim/issues/2918
" nmap <leader>rn :CocCommand document.renameCurrentWord

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

" Remap keys for applying code actions at the cursor position
nmap <leader>ac  <Plug>(coc-codeaction-cursor)
" Remap keys for apply code actions affect whole buffer
nmap <leader>as  <Plug>(coc-codeaction-source)
" Apply the most preferred quickfix action to fix diagnostic on the current line
nmap <leader>qf  <Plug>(coc-fix-current)

" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)


" Remap keys for applying refactor code actions
nmap <silent> <leader>re <Plug>(coc-codeaction-refactor)
xmap <silent> <leader>r  <Plug>(coc-codeaction-refactor-selected)
nmap <silent> <leader>r  <Plug>(coc-codeaction-refactor-selected)

xmap <silent> <leader>rf <Plug>(coc-refactor)
nmap <silent> <leader>rf <Plug>(coc-refactor)

" Run the Code Lens action on the current line
nmap <leader>cl  <Plug>(coc-codelens-action)

" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" Use CTRL-S for selections ranges
" Requires 'textDocument/selectionRange' support of language server
" Not supported by pyright
" nmap <silent> <C-s> <Plug>(coc-range-select)
" xmap <silent> <C-s> <Plug>(coc-range-select)


" PLUGIN: FZF
" https://dev.to/iggredible/how-to-search-faster-in-vim-with-fzf-vim-36ko
nnoremap <silent> <Leader>hh :History<CR>
nnoremap <silent> <Leader>h: :History:<CR>
nnoremap <silent> <Leader>h/ :History/<CR> 
set rtp+=/opt/homebrew/opt/fzf

" 20210529 Telescope.nvim config
" Find files using Telescope command-line sugar.
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>
nnoremap <leader>tt <cmd>Telescope tags<cr>
nnoremap <leader>tb <cmd>Telescope current_buffer_tags<cr>
nnoremap <leader>fo <cmd>Telescope oldfiles<cr>

command L Telescope


" python tagbar
nmap <F8> :TagbarToggle<CR>


" Rg current word
nnoremap <silent> <Leader>rg :Rg! <C-R><C-W><CR>
nnoremap <silent> <Leader>hrg :Rgh! <C-R><C-W><CR>
nnoremap <silent> <Leader>rrg :RG <C-R><C-W><CR>


" test.vim settings
" these "Ctrl mappings" work well when Caps Lock is mapped to Ctrl
nmap <silent> t<C-n> :TestNearest<CR>
nmap <silent> t<C-f> :TestFile<CR>
nmap <silent> t<C-s> :TestSuite<CR>
nmap <silent> t<C-l> :TestLast<CR>
nmap <silent> t<C-g> :TestVisit<CR>


" " hop.nvim mappings
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


" lua <<EOF
" require('formatter').setup(...)
" EOF
" Provided by setup function
 nnoremap <silent> <leader>f :Format<CR>


" a list of groups can be found at `:help nvim_tree_highlight`
" highlight NvimTreeFolderIcon guibg=blue

nnoremap <Leader>b :NvimTreeFindFileToggle<CR>


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

nnoremap <Leader>cc :ccl<CR>
nnoremap <Leader>co :Copen<CR>
nnoremap <Leader>lc :lclose<CR>
nnoremap <Leader>lo :lopen<CR>

" Fugitive
nmap <leader>gs :Git<CR><C-w>8-


"https://github.com/tpope/vim-fugitive/issues/401
function! ToggleGStatus()
  if buflisted(bufname('fugitive:///*/.git//$'))
    execute ":bdelete" bufname('fugitive:///*/.git//$')
  else
    Git
    15wincmd_
  endif
endfunction
command! ToggleGStatus :call ToggleGStatus()
nnoremap <silent> <leader>gg :ToggleGStatus<cr>

augroup fugitive_au
  autocmd!
  autocmd FileType fugitive setlocal winfixheight
augroup END

" short cut to save
" noremap <Leader>s :update<CR>

let g:winresizer_start_key = '<C-S>'


" Remap keys for SystemCopy, used to be 'cp' and 'cv'
nmap cy <Plug>SystemCopy
xmap cy <Plug>SystemCopy
nmap cY <Plug>SystemCopyLine
nmap cp <Plug>SystemPaste
xmap cp <Plug>SystemPaste
nmap cP <Plug>SystemPasteLine

if has('nvim')
  command Spt sp|terminal
  command Vspt vsp|terminal

  nnoremap <silent><C-w>t <c-\><c-n>:Vspt<CR>
  tnoremap <silent><C-w>t <c-\><c-n>:Vspt<CR>
  inoremap <silent><C-w>t <c-\><c-n>:Vspt<CR>
  vnoremap <silent><C-w>t <c-\><c-n>:Vspt<CR>
endif

nnoremap <Leader>ee :GFiles?<CR>

" Mapt Ctrl+: to Esc + save
" inoremap <C-;> <Esc>:w<CR>
" nnoremap <C-;> <Esc>:w<CR>
inoremap <C-;> <Esc>:update<CR>
nnoremap <C-;> <Esc>:update<CR>

" Map <leader>bd to close buffer
nnoremap <leader>bd :bd<CR>

" Map <leader>bh to hide buffer
nnoremap <Leader>bh :hide<CR>

" map :Git push to <leader>gp
nnoremap <leader>gp :Git push<CR>


" Activate pipenv when neovim terminal is opened
function! TerminalOpened()
  if filereadable('Pipfile')
    call termopen('pipenv shell')
  else
    call termopen($SHELL)
  endif
endfunction

" autocmd TermOpen * call TerminalOpened()
" autocmd BufEnter * call TerminalOpened()

function! OpenTermWithPipenv()
    if filereadable('Pipfile')
        let cmd = 'pipenv shell'
    else
        let cmd = $SHELL
    endif
    " call termopen(cmd)
    " open in vertical split
    call termopen(cmd, {'vertical': v:true})
    startinsert
endfunction

nnoremap <leader>tv :call OpenTermWithPipenv()<cr>

" map for zenmode
nnoremap <leader>z :ZenMode<CR>

" map fugitive Git status to F3
function! ToggleGit()
    if buflisted(bufname('fugitive:///*/.git//$'))
        " bd .git/index
	" execute ":bdelete" bufname('fugitive:///*/.git/')
	execute ":bdelete" bufname('fugitive:///*/.git//$')
    else
        Git
    endif
endfunction
command ToggleGit :call ToggleGit()
nmap <F3> :ToggleGit<CR>


nnoremap <silent><nowait> <space>d  :call CocAction('jumpDefinition', v:false)<CR>


nmap <expr> <silent> <C-c> <SID>select_current_word()
function! s:select_current_word()
  if !get(b:, 'coc_cursors_activated', 0)
    return "\<Plug>(coc-cursors-word)"
  endif
  return "*\<Plug>(coc-cursors-word):nohlsearch\<CR>"
endfunc


function! OpenIssueURL()
    " Get the word under the cursor
    let current_word = expand('<cword>')

    " Construct the URL
    let base_url = "https://adtrac.atlassian.net/browse/INDY-"
    let full_url = base_url . current_word

    " Echo the URL to the command line
    echo "Opening URL: " . full_url

    " Open the URL in the default browser based on the platform
    if has("unix")
        if system("uname") == "Darwin\n"
            silent execute "!open" full_url
        else
            silent execute "!xdg-open" full_url
        endif
    elseif has("win32")
        silent execute "!start" full_url
    endif
endfunction

" Map a key (e.g., <Leader>o) to the function in normal mode
nnoremap <Leader>o :call OpenIssueURL()<CR>


" Check https://github.com/nvim-telescope/telescope.nvim/issues/1911 for
" enhanced version of this
nnoremap <leader>fF :execute 'Telescope find_files default_text=' . "'" . expand('<cword>')<cr>
nnoremap <leader>fG :execute 'Telescope live_grep default_text=' . expand('<cword>')<cr>
nnoremap <leader>tT :execute 'Telescope tags default_text=' . expand('<cword>')<cr>
