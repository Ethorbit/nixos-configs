{ config, ... }:

{
    home-manager.sharedModules = [ {
        services.polybar.config = {
            "module/powermenu" = {
                type = "custom/menu";

                expand-right = true;

                format-spacing = 1;

                label-open = "";
                label-open-foreground = config.ethorbit.polybar.colors.secondary;
                label-close = " cancel";
                label-close-foreground = config.ethorbit.polybar.colors.secondary;
                label-separator = "|";
                label-separator-foreground = config.ethorbit.polybar.colors.foreground-alt;

                menu-0-0 = "power off";
                menu-0-0-exec = "menu-open-2";
                menu-0-1 = "reboot";
                menu-0-1-exec = "menu-open-1";
                #menu-0-2 = "log out ";
                #menu-0-2-exec = "menu-open-5";
                menu-0-2 = "suspend";
                menu-0-2-exec = "menu-open-3";
                #menu-0-3 = "turn off monitors";
                #menu-0-3-exec = "menu-open-4";

                menu-1-0 = "cancel";
                menu-1-0-exec = "menu-open-0";
                menu-1-1 = "reboot";
                menu-1-1-exec = "${config.system.path}/bin/reboot || sudo ${config.system.path}/bin/reboot";

                menu-2-0 = "power off";
                menu-2-0-exec = "${config.system.path}/bin/shutdown -h now || sudo ${config.system.path}/bin/shutdown -h now";
                menu-2-1 = "cancel";
                menu-2-1-exec = "menu-open-0";

                menu-3-0 = "suspend";
                menu-3-0-exec = "${config.system.path}/bin/systemctl suspend || sudo ${config.system.path}/bin/systemctl suspend";
                menu-3-1 = "cancel";
                menu-3-1-exec = "menu-open-0";
                #
                #menu-4-0 = "turn off monitors";
                #menu-4-0-exec = "${config.system.path}/bin/xset dpms force off || sudo ${config.system.path}/bin/xset dpms force off";
                #menu-4-1 = "cancel";
                #menu-4-1-exec = "menu-open-0";

                #menu-5-0 = "log out";
                #menu-5-0-exec = "systemctl restart lightdm";
                #menu-5-1 = "cancel";
                #menu-5-1-exec = "menu-open-0";
            };
        };
    } ];
}
