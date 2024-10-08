{ config, ... }:

{
    home-manager.sharedModules = [ {
        services.polybar.config = {
            "module/pulseaudio" = {
                type = "internal/pulseaudio";

                format-volume = "<label-volume> <bar-volume>";
                label-volume = "VOL %percentage%%";
                label-volume-foreground = "$${root.foreground}";

                label-muted = "🔇 muted";
                label-muted-foreground = "#666";

                bar-volume-width = 10;
                bar-volume-foreground-0 = "#55a4aa";
                bar-volume-foreground-1 = "#55a4aa";
                bar-volume-foreground-2 = "#55a4aa";
                bar-volume-foreground-3 = "#55a4aa";
                bar-volume-foreground-4 = "#55a4aa";
                bar-volume-foreground-5 = "#f5a70a";
                bar-volume-foreground-6 = "#ff5555";
                bar-volume-gradient = false;
                bar-volume-indicator = "|";
                bar-volume-indicator-font = 2;
                bar-volume-fill = "─";
                bar-volume-fill-font = 2;
                bar-volume-empty = "─";
                bar-volume-empty-font = 2;
                bar-volume-empty-foreground = config.ethorbit.polybar.colors.foreground-alt;
            };
        };
    } ];
}
