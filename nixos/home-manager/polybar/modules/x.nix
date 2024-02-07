{ config, ... }:

{
    home-manager.users.${config.ethorbit.users.primary.username}.services.polybar.config = {
        "module/xwindow" = {
            type = "internal/xwindow";
            label = "%title:0:30:...%";
        };

        "module/xkeyboard" = {
            type = "internal/xkeyboard";
            blacklist-0 = "num lock";

            format-prefix = " ";
            format-prefix-foreground = config.ethorbit.polybar.colors.foreground-alt;
            format-prefix-underline = config.ethorbit.polybar.colors.secondary;

            label-layout = "%layout%";
            label-layout-underline = config.ethorbit.polybar.colors.secondary;

            label-indicator-padding = 2;
            label-indicator-margin = 1;
            label-indicator-background = config.ethorbit.polybar.colors.secondary;
            label-indicator-underline = config.ethorbit.polybar.colors.secondary;
        };

        "module/xbacklight" = {
            type = "internal/xbacklight";

            format = "<label> <bar>";
            label = "BL";

            bar-width = 10;
            bar-indicator = "|";
            bar-indicator-foreground = "#fff";
            bar-indicator-font = 2;
            bar-fill = "─";
            bar-fill-font = 2;
            bar-fill-foreground = "#9f78e1";
            bar-empty = "─";
            bar-empty-font = 2;
            bar-empty-foreground = config.ethorbit.polybar.colors.foreground-alt;
        };

        "module/backlight-acpi" = {
            "inherit" = "module/xbacklight";
            type = "internal/backlight";
            card = "intel_backlight";
        };
    };
}
