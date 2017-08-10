# neovim

## Files

The configuration files are organized as follows:

```
nvim
├── after
│   └── ftplugin
│       ├── help.vim
│       ├── lua.vim
│       ├── mail.vim
│       ├── make.vim
│       ├── markdown.vim
│       ├── python.vim
│       ├── sh.vim
│       ├── tex.vim
│       ├── tex_vimtex.vim
│       ├── vim.vim
│       └── zsh.vim
├── autoload
│   └── statusline.vim
├── compiler
│   ├── awesome.vim
│   ├── flake8.vim
│   ├── luacheck.vim
│   ├── luac.vim
│   ├── mdl.vim
│   ├── shellcheck.vim
│   └── vint.vim
├── init.vim
└── vimrc
    └── bepo.vimrc
```

* `init.vim`: the main configuration file
* `vimrc/`: files in this folder are sourced from the `init.vim`. This allow to
  break the `init.vim` into more managable pieces.
* `autoload/`: contains fonctions that are only loaded when called
* `compiler`: contains my own compiler definition. For example, the
  `shellcheck` compiler allow to run
  [shellcheck](https://github.com/koalaman/shellcheck) syntax checker on the
  current bash buffer and populate the quickfix list with the different
  warnings and errors.
* `after/ftplugin/`: filetype specific settings that are loaded after the
  distributed corresponding filetype plugins.

## References

* <https://github.com/romainl/idiomatic-vimrc>
* <http://learnvimscriptthehardway.stevelosh.com/>
* <https://www.reddit.com/r/vim/>
* <https://www.reddit.com/r/neovim/>
