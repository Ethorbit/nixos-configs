{ config, ... }:

{
    home-manager.sharedModules = [ {
        xfconf.settings = {
            xsettings = {
                "Gtk/CursorThemeName" = "Adwaita";
                "Net/ThemeName" = "Zukitre-dark";
            };

            xfwm4 = {
                "general/SaveOnExit" = true;
                "general/popup_opacity" = 95;
                "general/frame_opacity" = 95;
                "general/move_opacity" = 70;
                "general/resize_opacity" = 80;
                "general/box_resize" = true;
                "general/wrap_windows" = false;
                "general/snap_to_windows" = true;
            };

            xfce4-panel = {
                "plugins/plugin-4" = "whiskermenu";
            };

            xfce4-terminal = {
                "background-mode" = "TERMINAL_BACKGROUND_TRANSPARENT";
                "background-darkness" = 0.95;
            };

            xfce4-screensaver = {
                "saver/idle-activation/delay" = 180;
            };

            xfce4-power-manager = {
                "blank-on-ac" = 0;
                "dpms-on-ac-off" = 120;
                "dpms-on-ac-sleep" = 120;
                "show-tray-icon" = true;
            };
        };
    } ];
}
