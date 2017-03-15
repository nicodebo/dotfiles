" Author: nicodebo
" Description: vim/nvim configuration file
" Last Change: 2017 Mar 15
" Guidelines:
"        * When a section become to large, make it into a separate file inside
"          the config directory.
"        * Autocommands that operate on filetype are to be placed inside the
"          ~/.dotfile/nvim/after/ftplugin directory for maintainabilily
"          purpose.
"        * Function not directly called by user can be placed in the autoload
"          folder

" Plugin management ------------------------------------------------------- {{{

" auto-install vim-plug
" if empty(glob('~/.config/nvim/autoload/plug.vim'))
"   silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
"     \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
"   autocmd VimEnter * PlugInstall | source $MYVIMRC
" endif

" call plug#begin('~/.config/nvim/plugged')

" fonction section
" function! BuildComposer(info)
"     if a:info.status != 'unchanged' || a:info.force
"         !cargo build --release
"         UpdateRemotePlugins
"     endif
" endfunction

" plugin section
"Plug 'https://github.com/jalvesaq/vimcmdline' "repl
"Plug 'https://github.com/kassio/neoterm' "repc1ba734
"Plug 'https://github.com/SirVer/ultisnips' "snippets engine
"Plug 'https://github.com/honza/vim-snippets' "source snippets
"Plug 'https://github.com/majutsushi/tagbar' "tag : code navigation
"Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
"Plug 'https://github.com/zchee/deoplete-jedi' "source autocomplete python
"Plug 'https://github.com/zchee/deoplete-clang' "source completion for c language
"Plug 'https://github.com/Shougo/neco-vim' "source completion for vimL commands
"Plug 'https://github.com/Shougo/neco-syntax' "source completion for vimL group
" theme section
    " neovim related project ones
    "Plug 'https://github.com/joshdick/onedark.vim'
"Plug 'https://github.com/morhetz/gruvbox'
" Plug 'https://github.com/mhartington/oceanic-next'
"Plug 'https://github.com/MaxSt/FlatColor'
"Plug 'https://github.com/iCyMind/NeoSolarized'
    "other ones
"Plug 'https://github.com/zefei/cake16'
"Plug 'https://github.com/john2x/flatui.vim'
"Plug 'https://github.com/junegunn/seoul256.vim'
    "Plug 'https://github.com/reedes/vim-colors-pencil'
    "Plug 'https://github.com/sosz/vim-darcula-theme'
"Plug 'https://github.com/zandrmartin/vim-distill'
"Plug 'https://github.com/Haron-Prime/evening_vim'
"Plug 'https://github.com/Haron-Prime/Antares'
"Plug 'https://github.com/Happykat/NeoFlat'
"Plug 'https://github.com/jacoborus/tender.vim'
"Plug 'https://github.com/whatyouhide/vim-gotham' " my favorite theme
"Plug 'https://github.com/frankier/neovim-colors-solarized-truecolor-only'
"Plug 'https://github.com/freeo/vim-kalisi'
"Plug 'https://github.com/chriskempson/vim-tomorrow-theme'
"Plug 'https://github.com/GertjanReynaert/cobalt2-vim-theme'
"Plug 'https://github.com/nanotech/jellybeans.vim'
"Plug 'https://github.com/justinmk/molokai'
"Plug 'https://github.com/w0ng/vim-hybrid'
"Plug 'https://github.com/AlxHnr/clear_colors'
"Plug 'https://github.com/daddye/soda.vim'
"Plug 'https://github.com/Soares/base16.nvim'
" call plug#end()

" }}}

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
"set cursorline                   " Highlight current cursor line
"set ruler                        " set cursor position in the status line
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
    let $NVIM_TUI_ENABLE_CURSOR_SHAPE=1 " the cursor is a pipe in insert mode.
    set inccommand=split
endif

if (has("termguicolors"))
    set termguicolors            " enable true color in the terminal
endif

