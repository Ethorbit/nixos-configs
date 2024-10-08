{ config, ... }:

{
    home-manager.sharedModules = [ {
        services.polybar.config = {
            "module/memory" = {
                type = "internal/memory";
                interval = 2;
                format-prefix = " ";
                format-prefix-foreground = config.ethorbit.polybar.colors.foreground-alt;
                format-underline = "#4bffdc";
                label = "RAM: %percentage_used%%";
            };

            "module/memory-available" = {
                type = "custom/script";
                exec = "${config.ethorbit.polybar.scripts.memory-available.outPath}";
                label-urgent = "";
                format = " <label>";
                format-offset = "-7";
                #format-margin = 1;
                format-underline = "#7895c4";
                #f50a4d
                interval = 12;
            };
        };
    } ];
}
