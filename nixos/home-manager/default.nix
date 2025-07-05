{ homeModules, ... }:

{
    imports = [
        ./flatpak
        ./xdg
    ];

    home-manager = {
        useGlobalPkgs = true;
        backupFileExtension = ".bak";

        sharedModules = 
        with homeModules; [
            shell
            htop
            {
                home.stateVersion = "23.11";
            }
        ];
    };
}
