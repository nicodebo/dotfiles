# system-dotfiles 

## Files

system-dotfiles are organized as follows:

```
system-dotfiles/
├── pacman-hooks
│   ├── clear_pacaur_cache.hook
│   ├── clear_pacman_cache.hook
│   └── nvim_install_upgrade.hook
└── systemd
    ├── reflector.service
    └── reflector.timer
```

### pacman-hooks

This directory contains hooks triggered on pacman events

* `clear_pacaur_cache.hook`: clear pacaur cache ~/.cache/pacaur using
  `paccache` tool after whatever install/upgrade package event of pacman
* `clear_pacman_cache.hook`: clear pacaur cache ~/.cache/pacaur using
  `paccache` tool after whatever install/upgrade package event of pacman
* `nvim_install_upgrade.hook`: I prefer to install the neovim python3 client
  inside a virtual environment instead of the global python `site-packages`
  directory. Thus I'm using this hook to either install or upgrade the neovim
  python3 client located inside a virtual environment.

#### Tips

Pacman hooks run as root user, thus user environment varibles are not loaded.
In order to use them in the hook `sudo -u <user>` has to be called before the
shell invocation in the exec field of the hook.

### systemd

This directory contains systemd units

* `reflector.service`: triggered weekly by the `reflector.timer`, this unit
  allows to update the /etc/pacman.d/mirrorlist with up to date and fastest
  mirrors. It also takes care of removing `mirrorlist.pacnew` if it exists.

## References

* <https://www.reddit.com/r/archlinux/comments/6s9mbp/til_clearing_cache_should_be_done_regularly/>
* <https://wiki.archlinux.org/index.php/Pacman#Hooks>
* <https://www.archlinux.org/pacman/alpm-hooks.5.html>
* <https://www.reddit.com/r/archlinux/comments/6t0vq2/pacman_hook_with_environment_variables/>
* <https://wiki.archlinux.org/index.php/Reflector>
