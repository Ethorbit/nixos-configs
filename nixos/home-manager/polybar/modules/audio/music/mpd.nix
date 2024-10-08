{ config, ... }:

{
    home-manager.sharedModules = [ {
        services.polybar.config = {
            "module/mpd" = {
                type = "internal/mpd";
                format-online = "<label-song>  <icon-prev> <icon-stop> <toggle> <icon-next>";

                icon-prev = "";
                icon-stop = "";
                icon-play = "";
                icon-pause = "";
                icon-next = "";

                label-song-maxlen = 25;
                label-song-ellipsis = true;
            };
        };
    } ];
}
