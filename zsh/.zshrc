
# Completion -------------------------------------------------------------- {{{
# The following lines were added by compinstall
zstyle ':completion:*' auto-description 'specify: %d'
zstyle ':completion:*' completer _expand _complete _ignored _correct _approximate
zstyle ':completion:*' completions 1
zstyle ':completion:*' expand prefix suffix
zstyle ':completion:*' format 'Completing %d'
zstyle ':completion:*' glob 1
zstyle ':completion:*' group-name ''
zstyle ':completion:*' insert-unambiguous false
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
zstyle ':completion:*' list-suffixes true
zstyle ':completion:*' max-errors 20 numeric
zstyle ':completion:*' menu select=2  # autocompletion with arrow key driven interface Double <TAB> to enable
zstyle ':completion:*' original true
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle ':completion:*' substitute 1
zstyle ':completion:*' use-compctl true
# zstyle :compinstall filename '/home/debz/.zshrc'

autoload -Uz compinit # activate advanced zsh autocompletion
compinit
# End of lines added by compinstall

# }}}

# Lines configured by zsh-newuser-install
#setopt appendhistory autocd nomatch notify
unsetopt beep
# End of lines configured by zsh-newuser-install

# plugin management ------------------------------------------------------- {{{

# - auto install zplug ---------------------------------------------------- {{{

export ZPLUG_HOME="${HOME}/.local/share/zplug"
if [[ ! -d "$ZPLUG_HOME" ]];then
  git clone https://github.com/zplug/zplug $ZPLUG_HOME
  source "${ZPLUG_HOME}/init.zsh"
fi
# TODO: Replace the zplug_home definition with xdg path

# - }}}

# - define plugins -------------------------------------------------------- {{{

# Essential
source "${ZPLUG_HOME}/init.zsh"
# Supports oh-my-zsh plugins and the like
zplug "plugins/extract", from:oh-my-zsh
zplug "plugins/vi-mode", from:oh-my-zsh
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

# Install plugins if there are plugins that have not been installed
if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi

# Then, source plugins and add commands to $PATH
# zplug load --verbose # useful for debugging
zplug load

# - }}}

# }}}

# keybind ----------------------------------------------------------------- {{{

# zsh-history-substring-search
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down
bindkey -M vicmd 's' history-substring-search-up
bindkey -M vicmd 't' history-substring-search-down

# }}}

# Source alias -------------------------------------------------------------{{{
if [[ -r ${ZDOTDIR}/config/aliasrc ]]; then
  . ${ZDOTDIR}/config/aliasrc
fi
# }}}

# zsh settings ------------------------------------------------------------ {{{

# - General settings ------------------------------------------------------ {{{

bindkey -v # activate vim mode for 'zsh line editor'

# - }}}

# zsh history ------------------------------------------------------------- {{{

export HISTFILE="${XDG_DATA_HOME}/zsh/history"
export HISTSIZE=10000
export SAVEHIST=${HISTSIZE}

# make some commands not show up in history
# TODO: Doesn't seems to work, ll, ls,... still show up.
export HISTIGNORE="ls:ll:cd:cd -:pwd:exit:date:* --help"

# multiple zsh sessions will append to the same history file (incrementally, after each command is executed)
setopt inc_append_history

# purge duplicates first
setopt hist_expire_dups_first

# if a new command line being added to the history list duplicates an older one, the older command is removed from the list
setopt hist_ignore_all_dups

# reduce unnecessary blanks from commands being written to history
setopt hist_reduce_blanks

# import new commands from history (mostly)
setopt share_history




# display PID when suspending processes as well
setopt longlistjobs
# try to avoid the 'zsh: no matches found...'
setopt nonomatch
# report the status of backgrounds jobs immediately
setopt notify

  # }}}

# }}}

# Functions --------------------------------------------------------------- {{{

# - History statistics ---------------------------------------------------- {{{
# http://linux.byexamples.com/archives/332/what-is-your-10-common-linux-commands/
function histats {
  history 1 | awk '{CMD[$2]++;count++;}END { for (a in CMD)print CMD[a] " " CMD[a]/count*100 "% " a;}' | grep -v "./" | column -c3 -s " " -t | sort -nr | nl | head -n10
}

  # }}}

