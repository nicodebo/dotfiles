setlocal expandtab "no tabs
setlocal shiftwidth=2
setlocal softtabstop=2  " when pressing backspace, delete 2 spaces
setlocal textwidth=79  " lines longer than 79 columns will be broken

if executable("csslint")
    compiler csslint
endif
