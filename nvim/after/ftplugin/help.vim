" This ftplugin is used to overide the status line defined in my init.vim
" for help file. Indeed, I don't need information about mixed-indenting or
" trailing white space in help file.
setlocal statusline=
"emulate standard status line, (see :h statusline)
setlocal statusline=%<%f\ %h%m%r%=%-14.(%l,%c%V%)\ %P
setlocal ruler
