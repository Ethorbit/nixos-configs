{ config, ... }:

{
    imports = [
        ./i3.nix
        ./bspwm.nix
    ];

    home-manager.users.${config.ethorbit.users.primary.username}.services.polybar.config = {
        "global/wm" = {
            margin-top = 5;
            margin-bottom = 5;

            # "vim:ft=dosini";
        };
    };
}
