# .zshenv is basically loaded for all shell (non)interactive/(non)login
# neovim need .zshenv for the command alias to work with :!
# for more informations : http://zsh.sourceforge.net/Guide/zshguide02.html#l6

# set $PATH (special zsh syntax)
#typeset -U path
#path=(~/.local/bin $path) # user installed program (pip install -user for example)
#path=(~/bin $path) # my custom script directory

# Load environement variable modification
# if [[ -r ${ZDOTDIR}/config/envrc ]]; then
#   . ${ZDOTDIR}/config/envrc
# fi

# load alias (needed to be available to the nvim ! command
if [[ -r ${ZDOTDIR}/config/aliasrc ]]; then
  . ${ZDOTDIR}/config/aliasrc
fi
