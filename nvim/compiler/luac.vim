" Vim compiler file
" Compiler: luac, lua linter
" Maintainer: nicodebo
" Last Change: 2017 Feb 15

"https://github.com/neomake/neomake/blob/master/autoload/neomake/makers/ft/lua.vim

if exists('current_compiler')
  finish
endif
let current_compiler = 'luac'

if exists(':CompilerSet') != 2
  command -nargs=* CompilerSet setlocal <args>
endif

let s:save_cpo = &cpo
set cpo-=C

CompilerSet makeprg=luac\ -p\ %
CompilerSet errorformat=%*\f:\ %#%f:%l:\ %m
"TODO: errorformat is wrong

let &cpo = s:save_cpo
unlet s:save_cpo

" vim: sw=2 sts=2 et
