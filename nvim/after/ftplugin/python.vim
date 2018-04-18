" Ref: http://docs.python-guide.org/en/latest/dev/env/
" pep8 coding style already define in the shipped python plugin
" /usr/share/nvim/runtime/ftplugin/python.vim
" i.e. setlocal expandtab shiftwidth=4 softtabstop=4 tabstop=8
" I'm using pep8 style so I don't need to redefine or overwrite those settings

setlocal textwidth=79  " lines longer than 79 columns will be broken

" if python language server is installed, then use it as a completion engine
if executable("pyls")
  setlocal signcolumn=yes
endif
