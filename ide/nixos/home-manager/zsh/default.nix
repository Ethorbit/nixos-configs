{ config, ... }:

{
    home-manager.users.ide = {
        programs.zsh = {
            enable = true;
        };
    };
}
