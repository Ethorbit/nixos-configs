{ config, ... }:

{
    home-manager.sharedModules = [ {
        services.polybar.config = {
            "module/i3" = {
                type = "internal/i3";
                format = "<label-state> <label-mode>";
                index-sort = true;
                wrapping-scroll = false;

                # Only show workspaces on the same output as the bar
                pin-workspaces = true;

                label-mode-padding = 2;
                label-mode-foreground = "#000";
                label-mode-background = config.ethorbit.polybar.colors.primary;

                # focused = Active workspace on focused monitor
                label-focused = "%name%";
                label-focused-background = config.ethorbit.polybar.colors.background-alt;
                label-focused-underline= "#ffffff";
                #${colors.primary}
                label-focused-padding = 2;

                # unfocused = Inactive workspace on any monitor
                label-unfocused = "%name%";
                label-unfocused-padding = 2;

                # visible = Active workspace on unfocused monitor
                label-visible = "%name%";
                label-visible-background = "$${self.label-focused-background}";
                label-visible-underline = "$${self.label-focused-underline}";
                label-visible-padding = "$${self.label-focused-padding}";

                # urgent = Workspace with urgency hint set
                label-urgent = "%name%";
                label-urgent-background = config.ethorbit.polybar.colors.alert;
                label-urgent-padding = 2;

                # Separator in between workspaces
                # label-separator = |
            };
        };
    } ];
}
