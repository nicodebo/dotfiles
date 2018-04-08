# environement variables -------------------------------------------------- {{{

if [[ -r ${ZDOTDIR}/config/envrc ]]; then
  . ${ZDOTDIR}/config/envrc
fi

# }}}

# shell aliases ----------------------------------------------------------- {{{

# load alias (needed to be available to the nvim ! command
if [[ -r ${ZDOTDIR}/config/aliasrc ]]; then
  . ${ZDOTDIR}/config/aliasrc
fi

# }}}

# fpath ------------------------------------------------------------------- {{{

fpath=(${ZDOTDIR}/zfunction $fpath) # add custom function dir to fpath
fpath=(${ZDOTDIR}/zcompletion $fpath) # add custom completion dir to fpath

# }}}

# Create some directories ------------------------------------------------- {{{

mkdir -p "${XDG_DATA_HOME}/zsh" # directory that store zsh cmd history
mkdir -p "${XDG_DATA_HOME}/z" # directory that store the z database
mkdir -p "${XDG_DATA_HOME}/npm-packages" # directory that store npm packages
mkdir -p "${PROJECT_HOME}" # project dir for virtualenvwrapper
mkdir -p "${XDG_CACHE_HOME}/less" # directory that store the less history
mkdir -p "${XDG_CACHE_HOME}/msmtp" # store msmtp log file
mkdir -p "${XDG_CACHE_HOME}/psql" # directory for storing psql histories
mkdir -p "${MAILSTOREDIR}" # directory where the mail are stored
mkdir -p "$XDG_CACHE_HOME"/vim/{undo,swap,backup} # directories for vim files

# }}}
