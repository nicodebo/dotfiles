# zsh

## Files

zsh configuration files are organized as follows:

```
zsh
├── config
│   ├── aliasrc
│   └── envrc
├── zcompletion
├── zfunction
│   ├── extract-music
│   ├── fzf-mpc-add
│   ├── fzf-mpc-select
│   ├── fzf-open-file-in-dir
│   ├── fzf-search_open-note
│   ├── fzf-search_print-note
│   ├── fzf-z
│   ├── history-search_cmd
│   ├── history-stats
│   ├── nplug
│   ├── nplug_install_all
│   └── nplug_update_all
├── .zlogout
├── .zprofile
├── .zshenv
└── .zshrc
```

* `zfunction/`: contains function that are autoloaded meaning that they are
  only loaded when used for the first time.
    * `nplug`: a simple plugin commandline fetcher that support
      post-install/post-update hooks. See `$ nplug -h` for usage.
    * `nplug_install_all`: call `$ nplug install <repo>` command for multiple github
      repository. This allow to fetch all the needed plugin with one command.
    * `nplug_install_all`: call `$ nplug update <repo>` command for multiple
      fetched repositories. This allow to update all my plugins with one
      command
    * `history-stats`: display the 10 most used commands

## References

* <http://zsh.sourceforge.net/Doc/Release/zsh_toc.html>
* <http://zshwiki.org/home/start>
