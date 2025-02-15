{ config, ... }:

{
    home-manager.sharedModules = [ {
        # Rotate XFCE desktop
        xfconf.settings = {
            displays = {
                "Rotation" = 0;
                "Default/eDP-1/Rotation" = 270;
                "Default/eDP-1/Reflection" = "0";
            };
        };

        # Make XFCE auto start Steam (so native controls work)
        home.file.".config/autostart/Steam.desktop".text = ''
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
    } ];
}
