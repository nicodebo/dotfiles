" Author: nicodebo
" Description: vim/nvim configuration file
" Last Change: 2017 May 16
" Guidelines:
"        * When a section become to large, make it into a separate file inside
"          the config directory.
"        * Autocommands that operate on filetype are to be placed inside the
"          ~/.dotfile/nvim/after/ftplugin directory for maintainabilily
"          purpose.
"        * Function not directly called by user can be placed in the autoload
"          folder

" Source vimrc files ------------------------------------------------------ {{{
" Source all configuration file from ~/.config/nvim/vimrc/
runtime! vimrc/**/*.vimrc
" }}}

" Vim settings ---------------------------------------------------- {{{

set number                       " Line numbers are good
set showcmd                      " Show incomplete cmds down the bottom
set showmode                     " Show current mode down the bottom
set showmatch                    " Show matching brackets.
set hidden                       " Hide buffers when they are abandoned
set scrolloff=3                  " set 3 lines between cursor and end of text.
set foldcolumn=1                 " column of width 1, that show folds
set cmdheight=1                  " set command line height
set title                        " terminal title on
set wildmode=list:longest
set wildignore=*.o,*.obj,*~ "stuff to ignore when tab completing
set wrap                         " turn on line wrapping
set linebreak                    "Wrap lines at convenient points
" I use a unicode curly array with a <backslash><space> as a wrap symbole
set showbreak=↪>\ 

" Modelines have historically been a source of security vulnerabilities.  As
" such, it may be a good idea to disable them and use the securemodelines
set nomodeline

" Use case insensitive search, except when using capital letters
set ignorecase
set smartcase

" Instead of failing a command because of unsaved changes, instead raise a
" dialogue asking if you wish to save changed files.
set confirm

" Use the same symbols as TextMate for tabstops and EOLs
" Afficher les espaces insécables, les tabulations, les fins de ligne, et les
" espaces en fin de ligne.
set listchars=nbsp:¤,tab:▸-,eol:¬,trail:.

" needed when copy-pasting error messages to github issue.
" the language has to be installed in the system
language en_US.UTF-8    " sets the language of the messages / ui (vim)

" neovim specific settings
if has('nvim')
    let guicursor='n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50
     \,a:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor
     \,sm:block-blinkwait175-blinkoff150-blinkon175'
    set inccommand=split
endif

if (has("termguicolors"))
    set termguicolors            " enable true color in the terminal
endif

set shell=zsh

" Removed the default text width as, for exemple, the shipped gitcommit.vim
" after plugin set tw=72 only if tw=0. Othewise it does not override user
" configuration. I should define textwidth for each language I am working with
" instead of setting a global/default one.
" default textwidth and identation
" don't touch to tabstop (8)
" don't touch to smarttab (on), use shiftwidth instead of tabstop
set colorcolumn=+1

" Leader key mapping
" map those special key before calling them in mapping command hereafter
let maplocalleader = ";"         " Used by nvim-r, vimtex.
let mapleader = ","              " Change the map leader key from / to ,

" allow to syntax highlight code inside ``` ``` in markdown
let g:markdown_fenced_languages = ['html', 'python', 'bash=sh', 'dosini']

" Set default filetype for .tex file, in order to have the correct syntax
" highlighting for .tex file
let g:tex_flavor = 'latex'

colorscheme base16-oceanicnext

" Path to the python3 provider
let g:python3_host_prog = '/home/debz/.local/share/virtualenvs/python3_neovim_provider/bin/python3'

" }}}

" Plugin settings --------------------------------------------------------- {{{

" vim-commentary ---------------------------------------------------------- {{{


" https://github.com/tpope/vim-commentary/issues/36
" https://github.com/tpope/vim-commentary/issues/46
" Remove clash between bépo and vim-commentary default mapping.
" Indeed, with default values, when pressing 'c' in normal mode, the movement
" was delayed because of the <Plug>ChangeCommentary Default value which start
" with the c key

" fix https://github.com/tpope/vim-commentary/issues/84
function! UnmapCommentary()
  unmap gc
  nunmap gcc
  nunmap gcu
endfunction

xmap <leader>c  <Plug>Commentary
nmap <leader>c  <Plug>Commentary
omap <leader>c  <Plug>Commentary
nmap <leader>cc <Plug>CommentaryLine
nmap l<leader>c <Plug>ChangeCommentary
nmap <leader>cu <Plug>Commentary<Plug>Commentary

    " }}}

" - Vimtex ---------------------------------------------------------------- {{{

