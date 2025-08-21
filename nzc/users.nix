{ config, pkgs, ... }:

{
    ethorbit.users.primary.username = "nzc";
    
    users = {
        mutableUsers = false;

        users = {
            "root" = {
                shell = ''${pkgs.shadow}/bin/nologin'';
                hashedPassword = "!";
            };

            "nzc" = {
                extraGroups = [ "wheel" "docker" ];
            };
        };
    };
}
