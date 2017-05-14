" Ref: http://docs.python-guide.org/en/latest/dev/env/
" pep8 coding style already define in the shipped python plugin
" /usr/share/nvim/runtime/ftplugin/python.vim
" i.e. setlocal expandtab shiftwidth=4 softtabstop=4 tabstop=8
" I'm using pep8 style so I don't need to redefine or overwrite those settings

setlocal textwidth=79  " lines longer than 79 columns will be broken
setlocal colorcolumn=+1 " add an vertical line right after textwidth

" Select flake8 as the primary compiler (it's a linter though)
if executable("flake8")
  compiler flake8
endif

" Define a python code formatter
if executable("yapf")
  setlocal formatprg=yapf
endif

" if python language server is installed, then use it as a completion engine
if executable("pyls")
  setlocal omnifunc=LanguageClient#complete
endif
