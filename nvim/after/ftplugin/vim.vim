" Vim after filetype plugin for vim
" Ftplugin: vim.vim
" Maintainer: nicodebo
" Last Change: 2017 Feb 13

"https://google.github.io/styleguide/vimscriptfull.xml
setlocal expandtab "no tabs
setlocal shiftwidth=2
setlocal softtabstop=2  " when pressing backspace, delete 4 spaces
setlocal textwidth=79  " lines longer than 79 columns will be broken

" Select vint as the primary compiler (it's a linter though)
if executable("vint")
  compiler vint
endif
" TODO: also check that the compiler is defined, otherwise an error message
" appear when opening file of the corresponding filetype. Do it for every
" ftplugin

" Learnvimscriptthehardway tips to make the init.vim more maintainable
" with nice folds that represent sections.
setlocal foldmethod=marker
