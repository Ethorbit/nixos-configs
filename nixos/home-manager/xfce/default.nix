{ config, ... }:

{
    home-manager.users.${config.ethorbit.users.primary.username} = {
        xfconf.settings = {
            xsettings = {
                "Net/ThemeName" = "Zukitre-dark";
            };

            xfwm4 = {
                "general/wrap_windows" = false;
                "general/snap_to_windows" = true;
            };

            xfce4-screensaver = {
                "saver/idle-activation/delay" = 180;
            };
        };
    };
}
