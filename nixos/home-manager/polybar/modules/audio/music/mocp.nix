{ config, pkgs, ... }:

{
    home-manager.users.${config.ethorbit.users.primary.username}.services.polybar.config = {
        "module/mocp/song-name" = {
            type = "custom/script";
            exec = "${config.ethorbit.polybar.scripts.mocp.song-name.outPath}";
            tail = true;
            click-left = "kill -USR1 %pid%";
        };

        "module/mocp/previous" = {
            type = "custom/script";
            exec = ''${pkgs.bash}/bin/bash -c "echo \<\<"'';
            exec-if = ''[[ $("${config.ethorbit.polybar.scripts.mocp.state.outPath}") = "PLAY" ]]'';
            interval = 1;
            click-left = "${pkgs.moc}/bin/mocp -r";
        };

        "module/mocp/toggleplay" = {
            type = "custom/script";
            exec = "${config.ethorbit.polybar.scripts.mocp.toggle-play.outPath}";
            interval = 1;
            click-left = "${pkgs.moc}/bin/mocp -G";
        };

        "module/mocp/next" = {
            type = "custom/script";
            exec = ''${pkgs.bash}/bin/bash -c "echo \>\>"'';
            exec-if = ''[[ $("${config.ethorbit.polybar.scripts.mocp.state.outPath}") = "PLAY" ]]'';
            interval = 1;
            click-left = "${pkgs.moc}/bin/mocp -f";
        };
    };
}
