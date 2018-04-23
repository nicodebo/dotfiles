" Ref: http://got-ravings.blogspot.fr/2008/10/vim-pr0n-statusline-whitespace-flags.html

"return '[&et]' if &et is set wrong
"return '[mixed-indenting]' if spaces and tabs are used to indent
"return an empty string if everything is fine
function! statusline#TabWarning()
    if !exists("b:statusline_tab_warning")
        let tabs = search('^\t', 'nw') != 0
        let spaces = search('^ ', 'nw') != 0

        if tabs && spaces
            let b:statusline_tab_warning =  '[mixed-indenting]'
        elseif (spaces && !&et) || (tabs && &et)
            let b:statusline_tab_warning = '[&et]'
        else
            let b:statusline_tab_warning = ''
        endif
    endif
    return b:statusline_tab_warning
endfunction

"return '[\s]' if trailing white space is detected
"return '' otherwise
function! statusline#TrailingSpaceWarning()
    if !exists("b:statusline_trailing_space_warning")
        if search('\s\+$', 'nw') != 0
            let b:statusline_trailing_space_warning = '[\s]'
        else
            let b:statusline_trailing_space_warning = ''
        endif
    endif
    return b:statusline_trailing_space_warning
endfunction

"return '[\nbsp]' if non breaking space is detected
"return '' otherwise
function! statusline#NbspWarning()
    if !exists("b:statusline_nbsp_warning")
        " if search('\%x00a0', 'nw') != 0
        if search('\%xa0', 'nw') != 0
            let b:statusline_nbsp_warning = '[\nbsp]'
        else
            let b:statusline_nbsp_warning = ''
        endif
    endif
    return b:statusline_nbsp_warning
endfunction
