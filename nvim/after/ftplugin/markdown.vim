" Vim after filetype plugin for markdown
" Ftplugin: markdown.vim
" Maintainer: nicodebo
" Last Change: 2017 Feb 18

setlocal expandtab "no tabs
setlocal shiftwidth=4
setlocal softtabstop=4  " when pressing backspace, delete 4 spaces
setlocal textwidth=79  " lines longer than 79 columns will be broken

" Select mdl as the primary compiler (it's a linter though)
if executable("mdl")
  compiler mdl 
endif
