{ config, pkgs, ... }:

{
    users = {
        groups.ide = {};

        users = {
            ide = {
                isNormalUser = true;
                createHome = true;
                description = "User for developing software";
                initialPassword = "ide"; # All systems should override the ide user's password!
                group = "ide";
                shell = pkgs.zsh;
            };
        };
    };
}
