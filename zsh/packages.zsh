# Supports oh-my-zsh plugins and the like
zplug "plugins/extract", from:oh-my-zsh
# zplug "plugins/vi-mode", from:oh-my-zsh
zplug "rupa/z", use:z.sh # manage most frequent directory
zplug "voronkovich/gitignore.plugin.zsh" # cli to download from gitignore api
zplug "nojhan/liquidprompt" # zsh prompt with git and python venv support
zplug "paulirish/git-open", as:command
# Grab binaries from GitHub Releases
# and rename with the "rename-to:" tag
zplug "junegunn/fzf-bin", \
    from:gh-r, \
    as:command, \
    rename-to:fzf, \
    use:"*linux*amd64*"
# Set the priority when loading
# e.g., zsh-syntax-highlighting must be loaded
# after executing compinit command and sourcing other plugins
# (If the defer tag is given 2 or above, run after compinit command)
zplug "zsh-users/zsh-syntax-highlighting", defer:2
zplug "zsh-users/zsh-history-substring-search", defer:2
