setlocal expandtab "no tabs
setlocal shiftwidth=4
setlocal softtabstop=4  " when pressing backspace, delete 2 spaces
setlocal textwidth=79  " lines longer than 79 columns will be broken

if executable("htmlhint")
    compiler htmlhint
endif

" autoclose html tags
" ref: https://stackoverflow.com/questions/130734/how-can-one-close-html-tags-in-vim-quickly
imap <buffer> ,/ </<C-X><C-O>
