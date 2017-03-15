" Vim compiler file
" Compiler: markdownlint, a markdown style checker
" Maintainer: nicodebo
" Last Change: 2017 Feb 21

" https://github.com/mivok/markdownlint

if exists('current_compiler')
  finish
endif
let current_compiler = 'mdl'

if exists(':CompilerSet') != 2
  command -nargs=* CompilerSet setlocal <args>
endif

let s:save_cpo = &cpo
set cpo-=C

CompilerSet makeprg=mdl\ %
CompilerSet errorformat=%f:%l:\ %m

let &cpo = s:save_cpo
unlet s:save_cpo

" vim: sw=2 sts=2 et
