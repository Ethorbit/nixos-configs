{ config, ... }:

{
    home-manager.users.${config.ethorbit.users.primary.username} = {
        programs.zsh = {
            enable = true;
        };
    };
}
