" Vim compiler file
" Compiler: vint, vimscript linter
" Maintainer: nicodebo
" Last Change: 2017 Feb 13

"https://github.com/Kuniwak/vint
"https://github.com/neomake/neomake/blob/master/autoload/neomake/makers/ft/vim.vim

if exists('current_compiler')
  finish
endif
let current_compiler = 'vint'

if exists(':CompilerSet') != 2
  command -nargs=* CompilerSet setlocal <args>
endif

let s:save_cpo = &cpo
set cpo-=C

CompilerSet makeprg=vint\ --enable-neovim\ --style-problem\ --no-color\ 
    \-f\ '{file_path}:{line_number}:{column_number}:{severity}:{description}\ ({policy_name})'\ %
CompilerSet errorformat=%I%f:%l:%c:style_problem:%m,%f:%l:%c:%t%*[^:]:%m

" TODO: define a makeprg when using neovim and another one when using vim
" without the --enable-neovim flag ?
" default error format is good

" This expression work out of the box with the default error format set by vim
"CompilerSet makeprg=vint\ --enable-neovim\ --style-problem\ --no-color\ %

let &cpo = s:save_cpo
unlet s:save_cpo

" vim: sw=2 sts=2 et
