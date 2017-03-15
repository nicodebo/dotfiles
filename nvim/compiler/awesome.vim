" Vim compiler file
" Compiler: awesome, awesome configuration file syntax checker
" Maintainer: nicodebo
" Last Change: 2017 Feb 15

if exists('current_compiler')
  finish
endif
let current_compiler = 'awesome'

if exists(':CompilerSet') != 2
  command -nargs=* CompilerSet setlocal <args>
endif

let s:save_cpo = &cpo
set cpo-=C

CompilerSet makeprg=awesome\ -k
CompilerSet errorformat=%f:%l:\ %m
"TODO: automatically detect awesome configuration file and set this compiler
" luacheck is still the default linter for lua
"TODO: awesome -k return a line that is impossible to match. See if there is an
"option in errorformat that allow to ignore a line, or make a pull request that
"allow to chose the error format directly in awesome.

let &cpo = s:save_cpo
unlet s:save_cpo

" vim: sw=2 sts=2 et
