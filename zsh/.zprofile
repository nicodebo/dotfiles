#
# ~/.zprofile
#
# read at the startup of login shell

# set $PATH (special zsh syntax)
typeset -U path # Only unique values in $PATH
path=($path ~/.local/bin) # user installed program (pip install -user for example)
path=($path ~/bin) # my custom script directory

# configure ruby environement manager, (rvm)
# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
path=($path ${XDG_DATA_HOME}/rvm/bin)

# start an x session automatically on a login shell (tty1)
if [ -z "$DISPLAY" ] && [ -n "$XDG_VTNR" ] && [ "$XDG_VTNR" -eq 1 ]; then
  xinit -- :1 
fi