set complete+=k                  " add dictionnary as Completion source.
set dictionary+=/usr/share/dict/british-english
"TODO: Set dictionnary only for specific filetype
"TODO: make this vimrc setup compatible with vim8, see :help vim-differences
"TODO:Stop using plugin and use build in features https://www.reddit.com/r/vim/comments/4zt02l/why_would_i_use_syntastic_or_neomake/
"TODO: For documentation use, http://www.vim.org/scripts/script.php?script_id=3893
set dictionary+=/usr/share/dict/french
set shell=zsh

" Removed the default text width as, for exemple, the shipped gitcommit.vim
" after plugin set tw=72 only if tw=0. Othewise it does not override user
" configuration. I should define textwidth for each language I am working with
" instead of setting a global/default one.
" default textwidth and identation
" don't touch to tabstop (8)
" don't touch to smarttab (on), use shiftwidth instead of tabstop
"set textwidth=79
set colorcolumn=+1
"set expandtab           " enter spaces when tab is pressed
"set softtabstop=4
"set shiftwidth=4        " number of spaces to use for auto indent

" Set default filetype for .tex file, in order to have the correct syntay
" highliting
let g:tex_flavor = 'latex'

" Leader key mapping
" map those special key before calling them in mapping command hereafter
let maplocalleader = ";"         " Used by nvim-r, vimtex.
let mapleader = ","              " Change the map leader key from / to ,

colorscheme base16-oceanicnext

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
  nunmap cgc
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
" Éviter les ralentissements

let g:vimtex_mappings_enabled=0

nmap <localleader>li <plug>(vimtex-info)
nmap <localleader>lI <plug>(vimtex-info-full)
nmap <localleader>lx <plug>(vimtex-reload)
nmap <localleader>ls <plug>(vimtex-toggle-main)

nmap ds$ <plug>(vimtex-env-delete-math)
nmap ls$ <plug>(vimtex-env-change-math)
nmap dse <plug>(vimtex-env-delete)
nmap lse <plug>(vimtex-env-change)
nmap jse <plug>(vimtex-env-toggle-star)

nmap dsc <plug>(vimtex-cmd-delete)
nmap lsc <plug>(vimtex-cmd-change)
nmap jsc <plug>(vimtex-cmd-toggle-star)
nmap <F7> <plug>(vimtex-cmd-create)
xmap <F7> <plug>(vimtex-cmd-create)
imap <F7> <plug>(vimtex-cmd-create)

nmap jsd <plug>(vimtex-delim-toggle-modifier)
vmap jsd <plug>(vimtex-delim-toggle-modifier)
imap ]] <plug>(vimtex-delim-close)

" latexmk related mapping
nmap <localleader>ll <plug>(vimtex-compile-toggle)
nmap <localleader>lo <plug>(vimtex-compile-output)
nmap <localleader>lL <plug>(vimtex-compile-selected)
xmap <localleader>lL <plug>(vimtex-compile-selected)
nmap <localleader>lk <plug>(vimtex-stop)
nmap <localleader>lK <plug>(vimtex-stop-all)
nmap <localleader>le <plug>(vimtex-errors)
nmap <localleader>lc <plug>(vimtex-clean)
nmap <localleader>lC <plug>(vimtex-clean-full)
nmap <localleader>lg <plug>(vimtex-status)
nmap <localleader>lG <plug>(vimtex-status-all)

" motion related mapping
nmap ]] <plug>(vimtex-]])
xmap ]] <plug>(vimtex-]])
omap ]] <plug>(vimtex-]])

