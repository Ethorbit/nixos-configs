{ config, ... }:

{
    home-manager.users.${config.ethorbit.users.primary.username} = {
        programs.bash = {
            enable = true;
            bashrcExtra = ''
                # Change terminal font color from green to darkish purple (fits dark theming better)
                export PS1='\[\e[36m\]\u@\h\[\e[0m\]:\w\''$ ';

                [ -f ~/.bashrc_aliases ] && source ~/.bashrc_aliases
            '';
        };
    };
}
