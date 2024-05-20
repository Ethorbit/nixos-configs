{ config, ... }:

{
    home-manager.users.${config.ethorbit.users.primary.username} = {
        programs.bash = {
            enable = true;
            bashrcExtra = ''
                set -o ignoreeof

                export TERM=xterm

                # Taken from Kali Linux, modified slightly
                #
                prompt_color='\[\e[36m\]'
                info_color="$prompt_color"
                prompt_symbol=💎
                export PS1=$prompt_color'┌──''${VIRTUAL_ENV:+(\[\033[0;1m\]$(basename $VIRTUAL_ENV)'$prompt_color')}('$info_color'\u'$prompt_symbol'\h'$prompt_color')-[\[\033[0;1m\]\w'$prompt_color']\n'$prompt_color'└─'$info_color'\$\[\033[0m\] '

                # enable color support of ls, less and man, and also add handy aliases
                test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
                export LS_COLORS="$LS_COLORS:ow=30;44:" # fix ls color for folders with 777 permissions

                alias ls='ls --color=auto'
                #alias dir='dir --color=auto'
                #alias vdir='vdir --color=auto'

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
            '';
        };
    };
}
