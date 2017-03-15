# Task list

* ~/.muttrc
* ~/.mutt/mailcap
* ~/.mutt/accounts/personnal
* ~/.mutt/accounts/work
* ~/.mutt/accounts/work2
* browse file permission newsbeuter.
* retirer bin des dotfiles ou garder le bin dans les dotfiles ?
* mettre les petites fonctions de bin dans functions.zsh. ~/bin reservé pour
les plus gros projet tel que dreamnote. Pour les fonctions de quelques lignes
function.zsh suffit.
* Pour les permissions, utiliser cette méthode: http://stackoverflow.com/questions/3207728/retaining-file-permissions-with-git
  * msmtp: `$ chmod 600 .msmtp`
  * plowshare.conf `$ chmod 600 `
 
# My dotfiles
nvim/
├── after
│   └── ftplugin
│       ├── cpp.vim
│       ├── help.vim
│       ├── mail.vim
│       ├── make.vim
│       ├── python.vim
│       ├── sh.vim
│       └── vim.vim
├── autoload
│   └── statusline.vim
├── compiler
│   ├── flake8.vim
│   └── shellcheck.vim
├── init.vim
└── vimrc
    └── bepo.vimrc