let g:vimtex_enabled=1    " enable the vimtex plugin
let g:vimtex_disable_version_warning=0  " Warn if vim -v unsupported
let g:vimtex_view_method = 'zathura'    " Use zathura for pdf view
let g:vimtex_quickfix_mode=0            " Don't open quickfix automatically

" Configuration of the callback function and backward search.
" nvr should be in the $PATH, otherwise the value should be the full path to
" the nvr executable.
let g:vimtex_latexmk_progname='nvr'

" Résolution des conflits entre le bépo et les mappings par défaut du plugin
" vimtex.
let g:vimtex_mappings_enabled=0

  " }}}

" }}}

" User defined functions -------------------------------------------------- {{{

" Convert spaces to tabs and vice versa ----------------------------------- {{{
" Ref: http://vim.wikia.com/wiki/VimTip1592
" Return indent (all whitespace at start of a line), converted from
" tabs to spaces if what = 1, or from spaces to tabs otherwise.
" When converting to tabs, result has no redundant spaces.
function! Indenting(indent, what, cols)
  let spccol = repeat(' ', a:cols)
  let result = substitute(a:indent, spccol, '\t', 'g')
  let result = substitute(result, ' \+\ze\t', '', 'g')
  if a:what == 1
    let result = substitute(result, '\t', spccol, 'g')
  endif
  return result
endfunction

" Convert whitespace used for indenting (before first non-whitespace).
" what = 0 (convert spaces to tabs), or 1 (convert tabs to spaces).
" cols = string with number of columns per tab, or empty to use 'tabstop'.
" The cursor position is restored, but the cursor will be in a different
" column when the number of characters in the indent of the line is changed.
function! IndentConvert(line1, line2, what, cols)
  let savepos = getpos('.')
  let cols = empty(a:cols) ? &tabstop : a:cols
  execute a:line1 . ',' . a:line2 . 's/^\s\+/\=Indenting(submatch(0), a:what, cols)/e'
  call histdel('search', -1)
  call setpos('.', savepos)
endfunction
command! -nargs=? -range=% Space2Tab call IndentConvert(<line1>,<line2>,0,<q-args>)
command! -nargs=? -range=% Tab2Space call IndentConvert(<line1>,<line2>,1,<q-args>)
command! -nargs=? -range=% RetabIndent call IndentConvert(<line1>,<line2>,&et,<q-args>)
" }}}

" Remove/show unwanted spaces --------------------------------------------- {{{

"Ref: http://vim.wikia.com/wiki/Remove_unwanted_spaces

function! ShowSpaces(...)
  let @/='\v(\s+$)|( +\ze\t)'
  let oldhlsearch=&hlsearch
  if !a:0
    let &hlsearch=!&hlsearch
  else
    let &hlsearch=a:1
  end
  return oldhlsearch
endfunction
"TODO: This function does not seem to work but I don't use it a lot anyway. I'm
"using TrimSpaces

function! TrimSpaces() range
  let oldhlsearch=ShowSpaces(1)
  execute a:firstline.",".a:lastline."substitute ///gec"
  let &hlsearch=oldhlsearch
endfunction

command! -bar -nargs=? ShowSpaces call ShowSpaces(<args>)
command! -bar -nargs=0 -range=% TrimSpaces <line1>,<line2>call TrimSpaces()
"nnoremap <F12>     :ShowSpaces 1<CR>
"nnoremap <S-F12>   m`:TrimSpaces<CR>``
"vnoremap <S-F12>   :TrimSpaces<CR>
" }}}

" Absolute/Relative number toggle ------------------------------------- {{{

"Toggle between absolute number and relative number
"Ref: http://jeffkreeftmeijer.com/2012/relative-line-numbers-in-vim-for-super-fast-movement/
function! NumberToggle()
  if(&relativenumber == 1)
    set number
    set norelativenumber
  else
    set number
    set relativenumber
  endif
endfunc

    " }}}

" Update buffer when git branch invoked ----------------------------------- {{{

" This function allows to update (:checktime) all the listed buffers. The
" buffers that have disappeared from the disque (outside of vim) are unloaded
" while keeping the corresponding windows split.
" A typical used case is when doing a git checkout from inside an embeded
" terminal. The buffer have to be updated to reflect the current branch.
"http://vi.stackexchange.com/questions/2587/using-a-variable-in-a-regex-pattern
"http://stackoverflow.com/questions/17931507/vimscript-number-of-listed-buffers
"http://unix.stackexchange.com/questions/320121/how-to-get-the-file-path-of-a-buffer
"http://stackoverflow.com/questions/3098521/vimscript-how-to-detect-if-specific-file-exists

