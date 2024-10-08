{ config, ... }:

{
    home-manager.sharedModules = [ {
        services.polybar.config = {
            "module/bspwm" = {
                type = "internal/bspwm";

                label-focused = "%index%";
                label-focused-background = config.ethorbit.polybar.colors.background-alt;
                label-focused-underline= config.ethorbit.polybar.colors.primary;
                label-focused-padding = 2;

                label-occupied = "%index%";
                label-occupied-padding = 2;

                label-urgent = "%index%!";
                label-urgent-background = config.ethorbit.polybar.colors.alert;
                label-urgent-padding = 2;

                label-empty = "%index%";
                label-empty-foreground = config.ethorbit.polybar.colors.foreground-alt;
                label-empty-padding = 2;

                # Separator in between workspaces
                #label-separator = |
            };
        };
    } ];
}
