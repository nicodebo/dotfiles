" https://google.github.io/styleguide/shell.xml
setlocal expandtab "no tabs
setlocal shiftwidth=2
setlocal softtabstop=2  " when pressing backspace, delete 2 spaces
setlocal textwidth=79  " lines longer than 79 columns will be broken

" Select shellcheck as the primary compiler (it's a linter though)
if executable("shellcheck")
    compiler shellcheck
endif

" Define a bash/sh code formatter
if executable("shfmt")
    setlocal formatprg=shfmt\ -i\ 2
endif

" TODO: make the formatprg -i flag value of shfmt dependent on the shiftwidth.
" see https://github.com/sbdchd/neoformat/blob/master/autoload/neoformat/formatters/sh.vim
