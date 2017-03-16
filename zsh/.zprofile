#
# ~/.zprofile
#

if [[ -r ${ZDOTDIR}/config/envrc ]]; then
  . ${ZDOTDIR}/config/envrc
fi

# start an x session automatically at login
if [ -z "$DISPLAY" ] && [ -n "$XDG_VTNR" ] && [ "$XDG_VTNR" -eq 1 ]; then
	startx
fi
