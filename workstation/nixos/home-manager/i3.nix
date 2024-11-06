{ config, ... }:

{
    ethorbit.home-manager = {
        i3 = {
            workspace.monitor = {
                one = "HDMI-0";
                two = "DVI-D-0";
            };

            music.refreshDirectory = "/mnt/storage/Music/Mp3 Player";
        };
    };

    home-manager.sharedModules = [ {
        home.file.".config/i3/config_system".text = ''
            for_window [class="KeePassXC"] floating enable, resize set width 20 ppt, resize set height 20 ppt, sticky enable
            for_window [class="chromium-browser"] layout tabbed

            # Second monitor will be used for casual gaming
            for_window [class="Lutris"] move to workspace b1, layout tabbed
            for_window [class="zenity"] move to workspace b1
            for_window [class="steam"] move to workspace b1, layout tabbed
            for_window [class="steam" title="^(?!Steam|Friends List).*$"] floating enable
            for_window [class="steam" title="Friends List"] focus, move right, move right, move right, move right, move right, move right, move right, resize set width 20 ppt
            for_window [class="steam_app_*"] move to workspace b1
            for_window [class="gamescope-brokey"] move to workspace b1
            for_window [class="Limo"] move to workspace b1, floating enable
            for_window [class="LOOT"] move to workspace b1, floating enable
        '';
    } ];
}
