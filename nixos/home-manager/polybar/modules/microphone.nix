{ config, ... }:

{
    home-manager.users.${config.ethorbit.users.primary.username}.services.polybar.config = {
        "module/microphone" = {
            exec = "${config.ethorbit.polybar.scripts.microphone.outPath}";
            type = "custom/script";
            click-left = "pa-toggle-mic.sh --toggle";
            interval = 1;
            format-underline = "#ffffff";
        };
    };
}
