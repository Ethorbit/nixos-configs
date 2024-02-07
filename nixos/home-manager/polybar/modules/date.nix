{ config, ... }:

{
    home-manager.users.${config.ethorbit.users.primary.username}.services.polybar.config = {
        "module/date" = {
            type = "internal/date";
            interval = 5;

            date = "%a,";
            date-alt = "%D";

            time = "%I:%M %p";
            time-alt = "%r";

            format-prefix = "🕗  ";
            #format-prefix = " ";
            format-prefix-foreground = config.ethorbit.polybar.colors.foreground-alt;
            format-underline = "#0a6cf5";

            label = "%date% %time%";
        };
    };
}
