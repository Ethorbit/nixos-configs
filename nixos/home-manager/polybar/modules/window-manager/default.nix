{ config, ... }:

{
    imports = [
        ./i3.nix
        ./bspwm.nix
    ];

    home-manager.sharedModules = [ {
        services.polybar.config = {
            "global/wm" = {
                margin-top = 5;
                margin-bottom = 5;

                # "vim:ft=dosini";
            };
        };
    } ];
}
