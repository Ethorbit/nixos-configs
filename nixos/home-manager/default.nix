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
            default
            shell
            htop
            xdg
        ];
    };
}
