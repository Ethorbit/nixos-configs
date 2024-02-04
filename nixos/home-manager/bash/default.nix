{ config, ... }:

{
    home-manager.users.${config.ethorbit.users.primary.username} = {
        programs.bash = {
            enable = true;
            bashrcExtra = ''
                [ -f ~/.bashrc_aliases ] && source ~/.bashrc_aliases
            '';
        };
    };
}
