{ config, ... }:

{
    home-manager.users.${config.ethorbit.users.primary.username}.services.polybar.config = {
        "module/cpu" = {
            type = "internal/cpu";
            interval = 2;
            format-prefix = " ";
            format-prefix-foreground = config.ethorbit.polybar.colors.foreground-alt;
            format-underline = "#7895c4";
            #f90000
            label = "CPU: %percentage%% ";
        };

        "module/amd-cpu-temperature" = {
            type = "custom/script";
            exec = "${config.ethorbit.polybar.scripts.amd.cpu-temperature.outPath}";
            label-urgent = "";
            format = "<label>";
            format-offset = "-13";
            #format-margin = 1;
            format-underline = "#7895c4";
            #f50a4d
            interval = 3;
        };
    };
}
