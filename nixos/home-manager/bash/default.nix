{ config, ... }:

{
    home-manager.users.${config.ethorbit.users.primary.username} = {
        programs.bash = {
            enable = true;
            bashrcExtra = ''
                set -o ignoreeof

                export TERM=xterm

                # Taken from Kali Linux, modified slightly
                prompt_color='\[\e[36m\]'
                #info_color='\[\033[1;31m\]'
                info_color="$prompt_color"
                prompt_symbol=💎
                export PS1=$prompt_color'┌────''${VIRTUAL_ENV:+(\[\033[0;1m\]$(basename $VIRTUAL_ENV)'$prompt_color')}('$info_color'\u'$prompt_symbol'\h'$prompt_color')-[\[\033[0;1m\]\w'$prompt_color']\n'$prompt_color'└─'$info_color'\$\[\033[0m\] '

                [ -f ~/.bashrc_aliases ] && source ~/.bashrc_aliases
            '';
        };
    };
}
