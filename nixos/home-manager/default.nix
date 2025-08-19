{ homeModules, ... }:

{
    imports = [
        ./flatpak
    ];

    home-manager = {
        useGlobalPkgs = true;
        backupFileExtension = ".bak";

        sharedModules = 
        with homeModules; [
            shell
            htop
            xdg
            {
                home.stateVersion = "23.11";
            }
        ];
    };
}
