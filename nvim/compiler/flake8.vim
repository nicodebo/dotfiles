" Vim compiler file
" Compiler: flake8, python syntax checker
" Maintainer: nicodebo
" Last Change: 2017 Feb 18

"http://flake8.pycqa.org/en/latest/manpage.html

if exists('current_compiler')
  finish
endif
let current_compiler = 'flake8'

if exists(':CompilerSet') != 2
  command -nargs=* CompilerSet setlocal <args>
endif

let s:save_cpo = &cpo
set cpo-=C

"see https://github.com/vim-syntastic/syntastic/blob/master/syntax_checkers/python/flake8.vim
"or https://github.com/neomake/neomake/blob/master/autoload/neomake/makers/ft/python.vim
"or https://github.com/w0rp/ale
"in fact this plugin do a bit more than the built in error format. For
"exemple they parse the linter output and modify some flags. Not sure I
"need this.
"http://flake8.pycqa.org/en/latest/manpage.html
"let s:errorformat =
    "\'%E%f:%l: could not compile,%-Z%p^,' .
    "\'%A%f:%l:%c: %t%n %m,' .
    "\'%A%f:%l: %t%n %m,' .
    "\'%-G%.%#'

CompilerSet makeprg=flake8\ --format=default\ %
CompilerSet errorformat=
    \%E%f:%l:\ could\ not\ compile,%-Z%p^,
    \%A%f:%l:%c:\ %t%n\ %m,
    \%A%f:%l:\ %t%n\ %m,
    \%-G%.%#

let &cpo = s:save_cpo
unlet s:save_cpo

" vim: sw=2 sts=2 et
