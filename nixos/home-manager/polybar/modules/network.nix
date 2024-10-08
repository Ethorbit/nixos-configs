{ config, ... }:

{
    home-manager.sharedModules = [ {
        services.polybar.config = {
            "module/wlan" = {
                type = "internal/network";
                interface = "wlo1";
                interval = "3.0";

                format-connected = "<ramp-signal> <label-connected>";
                format-connected-underline = "#9f78e1";
                label-connected = "%essid%";

                format-disconnected = "";
                #format-disconnected = "<label-disconnected>";
                #format-disconnected-underline = "$${self.format-connected-underline}";
                #label-disconnected = "%ifname% disconnected";
                #label-disconnected-foreground = colors.foreground-alt;

                ramp-signal-0 = "";
                ramp-signal-1 = "";
                ramp-signal-2 = "";
                ramp-signal-3 = "";
                ramp-signal-4 = "";
                ramp-signal-foreground = config.ethorbit.polybar.colors.foreground-alt;
            };

            "module/network" = {
                type = "internal/network";
                interface = "enp2s0";
                interval = "1.0";
                label-connected = "  ↓ %downspeed%   ↑ %upspeed%   ";
                label-disconnected = "disconnected";
                #label-connected-background = "#FF00000";
                label-connected-underline = "#ceffab";
                #96ffab
            };

            "module/eth" = {
                type = "internal/network";
                interface = "enp2s0";
                interval = "3.0";

                format-connected-underline = "#55aa55";
                format-connected-prefix = " ";
                format-connected-prefix-foreground = config.ethorbit.polybar.colors.foreground-alt;
                label-connected = "%local_ip%";

                format-disconnected = "";
                #format-disconnected = "<label-disconnected>";
                #format-disconnected-underline = "$${self.format-connected-underline}";
                #label-disconnected = "%ifname% disconnected";
                #label-disconnected-foreground = colors.foreground-alt;
            };
        };
    } ];
}
