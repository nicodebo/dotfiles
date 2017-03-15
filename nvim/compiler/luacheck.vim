" Vim compiler file
" Compiler: luacheck, lua linter
" Maintainer: nicodebo
" Last Change: 2017 Feb 15

"https://github.com/mpeterv/luacheck
"https://github.com/neomake/neomake/blob/master/autoload/neomake/makers/ft/lua.vim

if exists('current_compiler')
  finish
endif
let current_compiler = 'luacheck'

if exists(':CompilerSet') != 2
  command -nargs=* CompilerSet setlocal <args>
endif

let s:save_cpo = &cpo
set cpo-=C

CompilerSet makeprg=luacheck\ --no-color\ --formatter=plain\ --codes\ %
CompilerSet errorformat=%f:%l:%c:\ \(%t%n\)\ %m
"TODO: check for a configuration file with the corresponding flag of luacheck.
"see neomake lua.vim

let &cpo = s:save_cpo
unlet s:save_cpo

" vim: sw=2 sts=2 et
