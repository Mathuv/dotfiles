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

" RipGrep with case sensitivity
command! -bang -nargs=* Rgc
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always --case-sensitive '.shellescape(<q-args>), 1,
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


function! RgBoth(search_term1, search_term2) abort
    let l:grep_cmd = "rg -l '" . a:search_term1 . "' | xargs rg -l '" . a:search_term2 . "'"

    let s:source = split(system(l:grep_cmd), "\n")

    let l:preview_cmd = has('win32') || has('win64') ? 'bat --style=numbers --color=always --line-range :500 {}' : 'bat --style=numbers --color=always --line-range :500 {} || cat {}'

    let l:options = {
                \ 'source':  s:source,
                \ 'sink':    function('s:open_file'),
                \ 'options': '--ansi --prompt "RgBoth> " --preview-window "right:60%:wrap" --preview "' . l:preview_cmd . '"',
                \ 'down':    '100%'
                \ }

    call fzf#run(l:options)
endfunction

function! s:open_file(line) abort
    execute 'edit' a:line
endfunction

command! -nargs=+ RgBoth call RgBoth(<f-args>)





" to close and delete all the other buffers
command! BufOnly silent! execute '%bd|e#|bd#|normal `"'
command! B silent! execute 'Buffers'

com! FormatJSON %!python -m json.tool
com! JQFormatJSON %!jq


" diff git-gutter againse master
" <Bar> is '|' to separate multiple commands.
" nmap <leader>dm :let g:gitgutter_diff_base = 'master' <Bar> GitGutter<CR>
" nmap <leader>dm :let g:gitgutter_diff_base = 'develop' <Bar> GitGutter<CR>
" nmap <leader>dh :let g:gitgutter_diff_base = 'head' <Bar> GitGutter<CR>
" Add a command to set the diff base to the current commit
command! GitGutterDiffHead :let g:gitgutter_diff_base = 'head' <Bar> GitGutter
command! -nargs=? GGDH :execute 'let g:gitgutter_diff_base = "HEAD' . (empty(<q-args>) ? '' : '~' . <q-args>) . '"' <Bar> GitGutter
" Add a command to set the diff base to 'develop'
command! GitGutterDiffDevelop :let g:gitgutter_diff_base = 'develop' <Bar> GitGutter
command! GGDD :let g:gitgutter_diff_base = 'origin/develop' <Bar> GitGutter
command! GGDM :let g:gitgutter_diff_base = 'origin/master' <Bar> GitGutter
" Add a command to set the diff base to HEAD~n (takes a number argument)
command! -nargs=1 GGD :execute 'let g:gitgutter_diff_base = "HEAD~' . <args> . '"' <Bar> GitGutter


" Map some frequently used test commands
command TestUseDocker let test#python#djangotest#executable = 'docker-compose exec app python manage.py test'
command TestUserLocal let test#python#djangotest#executable = 'python3 manage.py test'
command TestStrDispatch let test#strategy = 'dispatch'
command TestStrNeovim let test#strategy = 'neovim'
" Open curent file in vscode focusing at the current_line
command Code call system('code -g ' . expand('%') . ':' . line('.'))
command Icode call system('code-insiders -g ' . expand('%') . ':' . line('.'))
command Cursor call system('cursor -g ' . expand('%') . ':' . line('.'))
command Agy call system('agy -g ' . expand('%') . ':' . line('.'))
" command Pycharm call system('pycharm --line ' . expand('%') . ':' . line('.'))
" Open curent file in pycharm focusing at the current_line
command Pycharm call system('pycharm --line ' . line('.') . ' ' . expand('%'))

" Copy file name shortcuts
command CopyFilename let @+=expand('%:t:r')
command CopyFilenameExt let @+=expand('%:t')
command CopyFilenameFullPath let @+=expand('%:p')
command CopyFilenameHomePath let @+=expand('%:p:~')
command CopyFileRelativePath let @+=expand('%')
command CopyFileFullPath let @+=expand('%:p:h')
command CopyFileHomePath let @+=expand("%:p:~:h")


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

" command to format document with Coc prettier
" command! -nargs=0 FormatCoc :call CocAction('format')
command! -nargs=0 PrettierCoc :CocCommand prettier.forceFormatDocument
" command! -nargs=0 FormatCoc :CocCommand editor.action.formatDocument
" Add `:Format` command to format current buffer
command! -nargs=0 FormatCoc :call CocActionAsync('format')
" Add `:Fold` command to fold current buffer
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" command to format pgsql with visual selection 
command! -range=% FormatPgsql <line1>,<line2>!pg_format -s 2 -u 2 -U 1 -w 80 -g -i

autocmd FileType python let b:coc_root_patterns = ['.git', '.env', '.venv', '__pycache__', '.pytest_cache', '.mypy_cache', '.tox', 'venv', 'env']


" Command to disable Python breakpoints by setting PYTHONBREAKPOINT to 0
command! DisableBreakpoints :let $PYTHONBREAKPOINT = "0"

" Command to enable Python breakpoints by unsetting PYTHONBREAKPOINT
command! EnableBreakpoints :unlet $PYTHONBREAKPOINT

" Command to delete lines containing 'breakpoint()' in all open buffers and save them
command! DelBreakpoints :bufdo g/breakpoint()/d | update

" 20210503 - Add commmand to open current file on Github with line number
" command! GBrowseAtLine execute line('.') . 'GBrowse'
" command! GBrowseAtLine! execute line('.') . 'GBrowse!'
command! -bang GBrowseAtLine execute line('.') . 'GBrowse' . ( '<bang>' == '!' ? '!' : '' )


function! BrowseBlame()
  silent execute 'GBrowse!' . ( '<bang>' == '!' ? '!' : '' )
  let url = getreg('+')
  let url = substitute(url, '/blob/', '/blame/', '')
  if a:firstline != a:lastline
    let line_range = "#" . "L" . a:firstline . "-L" . a:lastline
    let url = url . line_range
  else
    let url = url . "#" . "L" . a:firstline
  endif
  execute '!open ' . shellescape(url)
endfunction

command! -range GBrowseBlame execute line('.') . 'call BrowseBlame()' . ( '<bang>' == '!' ? '!' : '' )

" 2019-05-31 Auto close the preview window of jedi-deoplete
" https://jdhao.github.io/2018/12/24/centos_nvim_install_use_guide_en/
autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | pclose | endif

" https://thoughtbot.com/blog/opt-in-project-specific-vim-spell-checking-and-word-completion
" Spell Check
autocmd BufRead,BufNewFile *.md set filetype=markdown

" Spell-check Markdown files
autocmd FileType markdown setlocal spell

" Spell-check Git messages
autocmd FileType gitcommit setlocal spell