nmap ][ <plug>(vimtex-][)
xmap ][ <plug>(vimtex-][)
omap ][ <plug>(vimtex-][)

nmap [] <plug>(vimtex-[])
xmap [] <plug>(vimtex-[])
omap [] <plug>(vimtex-[])

nmap [[ <plug>(vimtex-[[)
xmap [[ <plug>(vimtex-[[)
omap [[ <plug>(vimtex-[[)

nmap % <plug>(vimtex-%)
xmap % <plug>(vimtex-%)
omap % <plug>(vimtex-%)

" text object related mappings
xmap ac <plug>(vimtex-ac)
omap ac <plug>(vimtex-ac)

xmap ic <plug>(vimtex-ic)
omap ic <plug>(vimtex-ic)

xmap ad <plug>(vimtex-ad)
omap ad <plug>(vimtex-ad)

xmap id <plug>(vimtex-id)
omap id <plug>(vimtex-id)

xmap ae <plug>(vimtex-ae)
omap ae <plug>(vimtex-ae)

xmap ie <plug>(vimtex-ie)
omap ie <plug>(vimtex-ie)

xmap a$ <plug>(vimtex-a$)
omap a$ <plug>(vimtex-a$)

xmap i$ <plug>(vimtex-i$)
omap i$ <plug>(vimtex-i$)

" toc related
nmap <localleader>lt <plug>(vimtex-toc-open)
nmap <localleader>lT <plug>(vimtex-toc-toggle)

" label related
nmap <localleader>ly <plug>(vimtex-labels-open)
nmap <localleader>lY <plug>(vimtex-labels-toggle)

" viewer
nmap <localleader>lv <plug>(vimtex-view)
nmap <localleader>lr <plug>(vimtex-reverse-search)

" insert mapping list
nmap <localleader>lm <plug>(vimtex-imaps-list)

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
augroup END

augroup bepo_clash
  autocmd!
  autocmd VimEnter * call UnmapCommentary()
augroup END

" }}}

" Junk -------------------------------------------------------------------- {{{
"ref https://github.com/tpope/vim-markdown
" allow to syntax highlight code inside ``` ```
let g:markdown_fenced_languages = ['html', 'python', 'bash=sh', 'dosini']
" Always display the status line, even if only one window is displayed
" default on nvim to 2
"set laststatus=2


" Use visual bell instead of beeping when doing something wrong
"set visualbell

" And reset the terminal code for the visual bell.  If visualbell is set,
" and
" this line is also included, vim will neither flash nor beep.  If
" visualbell
" is unset, this does nothing.
" set t_vb=

" Quickly time out on keycodes, but never time out on mappings
"set notimeout ttimeout ttimeoutlen=200

"let g:indentLine_enabled = 1

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


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Custom key mapping
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" all the keybinds from the diffent plugin are placed in this configuration
" file

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Neoterm
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"nnoremap <silent> <C-S> :TREPLSendFile<cr>
"nnoremap <silent> <C-t> :TREPLSend<cr>
"vnoremap <silent> <C-t> :TREPLSend<cr>


" Useful maps
" hide/close terminal
"nnoremap <silent> ,th :call neoterm#close()<cr>
" clear terminal
"nnoremap <silent> ,tl :call neoterm#clear()<cr>
" kills the current job (send a <c-c>)
"nnoremap <silent> ,tc :call neoterm#kill()<cr>

" Git commands
"command! -nargs=+ Tg :T git <args>

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
"TODO: see if vimcmdline plugin provide an api like neoterm does.

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Misc
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" keybind toggle paste
"nnoremap <F2> :set invpaste paste?<CR>
"set pastetoggle=<F2>
"set showmode

"keybinds buffer
"nmap <F4> :bn<CR>

"clear last search.
nmap <F3> :let @/ = ""<CR>

" Terminal emulator
tnoremap c<Esc> <C-\><C-n>
"TODO: change the mapping. When opening vim inside vim, the c navigation key is
"inactive.

"tnoremap <A-c> <C-\><C-n><C-w>c
"tnoremap <A-t> <C-\><C-n><C-w>t
"tnoremap <A-s> <C-\><C-n><C-w>s
"tnoremap <A-r> <C-\><C-n><C-w>r

" delete the current line, then paste it below the one we're on now.

"let g:UltiSnipsExpandTrigger="<tab>"
"let g:UltiSnipsJumpForwardTrigger="<c-b>"
"let g:UltiSnipsJumpBackwardTrigger="<c-z>"

"onoremap <silent> i/ :<C-U>normal! T/vt/<CR> " inside /
"onoremap <silent> a/ :<C-U>normal! F/vf/<CR> " around /

"nmap <F10> :TagbarToggle<CR>
"nmap <F10> :TagbarOpenAutoClose<CR>


"""""""""""""""""" deoplete clang plugin settings
"let g:deoplete#sources#clang#libclang_path='/usr/lib/llvm-3.8/lib/libclang.so.1'
"let g:deoplete#sources#clang#clang_header='/usr/lib/llvm-3.8/lib/clang'

""""""""""""""""""""themes

" TODO: set background=dark depending on the colorscheme ?
" for exemple I don't need it when OceanicNext or gotham
" TODO: Désactiver également pour les heredocs de bash. Peut être que l'on peut invoquer le mélange d'indentation que pour certain fichier.
" TODO: fonction Tab2Space : bricoler la fonction pour qu'il y ai une demande
" de confirmation avant remplacement.
" TODO: conditional  highlight for the status line: http://got-ravings.blogspot.fr/2008/10/vim-pr0n-conditional-stl-highlighting.html

"""""""""""""""""""""" tagbar settings

"Solve conflict between bépo and tagbar mappings
"let g:tagbar_map_togglesort = "f"
"let g:tagbar_map_toggleautoclose = "g"
"""""""""""""""""""""" end tagbar settings
" TODO: colorschemen tutorial
" https://bbkane.github.io/2016/12/18/Vim-Color-Schemes.html

" TODO: completion
" https://www.reddit.com/r/vim/comments/5qgh91/vim_and_php/

"TODO:* vim8 package manager tuto:
"https://gist.github.com/manasthakur/ab4cf8d32a28ea38271ac0d07373bb53
"next level project: https://bitbucket.org/vimcommunity/vim-pi/issues?status=new&status=open
"https://github.com/rstacruz/vimbower

"TODO: https://www.reddit.com/r/vim/comments/5607lj/how_to_do_90_of_what_plugins_do_with_just_vim/

" For snippets, use :h skeleton, along with ultisnips

" TIPS: Test color  :runtime syntax/colortest.vim
" TIPS: $time nvim +q : to see start up time of vim.
" TIPS: see https://github.com/bchretien/vim-profiler: for detailed startuptime
" or https://github.com/hyiltiz/vim-plugins-profile
" TODO: Have a look at https://github.com/kana/vim-textobj-user
" TODO: look at https://github.com/editorconfig/editorconfig-vim
" TODO: look at https://www.reddit.com/r/vim/comments/5bb69l/any_idea_about_a_better_source_code_indexing/

" Reference
"        * recommandation : https://github.com/romainl/idiomatic-vimrc
"        * http://www.moolenaar.net/habits.html
"        * https://gist.github.com/ajh17
"        * https://github.com/vim-syntastic/syntastic/tree/master/syntax_checkers

" TODO: see how to enable the matchit.vim. help matchit
" INFO: problem with formatprg: https://groups.google.com/forum/#!msg/vim_dev/cFK1UjstyAk/mreb2H4VCtoJ
" see if neovim dev are going to solve this problem ?
" formatprg is now global-local in vim8: https://github.com/vim/vim/commit/9be7c04e6cd5b0facedcb56b09a5bcfc339efe03
" see when it will come to neovim
" see https://github.com/neovim/neovim/wiki/Merging-patches-from-upstream-Vim to
" understand how vim patch are merge to neovim https://github.com/neovim/neovim/blob/master/runtime/doc/options.txt#L2743
" to see if formatprg is now global

" TODO: install https://github.com/rhysd/devdocs.vim ?

" TODO: check https://opensource.com/article/17/2/vim-plugins-writers

" * vimscript guidelines : https://google.github.io/styleguide/vimscriptguide.xml
" * don't modify tabstop, instead use shiftwidth. shiftwidth will be used instead of tabstop since smartab in on by defaut anyway.
" * many shipped filetype plugin define a 'sane' tw only if tw==0, that is when the user hasn't modify the tw in is vimrc. Thus don't set tw here but only in after dir and only when it isn't already defined in $VIMRUNTIME/ftplugin/language.vim
"http://www.vex.net/~x/python_and_vim.html
" * if vim warn me about language not available for spell and doesn't want to download. Type the command :set spelllang=fr and turn on spell, set spell It should work prompt me to download language file.

" }}}
