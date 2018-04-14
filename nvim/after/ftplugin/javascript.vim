" javascript after filetype plugin
" Ftplugin: javascript.vim
" Maintainer: nicodebo
" Last Change: 2018 Feb 04


setlocal expandtab "no tabs
setlocal shiftwidth=4
setlocal softtabstop=4  " when pressing backspace, delete 2 spaces
setlocal textwidth=79  " lines longer than 79 columns will be broken

" if javascript language server is installed, then use it as a completion engine
" if executable("javascript-typescript-stdio")
"   setlocal signcolumn=yes
" endif
