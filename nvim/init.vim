" Author: nicodebo
" Description: vim/nvim configuration file
" Last Change: 2018 Sep 09
" Guidelines:
"        * When a section become to large, make it into a separate file inside
"          the config directory.
"        * Autocommands that operate on filetype are to be placed inside the
"          ~/.dotfile/nvim/after/ftplugin directory for maintainabilily
"          purpose.
"        * Function not directly called by user can be placed in the autoload
"          folder

" Minpac ------------------------------------------------------------------ {{{

if empty(glob('~/.local/share/nvim/site/pack/minpac'))
  silent !git clone https://github.com/k-takata/minpac.git ~/.local/share/nvim/site/pack/minpac/opt/minpac
endif

if exists('*minpac#init')
  " minpac is loaded.
  call minpac#init({'dir': $XDG_DATA_HOME . '/nvim/site'})
  call minpac#add('k-takata/minpac', {'type': 'opt'})

  " Additional plugins here.
  " common
  call minpac#add('tpope/vim-commentary')
  call minpac#add('tpope/vim-surround')
  call minpac#add('tpope/vim-obsession')
  call minpac#add('yuttie/comfortable-motion.vim')
  call minpac#add('wellle/targets.vim')
  call minpac#add('SirVer/ultisnips')
  call minpac#add('honza/vim-snippets')
  call minpac#add('junegunn/fzf.vim')

  " lang server client
  call minpac#add('autozimu/LanguageClient-neovim', {'branch': 'next', 'do': {-> system('bash install.sh')}})
  " web
  call minpac#add('mattn/emmet-vim')
  call minpac#add('captbaritone/better-indent-support-for-php-with-html')
  call minpac#add('lumiliet/vim-twig') " syntax highlighting for twig files
  " LaTeX
  call minpac#add('lervag/vimtex')
  " colorscheme
  call minpac#add('fxn/vim-monochrome', {'type': 'opt'})
  call minpac#add('whatyouhide/vim-gotham', {'type': 'opt'})
endif

command! PackUpdate packadd minpac | source $MYVIMRC | call minpac#update()
command! PackClean  packadd minpac | source $MYVIMRC | call minpac#clean()

" }}}

" Source vimrc files ------------------------------------------------------ {{{
" Source all configuration file from ~/.config/nvim/vimrc/
runtime! vimrc/**/*.vimrc
" }}}

" Vim settings ---------------------------------------------------- {{{

set mouse=a                      " enable mouse support
set number                       " Line numbers are good
set showcmd                      " Show incomplete cmds down the bottom
set showmode                     " Show current mode down the bottom
set showmatch                    " Show matching brackets.
set hidden                       " Hide buffers when they are abandoned
set scrolloff=3                  " set 3 lines between cursor and end of text.
set foldcolumn=1                 " column of width 1, that show folds
set cmdheight=1                  " set command line height
set title                        " terminal title on
set wildmode=list:full
set wildignore=*.o,*.obj,*~ "stuff to ignore when tab completing
"python ignore
set wildignore+=*.pyc
set wrap                         " turn on line wrapping
set linebreak                    "Wrap lines at convenient points
" I use a unicode curly array with a <backslash><space> as a wrap symbole
set showbreak=↪>\ 
" search a tags file in the current directory of the buffer first, then in the
" under the pwd
set tags=./tags,tags

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

try
  " let g:monochrome_italic_comments = 1
  " colorscheme monochrome
  colorscheme gotham
catch /.*E185:.*/
  colorscheme darkblue
endtry

" Useful for the find command, allow to search the current directory and
" downwards its tree
set path=.,**

" Set Ctrl-z as a wildmenu trigger. I need to define it to be able to press Tab
" but within a macro. I can now use <C-z> inside a macro to trigger menu
set wildcharm=<C-z>

" }}}

" Plugin settings --------------------------------------------------------- {{{

" vim-surround ------------------------------------------------------------ {{{

" fix bépo clash
let g:surround_no_mappings=1
nmap ds  <Plug>Dsurround
nmap ls  <Plug>Csurround
nmap lS  <Plug>CSurround
nmap ys  <Plug>Ysurround
nmap yS  <Plug>YSurround
nmap yss <Plug>Yssurround
nmap ySs <Plug>YSsurround
nmap ySS <Plug>YSsurround
xmap K   <Plug>VSurround
xmap gK  <Plug>VgSurround

  " }}}

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

" Iron.nvim --------------------------------------------------------------- {{{

" deactivate default mappings
let g:iron_map_defaults=0

"   }}}

" LanguageClient-neovim --------------------------------------------------- {{{

 let g:LanguageClient_serverCommands = {
     \ 'python': ['pyls'],
     \ 'php': ['php', '/home/debz/.config/composer/vendor/bin/php-language-server.php']
     \ }

