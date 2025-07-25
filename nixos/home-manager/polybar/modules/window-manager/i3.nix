{ config, ... }:

let
    cfg = config.ethorbit.polybar;
    self = {
        label-focused-background = cfg.colors.background-alt;
        label-focused-underline = "#ffffff";
        label-focused-padding = 2;
    };
in
{
    home-manager.sharedModules = [ {
        services.polybar.config = {
            "module/i3" = self // {
                type = "internal/i3";
                format = "<label-state> <label-mode>";
                index-sort = true;
                wrapping-scroll = false;

                # Only show workspaces on the same output as the bar
                pin-workspaces = true;

                label-mode-padding = 2;
                label-mode-foreground = "#000";
                label-mode-background = cfg.colors.primary;

                # focused = Active workspace on focused monitor
                label-focused = "%name%";
                #${colors.primary}

                # unfocused = Inactive workspace on any monitor
                label-unfocused = "%name%";
                label-unfocused-padding = 2;

                # visible = Active workspace on unfocused monitor
                label-visible = "%name%";
                label-visible-background = self.label-focused-background;
                label-visible-underline = self.label-focused-underline;
                label-visible-padding = self.label-focused-padding;

                # urgent = Workspace with urgency hint set
                label-urgent = "%name%";
                label-urgent-background = cfg.colors.alert;
                label-urgent-padding = 2;

                # Separator in between workspaces
                # label-separator = |
            };
        };
    } ];
}
