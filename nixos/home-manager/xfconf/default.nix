{ config, ... }:

{
    home-manager.sharedModules = [ {
        xfconf.settings = {
            xsettings = {
                "Gtk/CursorThemeName" = "Adwaita";
                "Net/ThemeName" = "Zukitre-dark";
            };

            xfwm4 = {
                "general/popup_opacity" = 95;
                "general/frame_opacity" = 95;
                "general/move_opacity" = 70;
                "general/resize_opacity" = 80;
                "general/box_resize" = true;
                "general/wrap_windows" = false;
                "general/snap_to_windows" = true;
            };

            xfce4-session = {
                "general/SaveOnExit" = true;
            };

            xfce4-panel = {
                "plugins/plugin-4" = "whiskermenu";
                "plugins/plugin-7" = "xfce4-timer-plugin";
            };

            xfce4-terminal = {
                "background-mode" = "TERMINAL_BACKGROUND_TRANSPARENT";
                "background-darkness" = 0.95;
            };

            xfce4-screensaver = {
                "saver/idle-activation/delay" = 180;
            };

            xfce4-power-manager = {
                "xfce4-power-manager/blank-on-ac" = 0;
                "xfce4-power-manager/dpms-on-ac-off" = 120;
                "xfce4-power-manager/dpms-on-ac-sleep" = 120;
                "xfce4-power-manager/show-tray-icon" = true;
            };

            thunar = {
                "last-show-hidden" = true;
            };
        };
    } ];
}