" Automatically start language servers.
let g:LanguageClient_autoStart = 1

"   }}}

" Ultisnips --------------------------------------------------------------- {{{

" Trigger configuration. Do not use <tab> if you use https://github.com/Valloric/YouCompleteMe.
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"

" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="vertical"

" ino <silent> <c-x><c-z> <c-r>=<sid>ulti_complete()<cr>
" let g:UltiSnipsSnippetDirectories=$HOME . '/Documents/Dev/dotfiles/nvim/ultisnips'
let g:UltiSnipsSnippetDirectories=['ultisnips']
" let g:UltiSnipsSnippetDirectories=$HOME . '.config/nvim/ultisnips'



"   }}}

" fzf.vim ----------------------------------------------------------------- {{{

" Customize fzf colors to match your color scheme
let g:fzf_colors =
\ { 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'hl':      ['fg', 'Comment'],
  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
  \ 'hl+':     ['fg', 'Statement'],
  \ 'info':    ['fg', 'PreProc'],
  \ 'border':  ['fg', 'Ignore'],
  \ 'prompt':  ['fg', 'Conditional'],
  \ 'pointer': ['fg', 'Exception'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header':  ['fg', 'Comment'] }

"   }}}

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

function! TrimSpaces() range
  let oldhlsearch=ShowSpaces(1)
  execute a:firstline.",".a:lastline."substitute ///gec"
  let &hlsearch=oldhlsearch
endfunction

command! -bar -nargs=? ShowSpaces call ShowSpaces(<args>)
command! -bar -nargs=0 -range=% TrimSpaces <line1>,<line2>call TrimSpaces()

" }}}

" Replace Nbsp with space ------------------------------------------------- {{{

function! NbspToSpaces()
  %s/\%xa0/ /gce
endfunction

command! NbspToSpaces call NbspToSpaces()

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

" Check if inside a git work dir ------------------------------------------ {{{

function! IsGitWorkTree()
  " Check if the current directory is a git worktree
  "return 0 if inside git worktree, 1 otherwise (outside git worktree or inside
  ".git
  let l:git=1
  " https://stackoverflow.com/questions/2180270/check-if-current-directory-is-a-git-repository#2180367
  let l:stdout = system("git rev-parse --git-dir 2> /dev/null")
  if l:stdout =~# '\.git' "I'm using regex and not equality because there is a newline char or whatever after 't' of '.git'
    let l:git=0
  endif
  return l:git
endfunction

    " }}}

" Set the grepprg  -------------------------------------------------------- {{{

function! SetGrepPrg()
  " keep default grepprg if not inside git dir, otherwise switch to git grep
  if IsGitWorkTree() == 0
    set grepprg=git\ grep\ -n\ $*
  endif
endfunction

    " }}}

" tags generation with ctags ---------------------------------------------- {{{

" asynchronous ctags, might be a bad idea, system() safer ?
function! UnivCtags()
  if IsGitWorkTree() == 0
    call jobstart(['bash', '-c', 'git ls-files | ctags --links=no -L-'])
  else
    call jobstart(['bash', '-c', 'ctags --links=no -R .'])
  endif
endfunction

    " }}}

" Autocomplete, get the tag of the current buffer only -------------------- {{{

" new implementation to find tag of current buffer by autocomplete
" http://andrewradev.com/2011/10/15/vim-and-ctags-finding-tag-definitions/
function! FindTagNamesByPrefix(prefix)
  let tag_set = {}
  let tags = taglist('^'.a:prefix)
  " filter tags to keep current only those from the current buffer
  let tags = filter(tags, '"' . expand('%:p') . '" =~# v:val["filename"]')
  for entry in tags
    if index(keys(tag_set), entry.name) == -1
      let tag_set[entry.name] = 1
    endif
  endfor
  echo keys(tag_set)
  return keys(tag_set)
endfunction

function! CompleteFindBufTag(lead, command_line, cursor_pos)
  if len(a:lead) > 0
    let tag_prefix = a:lead
  else
    let tag_prefix = '.'
  endif
  return sort(FindTagNamesByPrefix(tag_prefix))
endfunction

command! -nargs=1 -complete=customlist,CompleteFindBufTag FindBufTag :tag <args>

  " }}}

" populate loclist with tags of the current buffer only ------------------- {{{

" my implementation of
" http://andrewradev.com/2011/06/08/vim-and-ctags/
function! s:Function(name)
  " get all tags
  let tags = taglist('^.*')
  " filter tags to keep current only those from the current buffer
  let tags = filter(tags, '"' . a:name . '" =~# v:val["filename"]')
  " echo len(tags)

  " Prepare them for inserting in the quickfix window
  let loc_taglist = []
  for entry in tags
    let entry['cmd'] = substitute(entry['cmd'], '^/^\(.*\)$/$', '^\\V\1\\$', "")
    call add(loc_taglist, {
          \ 'text': entry['name'],
          \ 'pattern': entry['cmd'],
          \ 'filename': entry['filename'],
          \ })
  endfor
  " Place the tags in the location list of the current window, if possible
  if len(loc_taglist) > 0
    " call setloclist(0, loc_taglist, 'r', {'title': 'cur tag buffer'})
    call setloclist(0, loc_taglist)
    lopen
  else
    echo "No tags found for ".a:name
  endif
endfunction
command! TagFileLoc call s:Function(expand('%:p'))

  " }}}
 
" Get Snippets candidates ------------------------------------------------- {{{

function! s:ulti_complete() abort
    if empty(UltiSnips#SnippetsInCurrentScope(1))
        return ''
    endif
    let word_to_complete = matchstr(strpart(getline('.'), 0, col('.') - 1), '\S\+$')
    let contain_word = 'stridx(v:val, word_to_complete)>=0'
    let candidates = map(filter(keys(g:current_ulti_dict_info), contain_word),
                   \  "{
                   \      'word': v:val,
                   \      'menu': '[snip] '. g:current_ulti_dict_info[v:val]['description'],
                   \      'dup' : 1,
                   \   }")
    let from_where = col('.') - len(word_to_complete)
    if !empty(candidates)
        call complete(from_where, candidates)
    endif
    return ''
endfunction

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
set statusline+=%{statusline#NbspWarning()}
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

" switch to previous buffer
nnoremap <leader>d :b#<CR>

" call ctags
nnoremap <leader>m :call UnivCtags()<cr>

"clear last search.
nmap <F3> :let @/ = ""<CR>

" Terminal emulator
tnoremap c<Esc> <C-\><C-n>
"TODO: change the mapping. When opening vim inside vim, the c navigation key is
"inactive.

" Easier completion trigger mappings, from https://www.vi-improved.org/
inoremap <silent> ,f <C-x><C-f>
inoremap <silent> ,i <C-x><C-i>
inoremap <silent> ,l <C-x><C-l>
inoremap <silent> ,n <C-x><C-n>
inoremap <silent> ,o <C-x><C-o>
inoremap <silent> ,t <C-x><C-]>
inoremap <silent> ,u <C-x><C-u>
" snippets completion trigger menu
inoremap <silent> ,z <c-r>=<sid>ulti_complete()<cr>

" https://stackoverflow.com/questions/16082991/vim-switching-between-files-rapidly-using-vanilla-vim-no-plugins/16084326#16084326
" project navigation
" nnoremap <leader>f :find *
nnoremap <leader>f :Files<CR>

"buffer navigation
" nnoremap <leader>b :buffer <C-z><S-Tab>
nnoremap <leader>b :Buffers<CR>
nnoremap <leader>B :sbuffer <C-z><S-Tab>

" tag searching, / adds regex search
" nnoremap <leader>j :tjump /
nnoremap <leader>j :Tags<CR>
" tag of the current buffer
nnoremap <leader>u :FindBufTag <C-z><S-Tab>

" save a buffer
nnoremap <leader>s :w<CR>

" }}}

" Autocommands ------------------------------------------------------------ {{{

" NOTE: for the LastMod function to find the pattern, some text must exists on
" the right hand side of the ':'. (i.e. Last Change: <some_text>)
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
  "recalculate the nbsp warning when idle, and after saving
  autocmd cursorhold,bufwritepost * unlet! b:statusline_nbsp_warning
augroup END

" set muttrc file type for the mutt configuration file that are not called
" muttrc as only this one is recognized as muttrc
augroup setfiletype
  autocmd!
  autocmd BufNewFile,BufRead *.muttrc setlocal filetype=muttrc
  autocmd BufNewFile,BufRead */zsh/zfunction/* setlocal filetype=zsh
  autocmd BufNewFile,BufRead */zsh/zcompletion/* setlocal filetype=zsh
augroup END

augroup bepo_clash
  autocmd!
  " unmap vim-commentary mappings
  autocmd VimEnter * if exists(":Commentary") | call UnmapCommentary() | endif
augroup END

augroup ironmapping
  autocmd!
  autocmd Filetype python nmap <buffer> <localleader>t <Plug>(iron-send-motion)
  autocmd Filetype python vmap <buffer> <localleader>t <Plug>(iron-send-motion)
  autocmd Filetype python nmap <buffer> <localleader>p <Plug>(iron-repeat-cmd)
augroup END

augroup startup
  autocmd!
  autocmd VimEnter * call SetGrepPrg()
augroup END

augroup popupmenu
  autocmd CompleteDone * if pumvisible() == 0 | pclose | endif
augroup END

" }}}
