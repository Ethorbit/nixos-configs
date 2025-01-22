{ config, pkgs, ... }:

{
    config.home-manager.sharedModules = [ {
        programs.feh = {
            enable = true;
            themes = {
                feh = [
                    "--keep-zoom-vp"
                ];
            };
        };
    } ];
}
