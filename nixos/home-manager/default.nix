{ config, ... }:

{
    imports = [
        ./flatpak
        ./shell
        ./xdg
        ./htop
    ];

    home-manager = {
        useGlobalPkgs = true;
        backupFileExtension = ".bak";

        sharedModules = [ {
            home.stateVersion = "23.11";
        } ];
    };
}
