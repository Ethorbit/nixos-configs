{ config, pkgs, ... }:

{
    home-manager.sharedModules = [ {
        xfconf.settings = {
            # Rotate screen
            displays = {
                "Rotation" = 0;
                "Default/eDP-1" = "laptop";
                "Default/eDP-1/Active" = true;
                "Default/eDP-1/Resolution" = "800x1280";
                "Default/eDP-1/Rotation" = 270;
                "Default/eDP-1/Reflection" = "0";
            };

            # On-screen keyboard for Lock Screen
            xfce4-screensaver = {
                "lock/embedded-keyboard/enabled" = true;
                "lock/embedded-keyboard/command" = "${pkgs.onboard}/bin/onboard -e";
            };
        };

        home.file = {
            # Auto start on-screen keyboard (useful if Steam is closed)
            ".config/autostart/onboard-autostart.desktop".text = ''
                [Desktop Entry]
                X-XFCE-Autostart-Override=true
            '';

            # Auto start Steam (so native controls work)
            ".config/autostart/Steam.desktop".text = ''
                [Desktop Entry]
                Encoding=UTF-8
                Version=0.9.4
                Type=Application
                Name=Steam
                Comment=needed for inputs
                Exec=steam
                OnlyShowIn=XFCE;
                RunHook=0
                StartupNotify=false
                Terminal=false
                Hidden=false
            '';
        };
    } ];
}
