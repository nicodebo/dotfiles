.PHONY: hardlink_files

install_githooks:
	.bin/install_hooks.sh

hardlink_files:
	ln -f ./nvim/vimrc/bepo.vimrc ./vim/vimconf/bepo.vimrc
