# .zshenv is basically loaded for all shell (non)interactive/(non)login
# neovim need .zshenv for the command alias to work with :!
# for more informations : http://zsh.sourceforge.net/Guide/zshguide02.html#l6

# set $PATH (special zsh syntax)
#typeset -U path
#path=(~/.local/bin $path) # user installed program (pip install -user for example)
#path=(~/bin $path) # my custom script directory

# Load environement variable modification
if [[ -r ${ZDOTDIR}/config/envrc ]]; then
  . ${ZDOTDIR}/config/envrc
else
  echo "envrc not found"
fi

# load alias (needed to be available to the nvim ! command
if [[ -r ${ZDOTDIR}/config/aliasrc ]]; then
  . ${ZDOTDIR}/config/aliasrc
else
  echo "aliasrc not found"
fi

# Preferred editor for local and remote sessions
 # http://unix.stackexchange.com/questions/4859/visual-vs-editor-whats-the-difference
 if [[ -n $SSH_CONNECTION ]]; then
     export VISUAL='nvim'
     export EDITOR="$VISUAL"
 else
     export VISUAL='nvim'
     export EDITOR="$VISUAL"
 fi


mkdir -p "${XDG_DATA_HOME}/zsh" # directory that store zsh cmd history
mkdir -p "${XDG_CACHE_HOME}/less" # directory that store the less history
