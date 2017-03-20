if exists('g:vimtex_enabled') && g:vimtex_enabled == 1

  nmap <buffer> <localleader>li <plug>(vimtex-info)
  nmap <buffer> <localleader>lI <plug>(vimtex-info-full)
  nmap <buffer> <localleader>lx <plug>(vimtex-reload)
  nmap <buffer> <localleader>ls <plug>(vimtex-toggle-main)

  nmap <buffer> ds$ <plug>(vimtex-env-delete-math)
  nmap <buffer> ls$ <plug>(vimtex-env-change-math)
  nmap <buffer> dse <plug>(vimtex-env-delete)
  nmap <buffer> lse <plug>(vimtex-env-change)
  nmap <buffer> jse <plug>(vimtex-env-toggle-star)

  nmap <buffer> dsc <plug>(vimtex-cmd-delete)
  nmap <buffer> lsc <plug>(vimtex-cmd-change)
  nmap <buffer> jsc <plug>(vimtex-cmd-toggle-star)
  nmap <buffer> <F7> <plug>(vimtex-cmd-create)
  xmap <buffer> <F7> <plug>(vimtex-cmd-create)
  imap <buffer> <F7> <plug>(vimtex-cmd-create)

  nmap <buffer> jsd <plug>(vimtex-delim-toggle-modifier)
  xmap <buffer> jsd <plug>(vimtex-delim-toggle-modifier)
  imap <buffer> ]] <plug>(vimtex-delim-close)

  " latexmk related mapping
  nmap <buffer> <localleader>ll <plug>(vimtex-compile-toggle)
  nmap <buffer> <localleader>lo <plug>(vimtex-compile-output)
  nmap <buffer> <localleader>lL <plug>(vimtex-compile-selected)
  xmap <buffer> <localleader>lL <plug>(vimtex-compile-selected)
  nmap <buffer> <localleader>lk <plug>(vimtex-stop)
  nmap <buffer> <localleader>lK <plug>(vimtex-stop-all)
  nmap <buffer> <localleader>le <plug>(vimtex-errors)
  nmap <buffer> <localleader>lc <plug>(vimtex-clean)
  nmap <buffer> <localleader>lC <plug>(vimtex-clean-full)
  nmap <buffer> <localleader>lg <plug>(vimtex-status)
  nmap <buffer> <localleader>lG <plug>(vimtex-status-all)

  " motion related mapping
  nmap <buffer> ]] <plug>(vimtex-]])
  xmap <buffer> ]] <plug>(vimtex-]])
  omap <buffer> ]] <plug>(vimtex-]])

  nmap <buffer> ][ <plug>(vimtex-][)
  xmap <buffer> ][ <plug>(vimtex-][)
  omap <buffer> ][ <plug>(vimtex-][)

  nmap <buffer> [] <plug>(vimtex-[])
  xmap <buffer> [] <plug>(vimtex-[])
  omap <buffer> [] <plug>(vimtex-[])

  nmap <buffer> [[ <plug>(vimtex-[[)
  xmap <buffer> [[ <plug>(vimtex-[[)
  omap <buffer> [[ <plug>(vimtex-[[)

  nmap <buffer> % <plug>(vimtex-%)
  xmap <buffer> % <plug>(vimtex-%)
  omap <buffer> % <plug>(vimtex-%)

  " text object related mappings
  xmap <buffer> ac <plug>(vimtex-ac)
  omap <buffer> ac <plug>(vimtex-ac)

  xmap <buffer> ic <plug>(vimtex-ic)
  omap <buffer> ic <plug>(vimtex-ic)

  xmap <buffer> ad <plug>(vimtex-ad)
  omap <buffer> ad <plug>(vimtex-ad)

  xmap <buffer> id <plug>(vimtex-id)
  omap <buffer> id <plug>(vimtex-id)

  xmap <buffer> ae <plug>(vimtex-ae)
  omap <buffer> ae <plug>(vimtex-ae)

  xmap <buffer> ie <plug>(vimtex-ie)
  omap <buffer> ie <plug>(vimtex-ie)

  xmap <buffer> a$ <plug>(vimtex-a$)
  omap <buffer> a$ <plug>(vimtex-a$)

  xmap <buffer> i$ <plug>(vimtex-i$)
  omap <buffer> i$ <plug>(vimtex-i$)

  " toc related
  nmap <buffer> <localleader>lt <plug>(vimtex-toc-open)
  nmap <buffer> <localleader>lT <plug>(vimtex-toc-toggle)

  " label related
  nmap <buffer> <localleader>ly <plug>(vimtex-labels-open)
  nmap <buffer> <localleader>lY <plug>(vimtex-labels-toggle)

  " viewer
  nmap <buffer> <localleader>lv <plug>(vimtex-view)
  nmap <buffer> <localleader>lr <plug>(vimtex-reverse-search)

  " insert mapping list
  nmap <buffer> <localleader>lm <plug>(vimtex-imaps-list)
endif
