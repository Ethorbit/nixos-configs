{ config, pkgs, ... }:

{
    imports = [
        ./scripts
        ./modules
        ./colors.nix
        ./style.nix
    ];

    home-manager.users.${config.ethorbit.users.primary.username} = {
        services.polybar = {
            enable = true;

            package = pkgs.polybarFull;

            script = ''
                exec "${config.ethorbit.polybar.scripts.launch.outPath}"
            '';

            config = {
                "bar/main" = {
                    width = "99.5%";
                    height = "30";
                    offset-x = "0.2%";
                    offset-y = "-4";
                    radius = config.ethorbit.polybar.style.radius;
                    fixed-center = true;

                    background = config.ethorbit.polybar.colors.background;
                    foreground = config.ethorbit.polybar.colors.foreground;
                    
                    #line-size = 1
                    line-color = "#f00";

                    border-bottom-size = 1;
                    border-color = "#545455";
                    #a08c8c8c

                    padding-top = 0;
                    padding-left = 1;
                    padding-right = 2;

                    module-margin-left = 0;
                    module-margin-right = 3;

                    font-0 = "fixed:pixelsize=8.3;1";
                    font-1 = "Noto Color Emoji:scale=17;style=Regular;1";
                    font-2 = "siji:pixelsize=10;1";

                    modules-left = "i3";                    
                    #modules-center = "mpd";
                    modules-center = "memory memory-available cpu nvidia-gpu mocp/song-name mocp/previous mocp/toggleplay mocp/next";
                    modules-right = "date weather powermenu";

                    tray-position = "right";
                    tray-padding = 2;
                    #tray-background = "#0063ff";

                    #;wm-restack = "bspwm";
                    wm-restack = "i3";

                    override-redirect = true;

                    #scroll-up = "bspwm-desknext";
                    #scroll-down = "bspwm-deskprev";

                    #scroll-up = "i3wm-wsnext";
                    #scroll-down = "i3wm-wsprev";

                    cursor-click = "pointer";
                    cursor-scroll = "ns-resize";
                };

                "bar/notmain" = {
                    monitor = "$${env:MONITOR:}";
                    width = "99.6%";
                    height = "30";
                    offset-x = "0.2%";
                    offset-y = "-4";
                    radius = config.ethorbit.polybar.style.radius;
                    fixed-center = true;

                    background = config.ethorbit.polybar.colors.background;
                    foreground = config.ethorbit.polybar.colors.foreground;

                    #line-size = 3;
                    line-color = "#f00";

                    border-size = 4;
                    border-bottom-size = 1;
                    border-top-size = 0;
                    border-right-size = 0;
                    border-left-size = 0;
                    border-color = "#545455";

                    padding-left = 1;
                    padding-right = 2;

                    module-margin-left = 0;
                    module-margin-right = 3;

                    font-0 = "fixed:pixelsize=9;1";
                    font-1 = "Noto Color Emoji:scale=2.1;style=Regular;0";
                    font-2 = "siji:pixelsize=10;1";

                    modules-left = "bspwm i3";
                    # modules-center = mpd
                    # modules-center = memory memory-available cpu amd-cpu-temperature amd-gpu
                    modules-center = "memory memory-available cpu nvidia-gpu mocp/song-name mocp/previous mocp/toggleplay mocp/next";
                    modules-right = "date weather";

                    #tray-position = "right";
                    #tray-padding = 2;
                    #tray-background = "#0063ff";

                    #wm-restack = "bspwm";
                    wm-restack = "i3";

                    override-redirect = true;

                    #scroll-up = "bspwm-desknext";
                    #scroll-down = "bspwm-deskprev";

                    #scroll-up = "i3wm-wsnext";
                    #scroll-down = "i3wm-wsprev";

                    cursor-click = "pointer";
                    cursor-scroll = "ns-resize";
                };

                "settings" = {
                    screenchange-reload = true;
                    #compositing-background = "xor";
                    #compositing-background = "screen";
                    #compositing-foreground = "source";
                    #compositing-border = "over";
                    #pseudo-transparency = false;
                };
            };
        };
    };
}
