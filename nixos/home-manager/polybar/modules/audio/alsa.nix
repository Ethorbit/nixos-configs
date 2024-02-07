{ config, ... }:

{
    home-manager.users.${config.ethorbit.users.primary.username}.services.polybar.config = {
        "module/alsa" = {
            type = "internal/alsa";

            format-volume = "<label-volume> <bar-volume>";
            label-volume = "VOL";
            label-volume-foreground = "$${root.foreground}";

            format-muted-prefix = " ";
            format-muted-foreground = config.ethorbit.polybar.colors.foreground-alt;
            label-muted = "sound muted";

            bar-volume-width = 10;
            bar-volume-foreground-0 = "#55aa55";
            bar-volume-foreground-1 = "#55aa55";
            bar-volume-foreground-2 = "#55aa55";
            bar-volume-foreground-3 = "#55aa55";
            bar-volume-foreground-4 = "#55aa55";
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
}
