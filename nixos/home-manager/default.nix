{ homeModules, ... }:

{
    imports = [
        ./flatpak
        ./xdg
        ./htop
    ];

    home-manager = {
        useGlobalPkgs = true;
        backupFileExtension = ".bak";

        sharedModules = 
        with homeModules; [
            shell
            {
                home.stateVersion = "23.11";
            }
        ];
    };
}
