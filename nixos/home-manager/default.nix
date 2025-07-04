{ config, lib, ... }:

{
    imports = [
        ./flatpak
        ./shell
        ./xdg
        ./htop
    ];

    config = lib.mkIf (config ? home-manager) {
        home-manager = {
            useGlobalPkgs = true;
            backupFileExtension = ".bak";

            sharedModules = [ {
                home.stateVersion = "23.11";
            } ];
        };
    };
}
