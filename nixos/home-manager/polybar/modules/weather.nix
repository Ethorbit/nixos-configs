{ config, ... }:

{
    home-manager.sharedModules = [ {
        services.polybar.config = {
            "module/weather" = {
                type = "custom/script";
                exec = "${config.ethorbit.polybar.scripts.weather.outPath}";
                label-urgent = "";
                #format-prefix="⛅  ";
                format = "<label>";
                #format-offset = "-13";
                #format-margin = 1;
                format-underline = "#7895c4";
                #f50a4d
                interval = 12;
            };
        };
    } ];
}