# - fzf functions ---------------------------------------------------- {{{

fmpc() {
  local song_position
  song_position=$(mpc -f "%position%) %artist% - %title%" playlist | \
    fzf --query="$1" --reverse --select-1 --exit-0 | \
    sed -n 's/^\([0-9]\+\)).*/\1/p') || return 1
  [ -n "$song_position" ] && mpc -q play $song_position
}

# Play one or multiple album, search by artist and album
# $1 - initial query
ampc() {
  local choice 
  local sep=":"
  mpc clear
  choice=$(mpc search -f "[[%artist% ${sep} ]%album%]" artist "" | sort -u | fzf -m -q "$1")
  if [ -z "$choice" ] && exit 1
  while read -r line; do
    IFS="$sep" read -r art alb <<< "$line"
    art="$(echo -e "${art}" | sed -e 's/^[[:space:]]*//' -e 's/[[:space:]]*$//')"
    alb="$(echo -e "${alb}" | sed -e 's/^[[:space:]]*//' -e 's/[[:space:]]*$//')"
    mpc findadd artist "$art" album "$alb" | mpc add
  done <<< "$choice"
  mpc playlist
  mpc -q play
}

# http://stackoverflow.com/questions/369758/how-to-trim-whitespace-from-a-bash-variable

# search through my most visited directory ~ bookmarks
unalias z 2> /dev/null
z() {
  [ $# -gt 0 ] && _z "$*" && return
  cd "$(_z -l 2>&1 | fzf +s --tac --query "$*" | sed 's/^[0-9,.]* *//')"
}


# find directory
fd() {
  local dir
  dir=$(find ${1:-.} -path '*/\.*' -prune \
                  -o -type d -print 2> /dev/null | fzf +m) &&
  cd "$dir"
}


# find directory, hidden directory included (slower than fd)
fda() {
  local dir
  dir=$(find ${1:-.} -type d 2> /dev/null | fzf +m) && cd "$dir"
}


# find a file and open it with nvim
vf() {
  local files

  files=(${(f)"$(locate -Ai -0 $@ | grep -z -vE '~$' | fzf --read0 -0 -1 -m)"})

  if [[ -n $files ]]
  then
     nvim -- $files
     print -l $files[1]
  fi
}

# fh - repeat history
fh() {
  print -z $( ([ -n "$ZSH_NAME" ] && fc -l 1 || history) | fzf +s --tac | sed 's/ *[0-9]* *//')
}

  # }}}

# }}}

# Vi mode indicator --------------------------------------------------------{{{

#http://zshwiki.org/home/zle/vi-mode
precmd() {
  RPROMPT=""
}
zle-keymap-select() {
  RPROMPT=""
  [[ $KEYMAP = vicmd ]] && RPROMPT="-- NORMAL --"
  () { return $__prompt_status }
  zle reset-prompt
}
zle-line-init() {
  typeset -g __prompt_status="$?"
}
zle -N zle-keymap-select
zle -N zle-line-init

# }}}

# fzf theme --------------------------------------------------------------- {{{

# Base16 OceanicNext
# Author: https://github.com/voronianski/oceanic-next-color-scheme

_gen_fzf_default_opts() {

local color00='#1B2B34'
local color01='#343D46'
local color02='#4F5B66'
local color03='#65737E'
local color04='#A7ADBA'
local color05='#C0C5CE'
local color06='#CDD3DE'
local color07='#D8DEE9'
local color08='#EC5f67'
local color09='#F99157'
local color0A='#FAC863'
local color0B='#99C794'
local color0C='#5FB3B3'
local color0D='#6699CC'
local color0E='#C594C5'
local color0F='#AB7967'

export FZF_DEFAULT_OPTS="
  --height 40% --border
  --color=bg+:$color01,bg:$color00,spinner:$color0C,hl:$color0D
  --color=fg:$color04,header:$color0D,info:$color0A,pointer:$color0C
  --color=marker:$color0C,fg+:$color06,prompt:$color0A,hl+:$color0D
"

}

_gen_fzf_default_opts

# }}}

# Set GPG TTY
export GPG_TTY=$(tty)

# Refresh gpg-agent tty in case user switches into an X session
gpg-connect-agent updatestartuptty /bye >/dev/null
