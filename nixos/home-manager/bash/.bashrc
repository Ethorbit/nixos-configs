# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

set -o ignoreeof

export XDG_RUNTIME_DIR=/run/user/$(id -u)
export TERM=xterm

# No duplicate entries, save & reload history after each command
HISTCONTROL="ignoredups:erasedups"

# ble.sh can already do this and this is kinda hacky
[ ! $(command -v bleopt) ] && PROMPT_COMMAND="history -a; history -r; $PROMPT_COMMAND"

#############################################################
# The following block was taken from Kali Linux

# The following block is surrounded by two delimiters.
# These delimiters must not be modified. Thanks.
# START KALI CONFIG VARIABLES
PROMPT_ALTERNATIVE=${PROMPT_ALTERNATIVE:-twoline}
NEWLINE_BEFORE_PROMPT=${NEWLINE_BEFORE_PROMPT:-yes}
# STOP KALI CONFIG VARIABLES

prompt_symbol="${prompt_symbol:-@}"
# sorry, don't wanna deal with nix's bs. 
# Just insert your desired values before the sourcing of this file and you're all good.
prompt_color=${prompt_color:-'\[\e[36m\]'}
info_color="${info_color:-$prompt_color}"

case "$PROMPT_ALTERNATIVE" in
    twoline)
        PS1=$prompt_color'┌──${debian_chroot:+($debian_chroot)──}${VIRTUAL_ENV:+(\[\033[0;1m\]$(basename $VIRTUAL_ENV)'$prompt_color')}('$info_color'\u'$prompt_symbol'\h'$prompt_color')-[\[\033[0;1m\]\w'$prompt_color']\n'$prompt_color'└─'$info_color'\$\[\033[0m\] ';;
    oneline)
        PS1='${VIRTUAL_ENV:+($(basename $VIRTUAL_ENV)) }${debian_chroot:+($debian_chroot)}'$info_color'\u@\h\[\033[00m\]:'$prompt_color'\[\033[01m\]\w\[\033[00m\]\$ ';;
    backtrack)
        PS1='${VIRTUAL_ENV:+($(basename $VIRTUAL_ENV)) }${debian_chroot:+($debian_chroot)}\[\033[01;31m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ ';;
esac

[ "$NEWLINE_BEFORE_PROMPT" = yes ] && PROMPT_COMMAND="echo;$PROMPT_COMMAND"

# enable color support of ls, less and man, and also add handy aliases
test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
export LS_COLORS="$LS_COLORS:ow=30;44:" # fix ls color for folders with 777 permissions

alias ls='ls --color=auto'
alias dir='dir --color=auto'
alias vdir='vdir --color=auto'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
alias diff='diff --color=auto'
alias ip='ip --color=auto'

export LESS_TERMCAP_mb=$'\E[1;31m'     # begin blink
export LESS_TERMCAP_md=$'\E[1;36m'     # begin bold
export LESS_TERMCAP_me=$'\E[0m'        # reset bold/blink
export LESS_TERMCAP_so=$'\E[01;33m'    # begin reverse video
export LESS_TERMCAP_se=$'\E[0m'        # reset reverse video
export LESS_TERMCAP_us=$'\E[1;32m'     # begin underline
export LESS_TERMCAP_ue=$'\E[0m'        # reset underline
########################################################

[ -f ~/.bashrc_aliases ] && source ~/.bashrc_aliases