function! MajBuffers()
  let l:current_win = winnr()
  silent! execute 'checktime'
  " All 'possible' buffers that may exist
  for n in filter(range(1, bufnr('$')), 'buflisted(v:val)')
    "echo print on a new line, echon does and is needed.
    echo n
    redir => l:filepath
    silent! execute "echon expand('#" . n . ":p')"
    redir END
    echo '----------------------------------------------------'
    echo l:filepath
    echo '----------------------------------------------------'
    if filereadable(fnameescape(l:filepath))
      echo 'file readable'
    else
      if l:filepath=~#"^term://\."
        echo 'this is a terminal'
      else
        echo 'file not readable'
        let l:bufn_win=bufwinnr(n)
        if l:bufn_win > 0
          execute l:bufn_win . "wincmd w"
          execute 'bp|bd! #'
        endif
      endif
    endif
  endfor
  execute l:current_win . "wincmd w"
endfunction

"TODO: Doesn't take into account tabs
"TODO: See if the fact that a buffer can be a directory can cause unwanted
"behaviour

    " }}}

" Last modified for init.vim ---------------------------------------------- {{{

function! LastMod()
  if line("$") > 20
    let l = 20
  else
    let l = line("$")
  endif
  exe "1," . l . "g/Last Change: /s/Last Change: .*/Last Change: " .
  \ strftime("%Y %b %d")
endfun

    " }}}

" ctags command ----------------------------------------------------------- {{{

command! MakeTags !ctags .

    " }}}

" }}}

" Status line ------------------------------------------------------------- {{{

" Ref: http://got-ravings.blogspot.fr/2008/10/vim-pr0n-statusline-whitespace-flags.html

