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

# keybind ----------------------------------------------------------------- {{{

# zsh-history-substring-search
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down
bindkey -M vicmd 's' history-substring-search-up
bindkey -M vicmd 't' history-substring-search-down

# }}}

# zsh settings ------------------------------------------------------------ {{{

# - General settings ------------------------------------------------------ {{{

#setopt appendhistory autocd nomatch notify
unsetopt beep
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

# gpg agent --------------------------------------------------------------- {{{

# Start the gpg-agent if not already running
if ! pgrep -x -u "${USER}" gpg-agent >/dev/null 2>&1; then
  gpg-connect-agent /bye >/dev/null 2>&1
fi

# Refresh gpg-agent tty in case user switches into an X session
gpg-connect-agent updatestartuptty /bye >/dev/null

# }}}

# Source some shell programs ---------------------------------------------- {{{

# virtualenvwrapper
[[ -s "/usr/bin/virtualenvwrapper.sh" ]] && source /usr/bin/virtualenvwrapper.sh

# zplug
[[ -s "${ZPLUG_HOME}/init.zsh" ]] && source "${ZPLUG_HOME}/init.zsh" && zplug load

# rvm
[[ -s "${XDG_DATA_HOME}/rvm/scripts/rvm" ]] && source "${XDG_DATA_HOME}/rvm/scripts/rvm" # Load RVM into a shell session *as a function*

# }}}
