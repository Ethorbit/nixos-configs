{ homeModules, pkgs, ... }:

{
    imports = [
        ./packages.nix
        ../..
    ];

    home-manager.sharedModules = [ homeModules.xfconf ];
    programs.xfconf.enable = true;
    services.xserver.desktopManager.xfce.enable = true;

    programs.thunar = {
        enable = true;
        plugins = with pkgs; [
            thunar-archive-plugin
        ];
    };
}
