{ config, ... }:

{
    home-manager.users.${config.ethorbit.users.primary.username}.services.polybar.config = {
        "module/battery" = {
            type = "internal/battery";
            battery = "BAT0";
            adapter = "AC";
            full-at = "98";

            format-charging = "<animation-charging> <label-charging>";
            format-charging-underline = "#ffb52a";

            format-discharging = "<animation-discharging> <label-discharging>";
            format-discharging-underline = "$${self.format-charging-underline}";

            format-full-prefix = " ";
            format-full-prefix-foreground = config.ethorbit.polybar.colors.foreground-alt;
            format-full-underline = "$${self.format-charging-underline}";

            ramp-capacity-0 = "";
            ramp-capacity-1 = "";
            ramp-capacity-2 = "";
            ramp-capacity-foreground = config.ethorbit.polybar.colors.foreground-alt;

            animation-charging-0 = "";
            animation-charging-1 = "";
            animation-charging-2 = "";
            animation-charging-foreground = config.ethorbit.polybar.colors.foreground-alt;
            animation-charging-framerate = 750;

            animation-discharging-0 = "";
            animation-discharging-1 = "";
            animation-discharging-2 = "";
            animation-discharging-foreground = config.ethorbit.polybar.colors.foreground-alt;
            animation-discharging-framerate = 750;
        };
    };
}
