{ config, ... }:

{
    imports = [
        ./shell
        ./xdg
    ];

    home-manager = {
        useGlobalPkgs = true;
        backupFileExtension = ".bak";

        sharedModules = [ {
            home.stateVersion = "23.11";
        } ];
    };
}
