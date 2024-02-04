{ config, pkgs, ... }:

{
    ethorbit.users.primary.username = "ide";
    
    users = {
        groups.ide = {};
        users.ide = {
            isNormalUser = true;
            createHome = true;
            description = "User for developing software";
            initialPassword = "ide";
            group = "ide";
            extraGroups = [ "wheel" ];
            shell = pkgs.bash;
        };
    };
}
