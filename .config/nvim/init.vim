"https://sheerun.net/2014/03/21/how-to-boost-your-vim-productivity/
"20180801 (Mathu) My very first vimrc config
"20190704: Based on https://stackoverflow.com/questions/2287440/how-to-do-case-insensitive-search-in-vim
"To ignore case 
"Case insensitive searching
set ignorecase
"Will automatically switch to case sensitive if you use any capitals
set smartcase

" Auto toggle smart case for ex commands
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

""" Plugin Management
" Specify plugin directory
call plug#begin('~/.local/share/nvim/plugged')

" Conditional plugin loading helper
function! Cond(Cond, ...)
    let opts = get(a:000, 0, {})
    return a:Cond ? opts : extend(opts, { 'on': [], 'for': [] })
endfunction

" Core plugins
Plug 'nathom/filetype.nvim'
Plug 'asvetliakov/vim-easymotion', Cond(exists('g:vscode'), { 'as': 'vsc-easymotion' })

" Search and navigation
Plug '/opt/homebrew/opt/fzf'
Plug 'junegunn/fzf.vim'

" Code editing
Plug 'jiangmiao/auto-pairs'
Plug 'sbdchd/neoformat'
Plug 'psf/black', { 'branch': 'main' }
Plug 'brentyi/isort.vim'
Plug 'machakann/vim-highlightedyank'

if !exists('g:vscode')
    " LSP and completion
    Plug 'neoclide/coc.nvim', {'branch': 'release'}
    
    " Git integration
    Plug 'airblade/vim-gitgutter'
    Plug 'tpope/vim-fugitive'
    Plug 'junegunn/gv.vim'
    Plug 'tpope/vim-rhubarb'
    
    " UI and themes
    Plug 'vim-airline/vim-airline'
    Plug 'vim-airline/vim-airline-themes'
    Plug 'dracula/vim', { 'as': 'dracula' }
    Plug 'lifepillar/vim-gruvbox8'
    
    " Code editing and navigation
    Plug 'ludovicchabant/vim-gutentags'
    Plug 'numToStr/Comment.nvim'
    Plug 'mg979/vim-visual-multi', {'branch': 'master'}
    Plug 'tpope/vim-surround'
    Plug 'tpope/vim-unimpaired'
    
    " Grammar checking
    Plug 'rhysd/vim-grammarous'
    
    " Must be last
    Plug 'ryanoasis/vim-devicons'
endif

call plug#end()

lua <<EOF
-- Do not source the default filetype.vim
vim.g.did_load_filetypes = 1
EOF

" Initialize plugin system
" plugend

" Airline Configuration
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#buffer_nr_show = 1
let g:airline#extensions#coc#enabled = 1

" CoC Configuration
if !has("gui_vimr")
    autocmd CursorHold * silent call CocActionAsync('highlight')
endif

" Search Configuration
nnoremap <silent> <Leader>hh :History<CR>
nnoremap <silent> <Leader>h: :History:<CR>
nnoremap <silent> <Leader>h/ :History/<CR>
nnoremap <silent> <Leader>h? :History?<CR>
nnoremap <silent> <Leader>hs :History:<C-R><C-W><CR>
nnoremap <silent> <Leader>hS :History!<C-R><C-W><CR>
nnoremap <silent> <Leader>ho :History:<CR>
nnoremap <silent> <Leader>hO :History!<CR>
nnoremap <silent> <Leader>hc :History:<C-R><C-W><CR>
nnoremap <silent> <Leader>hC :History!<C-R><C-W><CR>
nnoremap <silent> <Leader>hl :History:<CR>
nnoremap <silent> <Leader>hL :History!<CR>
nnoremap <silent> <Leader>hr :Rg! <C-R><C-W><CR>
nnoremap <silent> <Leader>hrg :Rgh! <C-R><C-W><CR>

" Hop Configuration
nmap <leader><leader>w :HopWordAC<CR>
nmap <leader><leader>b :HopWordBC<CR>
nmap <leader><leader>s :HopChar1AC<CR>
nmap <leader><leader>S :HopChar1BC<CR>
nmap <leader><leader>f :HopChar1CurrentLineAC<CR>
nmap <leader><leader>F :HopChar1CurrentLineBC<CR>

" Testing Configuration
let test#strategy = "dispatch"
let test#python#runner = 'djangotest'
let test#python#djangotest#options = {
  \ '--verbosity': 2,
  \ '--no-input': v:true,
\}

let test#python#djangotest#executable = 'python3 manage.py test'

" Test Keymaps
nmap <silent> t<C-n> :TestNearest<CR>
nmap <silent> t<C-f> :TestFile<CR>
nmap <silent> t<C-s> :TestSuite<CR>
nmap <silent> t<C-l> :TestLast<CR>
nmap <silent> t<C-v> :TestVisit<CR>
nmap <silent> t<C-d> :TestDiagnostic<CR>

" Terminal Configuration
if has('nvim') && executable('nvr')
  let $VISUAL="nvr -cc split --remote-wait +'set bufhidden=wipe'"
endif

set splitright
autocmd TermOpen * startinsert

" Git Configuration
command! GitGutterDiffHead :let g:gitgutter_diff_base = 'head' <Bar> GitGutter
command! GGDH :let g:gitgutter_diff_base = 'head' <Bar> GitGutter
command! GitGutterDiffDevelop :let g:gitgutter_diff_base = 'develop' <Bar> GitGutter
command! GGDM :let g:gitgutter_diff_base = 'origin/master' <Bar> GitGutter

" Lua Configurations
" Hop Setup
lua << EOF
require'hop'.setup()
EOF

" Formatter Setup
lua << EOF
require('formatter').setup({
  filetype = {
    python = {
      -- prettier
      function()
        return {
          exe = "black",
          args = {"--quiet", "-l 119", "-"},
          stdin = true
        }
      end
    }
  }
})
EOF

" Wilder Setup
call wilder#setup({'modes': [':', '/', '?']})

call wilder#set_option('renderer', wilder#popupmenu_renderer({
  highlighter = wilder#basic_highlighter(),
  left = {' ', wilder#popupmenu_devicons()},
  right = {' ', wilder#popupmenu_scrollbar()},
}))

" DAP Setup
lua << EOF
local dap = require('dap')
dap.adapters.python = {
  type = 'executable';
  command = '~/.virtualenvs/debugpy/bin/python';
  args = { '-m', 'debugpy.adapter' };
}
dap.configurations.python = {
  {
    -- The first three options are required by nvim-dap
    type = 'python'; -- the type here established the link to the adapter definition: `dap.adapters.python`
    request = 'launch';
    name = "Launch file";

    -- Options below are for debugpy, see https://github.com/microsoft/debugpy/wiki/Debug-configuration-settings for supported options

    program = "${file}"; -- This configuration will launch the current file if used.
    pythonPath = function()
      -- debugpy supports launching an application with a different interpreter then the one used to launch debugpy itself.
      -- The code below looks for a `venv` or `.venv` folder in the current directly and uses the python within.
      -- You could adapt this - to for example use the `VIRTUAL_ENV` environment variable.
      local cwd = vim.fn.getcwd()
      if vim.fn.executable(cwd .. '/venv/bin/python') == 1 then
        return cwd .. '/venv/bin/python'
      elseif vim.fn.executable(cwd .. '/.venv/bin/python') == 1 then
        return cwd .. '/.venv/bin/python'
      else
        return '/usr/bin/python'
      end
    end;
  },
}
vim.fn.sign_define('DapBreakpoint', {text='🟥', texthl='', linehl='', numhl=''})
vim.fn.sign_define('DapStopped', {text='⭐️', texthl='', linehl='', numhl=''})
EOF

" Iron Setup
lua << EOF
local iron = require("iron.core")
local view = require("iron.view")

iron.setup {
  config = {
    -- Whether a repl should be discarded or not
    scratch_repl = true,
    -- Your repl definitions come here
    repl_definition = {
      sh = {
        -- Can be a table or a function that
        -- returns a table (see below)
        command = {"zsh"}
      },
      -- ipython for python
      python = {
	command = {"ipython"}
      },
    },
    -- How the repl window will be displayed
    -- See below for more information
    -- repl_open_cmd = require('iron.view').bottom(40),
  },
-- Iron doesn't set keymaps by default anymore.
  -- You dont need to set any of these options. These are the default ones. Only
  -- the loading is important
  keymaps = {
    send_motion = "<space>isc",
    visual_send = "<space>isc",
    send_file = "<space>isf",
    send_line = "<space>isl",
    send_until_cursor = "<space>isu",
    send_mark = "<space>ism",
    mark_motion = "<space>imc",
    mark_visual = "<space>imc",
    remove_mark = "<space>imd",
    cr = "<space>is<cr>",
    interrupt = "<space>is<space>",
    exit = "<space>isq",
    clear = "<space>icl",
  },
  -- If the highlight is on, you can change how it looks
  -- For the available options, check nvim_set_hl
  highlight = {
    italic = true
  },
  ignore_blank_lines = true, -- ignore blank lines when sending visual select lines
}


-- Vertical 50 columns split
-- Split has a metatable that allows you to set up the arguments in a "fluent" API
-- you can write as you would write a vim command.
-- It accepts:
--   - vertical
--   - leftabove/aboveleft
--   - rightbelow/belowright
--   - topleft
--   - botright
-- They'll return a metatable that allows you to set up the next argument
-- or call it with a size parameter
-- repl_open_cmd = view.split.vertical.botright(50)
--
-- -- If the supplied number is a fraction between 1 and 0,
-- -- it will be used as a proportion
-- repl_open_cmd = view.split.vertical.botright(0.61903398875)

-- The size parameter can be a number, a string or a function.
-- When it's a *number*, it will be the size in rows/columns
-- If it's a *string*, it requires a "%" sign at the end and is calculated
-- as a percentage of the editor size
-- If it's a *function*, it should return a number for the size of rows/columns

-- repl_open_cmd = view.split("40%")

-- You can supply custom logic
-- to determine the size of your
-- repl's window
-- repl_open_cmd = view.split.topleft(function()
--   if some_check then
--     return vim.o.lines * 0.4
--   end
--   return 20
-- end)
--
-- -- An optional set of options can be given to the split function if one
-- -- wants to configure the window behavior.
-- -- Note that, by default `winfixwidth` and `winfixheight` are set
-- -- to `true`. If you want to overwrite those values,
-- -- you need to specify the keys in the option map as the example below
--
-- repl_open_cmd = view.split("40%", {
--   winfixwidth = false,
--   winfixheight = false,
--   -- any window-local configuration can be used here
--   number = true
-- })
-- open the repl in a vertical split
repl_open_cmd = view.split.vertical(50)

-- iron also has a list of commands, see :h iron-commands for all available commands
vim.keymap.set('n', '<space>ii', '<cmd>IronRepl<cr>')
vim.keymap.set('n', '<space>ir', '<cmd>IronRestart<cr>')
vim.keymap.set('n', '<space>if', '<cmd>IronFocus<cr>')
vim.keymap.set('n', '<space>ih', '<cmd>IronHide<cr>')
EOF

" Other configurations
luafile $HOME/.config/nvim/plugins.lua

" 20230418 

function! CopyPythonDotPath()
    " Save the current cursor position
    let l:current_pos = getpos('.')

    " Find the method definition
    let l:method = ''
    if search('^\s*def\s\+\zs\k\+\ze\s*(', 'bW') > 0
        let l:method = matchstr(getline('.'), '^\s*def\s\+\zs\k\+\ze\s*(')
    endif

    " Find the class definition
    let l:class = ''
    if search('^\s*class\s\+\zs\k\+\ze\s*(', 'bW') > 0
        let l:class = matchstr(getline('.'), '^\s*class\s\+\zs\k\+\ze\s*(')
    endif

    " Restore the original cursor position
    call setpos('.', l:current_pos)

    " Get the current file's relative path
    let l:relative_path = expand('%:.')

    " Replace forward slashes with '.'
    let l:dot_path = substitute(l:relative_path, '/', '.', 'g')

    " Remove the file extension
    let l:dot_path_no_ext = substitute(l:dot_path, '\.[^.]*$', '', '')

" Combine the path, class, and method
    let l:full_path = l:dot_path_no_ext
    if len(l:class) > 0
        let l:full_path = l:full_path . '.' . l:class
    endif
    if len(l:method) > 0
        let l:full_path = l:full_path . '.' . l:method
    endif

    " Copy the final value to the clipboard
    if has('clipboard')
        let @+ = l:full_path
    else
        echoerr 'Clipboard support is not available.'
    endif
endfunction

" Optional: Create a command to call the function more easily
command! CopyPythonDotPath :call CopyPythonDotPath()

" Other mappings
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

" command to format document with Coc prettier
" command! -nargs=0 FormatCoc :call CocAction('format')
command! -nargs=0 PrettierCoc :CocCommand prettier.forceFormatDocument
" command! -nargs=0 FormatCoc :CocCommand editor.action.formatDocument
" Add `:Format` command to format current buffer
command! -nargs=0 FormatCoc :call CocActionAsync('format')
" Add `:Fold` command to fold current buffer
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

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

" enable dbui nerd font
let g:db_ui_use_nerd_fonts = 1
let g:db_ui_show_database_icon = 1
" Diable execute on save
let g:db_ui_execute_on_save = 0
let g:db_ui_save_location = '~/devel/adtrac/db_scripts'

" command to format pgsql with visual selection 
command! -range=% FormatPgsql <line1>,<line2>!pg_format -s 2 -u 2 -U 1 -w 80 -g -i

autocmd FileType qf call AdjustWindowHeight(3, 15)
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

" Not sure if this works
" call coc#config("languageserver.sourcery.initializationOptions.token", $SOURCERY_TOKEN)
"

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

" nvim-tree config
" let g:nvim_tree_gitignore = 1 "0 by default
" let g:nvim_tree_quit_on_open = 1 "0 by default, closes the tree when you open a file
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

nnoremap <Leader>b :NvimTreeFindFileToggle<CR>

lua <<EOF
vim.diagnostic.config({ virtual_text = true })
-- examples for your init.lua

-- disable netrw at the very start of your init.lua (strongly advised)
-- vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- set termguicolors to enable highlight groups
vim.opt.termguicolors = true

-- empty setup using defaults
require("nvim-tree").setup()

-- OR setup with some options
require("nvim-tree").setup({
  sort_by = "case_sensitive",
  view = {
    adaptive_size = true,
    mappings = {
      list = {
        { key = "u", action = "dir_up" },
      },
    },
  },
  renderer = {
    group_empty = true,
  },
  filters = {
    dotfiles = true,
  },
})
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

" Not sure if this works
" call coc#config("languageserver.sourcery.initializationOptions.token", $SOURCERY_TOKEN)
"

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

" nvim-tree config
" let g:nvim_tree_gitignore = 1 "0 by default
" let g:nvim_tree_quit_on_open = 1 "0 by default, closes the tree when you open a file
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

nnoremap <Leader>b :NvimTreeFindFileToggle<CR>

lua <<EOF
vim.diagnostic.config({ virtual_text = true })
-- examples for your init.lua

-- disable netrw at the very start of your init.lua (strongly advised)
-- vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- set termguicolors to enable highlight groups
vim.opt.termguicolors = true

-- empty setup using defaults
require("nvim-tree").setup()

-- OR setup with some options
require("nvim-tree").setup({
  sort_by = "case_sensitive",
  view = {
    adaptive_size = true,
    mappings = {
      list = {
        { key = "u", action = "dir_up" },
      },
    },
  },
  renderer = {
    group_empty = true,
  },
  filters = {
    dotfiles = true,
  },
})
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

" Not sure if this works
" call coc#config("languageserver.sourcery.initializationOptions.token", $SOURCERY_TOKEN)
"

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

" nvim-tree config
" let g:nvim_tree_gitignore = 1 "0 by default
" let g:nvim_tree_quit_on_open = 1 "0 by default, closes the tree when you open a file
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

nnoremap <Leader>b :NvimTreeFindFileToggle<CR>

lua <<EOF
vim.diagnostic.config({ virtual_text = true })
-- examples for your init.lua

-- disable netrw at the very start of your init.lua (strongly advised)
-- vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- set termguicolors to enable highlight groups
vim.opt.termguicolors = true

-- empty setup using defaults
require("nvim-tree").setup()

-- OR setup with some options
require("nvim-tree").setup({
  sort_by = "case_sensitive",
  view = {
    adaptive_size = true,
    mappings = {
      list = {
        { key = "u", action = "dir_up" },
      },
    },
  },
  renderer = {
    group_empty = true,
  },
  filters = {
    dotfiles = true,
  },
})
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

" Not sure if this works
" call coc#config("languageserver.sourcery.initializationOptions.token", $SOURCERY_TOKEN)
"

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

" nvim-tree config
" let g:nvim_tree_gitignore = 1 "0 by default
" let g:nvim_tree_quit_on_open = 1 "0 by default, closes the tree when you open a file
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

nnoremap <Leader>b :NvimTreeFindFileToggle<CR>

lua <<EOF
vim.diagnostic.config({ virtual_text = true })
-- examples for your init.lua

-- disable netrw at the very start of your init.lua (strongly advised)
-- vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- set termguicolors to enable highlight groups
vim.opt.termguicolors = true

-- empty setup using defaults
require("nvim-tree").setup()

-- OR setup with some options
require("nvim-tree").setup({
  sort_by = "case_sensitive",
  view = {
    adaptive_size = true,
    mappings = {
      list = {
        { key = "u", action = "dir_up" },
      },
    },
  },
  renderer = {
    group_empty = true,
  },
  filters = {
    dotfiles = true,
  },
})
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

" Not sure if this works
" call coc#config("languageserver.sourcery.initializationOptions.token", $SOURCERY_TOKEN)
"

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

" nvim-tree config
" let g:nvim_tree_gitignore = 1 "0 by default
" let g:nvim_tree_quit_on_open = 1 "0 by default, closes the tree when you open a file
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

nnoremap <Leader>b :NvimTreeFindFileToggle<CR>

lua <<EOF
vim.diagnostic.config({ virtual_text = true })
-- examples for your init.lua

-- disable netrw at the very start of your init.lua (strongly advised)
-- vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- set termguicolors to enable highlight groups
vim.opt.termguicolors = true

-- empty setup using defaults
require("nvim-tree").setup()

-- OR setup with some options
require("nvim-tree").setup({
  sort_by = "case_sensitive",
  view = {
    adaptive_size = true,
    mappings = {
      list = {
        { key = "u", action = "dir_up" },
      },
    },
  },
  renderer = {
    group_empty = true,
  },
  filters = {
    dotfiles = true,
  },
})
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

" Not sure if this works
" call coc#config("languageserver.sourcery.initializationOptions.token", $SOURCERY_TOKEN)
"

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

" nvim-tree config
" let g:nvim_tree_gitignore = 1 "0 by default
" let g:nvim_tree_quit_on_open = 1 "0 by default, closes the tree when you open a file
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

nnoremap <Leader>b :NvimTreeFindFileToggle<CR>

lua <<EOF
vim.diagnostic.config({ virtual_text = true })
-- examples for your init.lua

-- disable netrw at the very start of your init.lua (strongly advised)
-- vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- set termguicolors to enable highlight groups
vim.opt.termguicolors = true

-- empty setup using defaults
require("nvim-tree").setup()

-- OR setup with some options
require("nvim-tree").setup({
  sort_by = "case_sensitive",
  view = {
    adaptive_size = true,
    mappings = {
      list = {
        { key = "u", action = "dir_up" },
      },
    },
  },
  renderer = {
    group_empty = true,
  },
  filters = {
    dotfiles = true,
  },
})
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

" Not sure if this works
" call coc#config("languageserver.sourcery.initializationOptions.token", $SOURCERY_TOKEN)
"

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

" nvim-tree config
" let g:nvim_tree_gitignore = 1 "0 by default
" let g:nvim_tree_quit_on_open = 1 "0 by default, closes the tree when you open a file
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

nnoremap <Leader>b :NvimTreeFindFileToggle<CR>

lua <<EOF
vim.diagnostic.config({ virtual_text = true })
-- examples for your init.lua

-- disable netrw at the very start of your init.lua (strongly advised)
-- vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- set termguicolors to enable highlight groups
vim.opt.termguicolors = true

-- empty setup using defaults
require("nvim-tree").setup()

-- OR setup with some options
require("nvim-tree").setup({
  sort_by = "case_sensitive",
  view = {
    adaptive_size = true,
    mappings = {
      list = {
        { key = "u", action = "dir_up" },
      },
    },
  },
  renderer = {
    group_empty = true,
  },
  filters = {
    dotfiles = true,
  },
})
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

" Not sure if this works
" call coc#config("languageserver.sourcery.initializationOptions.token", $SOURCERY_TOKEN)
"

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

" nvim-tree config
" let g:nvim_tree_gitignore = 1 "0 by default
" let g:nvim_tree_quit_on_open = 1 "0 by default, closes the tree when you open a file
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

nnoremap <Leader>b :NvimTreeFindFileToggle<CR>

lua <<EOF
vim.diagnostic.config({ virtual_text = true })
-- examples for your init.lua

-- disable netrw at the very start of your init.lua (strongly advised)
-- vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- set termguicolors to enable highlight groups
vim.opt.termguicolors = true

-- empty setup using defaults
require("nvim-tree").setup()

-- OR setup with some options
require("nvim-tree").setup({
  sort_by = "case_sensitive",
  view = {
    adaptive_size = true,
    mappings = {
      list = {
        { key = "u", action = "dir_up" },
      },
    },
  },
  renderer = {
    group_empty = true,
  },
  filters = {
    dotfiles = true,
  },
})
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
