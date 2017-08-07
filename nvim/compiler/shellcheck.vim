" Vim compiler file
" Compiler: shellcheck, bash syntax checker
" Maintainer: nicodebo
" Last Change: 2017 Aug 07
" Ref: https://github.com/koalaman/shellcheck
" Comment: See github wiki for error description
" Error Format:

if exists('current_compiler')
  finish
endif
let current_compiler = 'shellcheck'

if exists(':CompilerSet') != 2
  command -nargs=* CompilerSet setlocal <args>
endif

let s:save_cpo = &cpo
set cpo-=C

CompilerSet makeprg=shellcheck\ -x\ -f\ gcc\ %
CompilerSet errorformat=
       \%f:%l:%c:\ %trror:\ %m,
       \%f:%l:%c:\ %tarning:\ %m,
       \%I%f:%l:%c:\ Note:\ %m

let &cpo = s:save_cpo
unlet s:save_cpo

" Just for reference
" upercase is the same as lowercase by default, thus 'Note' will match 'note'
"\%f:%l:%c:\ %tote:\ %m   "doesn't work as intended, write 'n' instead of 'note'
"This is because 'n' is not a valid type for '%t' like 'e' for error and 'w'
"for warning. Maybe I could implement something such as https://github.com/neomake/neomake/pull/811

" vim: sw=2 sts=2 et