set statusline=  " start with an empty status line when sourcing vimrc
set statusline+=%t       "tail of the filename
set statusline+=\ 
set statusline+=[%{strlen(&fenc)?&fenc:'none'}, "file encoding
set statusline+=%{&ff}] "file format
set statusline+=%h      "help file flag
set statusline+=%m      "modified flag
set statusline+=%r      "read only flag
set statusline+=%y      "filetype
"set statusline+=%#Error# " set error highlight color
set statusline+=%{statusline#TabWarning()} " warning if &et wrong or mixedindent
set statusline+=%{statusline#TrailingSpaceWarning()}
"set statusline+=%*      " go back to default highlight color
set statusline+=%=      "left/right separator
set statusline+=%v,     "cursor column
set statusline+=%l/%L   "cursor line/total lines
set statusline+=\ %P    "percent through file

" }}}

" Mappings ---------------------------------------------------------------- {{{

" Shortcut to rapidly toggle `set list`
nnoremap <leader>l :set list!<CR>

nnoremap <leader>n :call NumberToggle()<cr>

" Simple command to display open buffer and load the desired one by entering
" its number and pressing enter.
nnoremap <leader>p :buffers<CR>:buffer<Space>

" switch to previous buffer
nnoremap <leader>d :b#<CR>

nnoremap <leader>u :call MajBuffers()<cr>
nnoremap <leader>m :MakeTags<cr>

"clear last search.
nmap <F3> :let @/ = ""<CR>

" Terminal emulator
tnoremap c<Esc> <C-\><C-n>
"TODO: change the mapping. When opening vim inside vim, the c navigation key is
"inactive.

" }}}

" Learn vimscript the hard way tips --------------------------------------- {{{
"move current line down
"noremap - ddp

"move current line up
"noremap - dd2sp

"in insert mode convert to current word to uppercase
"inoremap <c-u> <esc>viwU

"in normal mode convert to current word to uppercase
"nnoremap <c-u> viwU

"Edit my vimrc file
nnoremap <leader>ev :vsplit $MYVIMRC<cr>

"Source my vimrc file
nnoremap <leader>sv :source $MYVIMRC<cr>

"Double quote around the current word in normal mode
nnoremap <leader>" viw<esc>a"<esc>hbi"<esc>lel

"Single quote around the current word in normal mode
nnoremap <leader>' viw<esc>a'<esc>hbi'<esc>lel

"Double quote around the selection in visual mode
vnoremap <leader>" c""<esc>P

"Single quote around the selection in visual mode
vnoremap <leader>' c''<esc>P

"Go to the beginning of the current line
"Override going to top of window
"see :help H
"nnoremap C 0

"Go to the end of the current line
"Override going to bottom of window
"see :help L
"nnoremap R $

"inside next parenthesis
"type 'lin(' or 'din(' in normal mode to use
" onoremap in( :<c-u>normal! f(vi(<cr>

"inside last parenthesis
" onoremap il( :<c-u>normal! F)vi(<cr>

"around next parenthesis
" onoremap an( :<c-u>normal! f(va(<cr>

"around last parenthesis
" onoremap al( :<c-u>normal! F)va(<cr>

"inside next curly brackets
"type 'lin{' or 'din{' in normal mode to use
" onoremap in{ :<c-u>normal! f{vi{<cr>

"inside last curly brackets
" onoremap il{ :<c-u>normal! F{vi{<cr>

"around next curly brackets
" onoremap an{ :<c-u>normal! f{va{<cr>

"around last curly brackets
" onoremap al{ :<c-u>normal! F{va{<cr>

"inside next quote
"type 'lin'' or 'din'' in normal mode to use
" onoremap in' :<c-u>normal! f'vi'<cr>

"inside last quote
" onoremap il' :<c-u>normal! F'vi'<cr>

"around next quote
" onoremap an' :<c-u>normal! f'va'<cr>

"around last quote
" onoremap al' :<c-u>normal! F'va'<cr>

"inside next double quote
"type 'lin"' or 'din"' in normal mode to use
" onoremap in" :<c-u>normal! f"vi"<cr>

"inside last double quote
" onoremap il" :<c-u>normal! F"vi"<cr>

"around next double quote
" onoremap an" :<c-u>normal! f"va"<cr>

"around last double quote
" onoremap al" :<c-u>normal! F"va"<cr>

" }}}

" Autocommands ------------------------------------------------------------ {{{

" NOTE: for the LastMod function to find the pattern, some text must exists at
" the right of the ':'. (i.e. Last Change: text)
augroup vimrc
  autocmd!
  "write the date
  autocmd BufWritePre,FileWritePre *.vim,*.vimrc ks|call LastMod()|'s
augroup END

augroup statusline
  autocmd!
  "recalculate the tab warning flag when idle and after writing
  autocmd CursorHold,BufWritePost * unlet! b:statusline_tab_warning
  "recalculate the trailing whitespace warning when idle, and after saving
  autocmd cursorhold,bufwritepost * unlet! b:statusline_trailing_space_warning
augroup END

" set muttrc file type for the mutt configuration file that are not called
" muttrc as only this one is recognized as muttrc.
augroup setfiletype
  autocmd!
  autocmd BufNewFile,BufRead *.muttrc setlocal filetype=muttrc
  autocmd BufNewFile,BufRead */zsh/zfunction/* setlocal filetype=zsh
  autocmd BufNewFile,BufRead */zsh/zcompletion/* setlocal filetype=zsh
augroup END

augroup bepo_clash
  autocmd!
  " unmap vim-commentary mappings
  autocmd VimEnter * call UnmapCommentary()
augroup END

augroup ironmapping
  autocmd!
  autocmd Filetype python nmap <buffer> <localleader>t <Plug>(iron-send-motion)
  autocmd Filetype python vmap <buffer> <localleader>t <Plug>(iron-send-motion)
  autocmd Filetype python nmap <buffer> <localleader>p <Plug>(iron-repeat-cmd)
augroup END

" }}}

" Test -------------------------------------------------------------------- {{{
let g:LanguageClient_serverCommands = {
    \ 'rust': ['rustup', 'run', 'nightly', 'rls'],
    \ 'javascript': ['/opt/javascript-typescript-langserver/lib/language-server-stdio.js'],
    \ 'python': ['pyls']
    \ }

" Automatically start language servers.
let g:LanguageClient_autoStart = 1
let g:LanguageClient_signColumnAlwaysOn = 1

nnoremap <silent> K :call LanguageClient_textDocument_hover()<CR>
nnoremap <silent> gd :call LanguageClient_textDocument_definition()<CR>
nnoremap <silent> <F2> :call LanguageClient_textDocument_rename()<CR>

" }}}

" Junk -------------------------------------------------------------------- {{{

" set complete+=k                  " add dictionnary as Completion source.
" set dictionary+=/usr/share/dict/british-english
" set dictionary+=/usr/share/dict/french
" TODO: Set dictionnary only for specific filetype
" TODO: For documentation use, http://www.vim.org/scripts/script.php?script_id=3893
"ref https://github.com/tpope/vim-markdown

" TODO: check if line wrapping slow vim down.
" TODO: :help g:tex_fold_enabled and implement a tex filetype

"set foldmethod=syntax
"let g:tex_fold_enabled=1
"let g:vimsyn_folding='af'
"let g:xml_syntax_folding = 1
"let g:php_folding = 1
"let g:perl_fold = 1

" Note: The markdown previewer does not support pandoc engine
" see https://github.com/euclio/vim-markdown-composer/issues/21
" same for other plugin:
" see https://github.com/suan/vim-instant-markdown/issues/48
" essayer de convertir un ft=pandoc en html avec pandoc et voir si ça render
" bien dans firefox.

" TODO: faire un keybind pour switcher entre le dictionnaire anglais et le
" dictionnaire français.
" TODO:  intégrer ispell correction orthographique. peut être en couple avec le
" todo sur le dictionnaire


"Save a session
" nnoremap <leader>mk :mksession! ~/.vim_sessions/
"TODO: make a function that only take the name of the session and automatically
"save it inside ~/.vim_session, And create the .vim_session dir if does not
"exists
" TODO: nvim has a default vim session directory. See if I can use that
" instead. See : vim-differences.
"TODO: make a mapping for openning a session

" https://github.com/kassio/neoterm/issues/74
" This function allow to run a script directly in the IPython interpreter
" thanks to the magic commands. In IPython '%run script.py' is equivalent to
" 'python script.py' or 'ipython script.py' executed inside the
" gnome-terminal.
" function! s:RunIPython()
"   if g:neoterm.has_any()
"     "silent! T %reset -f
"         let cmd = "%reset -f"."\n"
"         silent! call neoterm#exec(cmd)
"   else
"     let cmd = "ipython -i --no-banner --no-confirm-exit --quick --quiet"
"     silent! call neoterm#do(cmd)
"   endif
"   let cmd = "%run " . expand('%') . "\n"
"   silent! call neoterm#exec(cmd)
" endfunction
" command! -nargs=* RunIPython call s:RunIPython()
"autocmd FileType python nnoremap <Leader>r :RunIPython<cr>

"function! s:RunExecutable()
"  if g:neoterm.has_any()
"        let cmd = "ls" . "\n"
"        silent! call neoterm#exec(cmd)
"  else
"    let cmd = "ls" . "\n"
"    silent! call neoterm#exec(cmd)
"  endif
"endfunction
"command! -nargs=* RunExecutable call s:RunExecutable()

"""""""""""""""""" deoplete clang plugin settings
"let g:deoplete#sources#clang#libclang_path='/usr/lib/llvm-3.8/lib/libclang.so.1'
"let g:deoplete#sources#clang#clang_header='/usr/lib/llvm-3.8/lib/clang'

""""""""""""""""""""themes

" TODO: fonction Tab2Space : bricoler la fonction pour qu'il y ai une demande
" de confirmation avant remplacement.
" TODO: conditional  highlight for the status line: http://got-ravings.blogspot.fr/2008/10/vim-pr0n-conditional-stl-highlighting.html

"TODO:* vim8 package manager tuto:
"https://gist.github.com/manasthakur/ab4cf8d32a28ea38271ac0d07373bb53
"next level project: https://bitbucket.org/vimcommunity/vim-pi/issues?status=new&status=open

"TODO: https://www.reddit.com/r/vim/comments/5607lj/how_to_do_90_of_what_plugins_do_with_just_vim/

" TIPS: Test color  :runtime syntax/colortest.vim
" TIPS: $time nvim +q : to see start up time of vim.
" TIPS: see https://github.com/bchretien/vim-profiler: for detailed startuptime
" or https://github.com/hyiltiz/vim-plugins-profile
" TODO: Have a look at https://github.com/kana/vim-textobj-user
" TODO: look at https://github.com/editorconfig/editorconfig-vim

" Reference
"        * recommandation : https://github.com/romainl/idiomatic-vimrc
"        * http://www.moolenaar.net/habits.html
"        * https://gist.github.com/ajh17
"        * https://github.com/vim-syntastic/syntastic/tree/master/syntax_checkers

" TODO: see how to enable the matchit.vim. help matchit


" TODO: check https://opensource.com/article/17/2/vim-plugins-writers

" * vimscript guidelines : https://google.github.io/styleguide/vimscriptguide.xml
" * don't modify tabstop, instead use shiftwidth. shiftwidth will be used instead of tabstop since smartab in on by defaut anyway.
" * many shipped filetype plugin define a 'sane' tw only if tw==0, that is when the user hasn't modify the tw in is vimrc. Thus don't set tw here but only in after dir and only when it isn't already defined in $VIMRUNTIME/ftplugin/language.vim
"http://www.vex.net/~x/python_and_vim.html
" * if vim warn me about language not available for spell and doesn't want to download. Type the command :set spelllang=fr and turn on spell, set spell It should work prompt me to download language file.

" }}}
