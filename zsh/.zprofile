#
# ~/.zprofile
#
# read at the startup of login shell

# set $PATH (special zsh syntax)
typeset -U path # Only unique values in $PATH
path=($path ~/.local/bin) # user installed program (pip install -user for example)
path=($path ~/bin) # my custom script directory
path=($path ~/.luarocks/bin) # path of the binary for the user rock tree

# start an x session automatically on a login shell (tty1)
if [ -z "$DISPLAY" ] && [ -n "$XDG_VTNR" ] && [ "$XDG_VTNR" -eq 1 ]; then
  xinit -- :1
fi
