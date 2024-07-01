{ config, pkgs, ... }:

{
    ethorbit.users.primary.username = "ide";
    
    users = {
        groups.ide = {};
        users.ide = {
            createHome = true;
            description = "User for developing software";
            initialPassword = "ide";
            extraGroups = [ "wheel" ];
        };
    };
}
