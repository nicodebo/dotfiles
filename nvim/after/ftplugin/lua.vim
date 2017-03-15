" Lua after filetype plugin
" Ftplugin: lua.vim
" Maintainer: nicodebo
" Last Change: 2017 Feb 15

" Since I use lua just for awesome, I'm following the style defined in the
" default lua.rc configuration file while 2 spaces seems more common for the
" language
setlocal expandtab "no tabs
setlocal shiftwidth=4
setlocal softtabstop=4  " when pressing backspace, delete 2 spaces
setlocal textwidth=79  " lines longer than 79 columns will be broken

" Select shellcheck as the primary compiler (it's a linter though)
if executable("luacheck")
    compiler luacheck
endif
