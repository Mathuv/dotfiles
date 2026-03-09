let g:airline#extensions#tabline#enabled = 1

"To show the buffer no next to file name
"https://jdhao.github.io/2018/09/29/Switching_buffers_quickly_Neovim/
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#buffer_nr_show = 1

function! s:ApplyDiffHighlights() abort
  highlight DiffAdd gui=NONE guifg=#e6edf3 guibg=#003800 cterm=NONE ctermfg=255 ctermbg=22
  highlight DiffDelete gui=NONE guifg=#e6edf3 guibg=#3f0001 cterm=NONE ctermfg=255 ctermbg=52
  highlight DiffChange gui=NONE guifg=#e6edf3 guibg=#1d3042 cterm=NONE ctermfg=255 ctermbg=24
  highlight DiffText gui=bold guifg=#ffffff guibg=#2a4556 cterm=bold ctermfg=255 ctermbg=24
endfunction

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

set termguicolors

"onedark.vim override: Set a custom background color in the terminal
if (has("autocmd") && !has("gui_running"))
  augroup colors
    autocmd!
    " let s:background = { "gui": "#282C34", "cterm": "235", "cterm16": "0" }
    let s:background = { "gui": "#191c1a", "cterm": "235", "cterm16": "0" }
    autocmd ColorScheme * call onedark#set_highlight("Normal", { "bg": s:background }) "No `fg` setting
    autocmd ColorScheme * call s:ApplyDiffHighlights()
  augroup END
endif

 set termguicolors
 let g:onedark_termcolors=256
 colorscheme onedark
 call s:ApplyDiffHighlights()
