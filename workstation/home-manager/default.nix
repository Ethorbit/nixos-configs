{ homeModules, ... }:

{
    imports = [
        ./neovim
        ./systemd.nix
        ./flatpak
        ./xdg.nix
        ./i3.nix
    ];

    home-manager.sharedModules = 
     with homeModules; [
        wallpapers
    ] ++ [ {
        ethorbit.home-manager.wallpapers = [
            "ark_survival_evolved/aberration"
        ];
    } ];
}
