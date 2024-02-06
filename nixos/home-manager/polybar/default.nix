{ config, pkgs, ... }:

let
    colors = {
        background = "#aa500";
        background-alt = "#444";
        foreground = "#dfdfdf";
        foreground-alt = "#555";
        primary = "#ffb52a";
        secondary = "#e60053";
        alert = "#bd2c40";
    };

    style = {
        radius = "0.0";
    };
in
{
    imports = [
        ./scripts
    ];

    home-manager.users.${config.ethorbit.users.primary.username} = {
        services.polybar = {
            enable = true;

            package = pkgs.polybar.override {
                i3Support = true;
            };

            script = ''
                exec "${config.ethorbit.polybar.scripts.launch.outPath}"
            '';

            config = {
                "bar/main" = {
                    width = "99.5%";
                    height = "30";
                    offset-x = "0.2%";
                    offset-y = "-4";
                    radius = style.radius;
                    fixed-center = true;

                    background = colors.background;
                    foreground = colors.foreground;
                    
                    #line-size = 1
                    line-color = "#f00";

                    border-bottom-size = 1;
                    border-color = "#545455";
                    #a08c8c8c

                    padding-top = 0;
                    padding-left = 1;
                    padding-right = 2;

                    module-margin-left = 0;
                    module-margin-right = 3;

                    font-0 = "fixed:pixelsize=8.3;1";
                    font-1 = "Noto Color Emoji:scale=17;style=Regular;1";
                    font-2 = "siji:pixelsize=10;1";

                    modules-left = "i3";                    
                    #modules-center = "mpd";
                    modules-center = "memory memory-available cpu nvidia-gpu mocp/song-name mocp/previous mocp/toggleplay mocp/next";
                    modules-right = "date weather powermenu";

                    tray-position = "right";
                    tray-padding = 2;
                    #tray-background = "#0063ff";

                    #;wm-restack = "bspwm";
                    wm-restack = "i3";

                    override-redirect = true;

                    #scroll-up = "bspwm-desknext";
                    #scroll-down = "bspwm-deskprev";

                    #scroll-up = "i3wm-wsnext";
                    #scroll-down = "i3wm-wsprev";

                    cursor-click = "pointer";
                    cursor-scroll = "ns-resize";
                };

                "bar/notmain" = {
                    monitor = "$${env:MONITOR:}";
                    width = "99.6%";
                    height = "30";
                    offset-x = "0.2%";
                    offset-y = "-4";
                    radius = style.radius;
                    fixed-center = true;

                    background = colors.background;
                    foreground = colors.foreground;

                    #line-size = 3;
                    line-color = "#f00";

                    border-size = 4;
                    border-bottom-size = 1;
                    border-top-size = 0;
                    border-right-size = 0;
                    border-left-size = 0;
                    border-color = "#545455";

                    padding-left = 1;
                    padding-right = 2;

                    module-margin-left = 0;
                    module-margin-right = 3;

                    font-0 = "fixed:pixelsize=9;1";
                    font-1 = "Noto Color Emoji:scale=2.1;style=Regular;0";
                    font-2 = "siji:pixelsize=10;1";

                    modules-left = "bspwm i3";
                    # modules-center = mpd
                    # modules-center = memory memory-available cpu amd-cpu-temperature amd-gpu
                    modules-center = "memory memory-available cpu nvidia-gpu mocp/song-name mocp/previous mocp/toggleplay mocp/next";
                    modules-right = "date weather";

                    #tray-position = "right";
                    #tray-padding = 2;
                    #tray-background = "#0063ff";

                    #wm-restack = "bspwm";
                    wm-restack = "i3";

                    override-redirect = true;

                    #scroll-up = "bspwm-desknext";
                    #scroll-down = "bspwm-deskprev";

                    #scroll-up = "i3wm-wsnext";
                    #scroll-down = "i3wm-wsprev";

                    cursor-click = "pointer";
                    cursor-scroll = "ns-resize";
                };

                "module/mocp/song-name" = {
                    type = "custom/script";
                    exec = "${config.ethorbit.polybar.scripts.mocp.song-name.outPath}";
                    tail = true;
                    click-left = "kill -USR1 %pid%";
                };

                "module/mocp/previous" = {
                    type = "custom/script";
                    exec = ''/bin/bash -c "echo \"<<\""'';
                    exec-if = ''[[ $("${config.ethorbit.polybar.scripts.mocp.state.outPath}") = "PLAY" ]]'';
                    interval = 1;
                    click-left = "${pkgs.moc}/bin/mocp -r";
                };

                "module/mocp/toggleplay" = {
                    type = "custom/script";
                    exec = "${config.ethorbit.polybar.scripts.mocp.toggle-play.outPath}";
                    interval = 1;
                    click-left = "${pkgs.moc}/bin/mocp -G";
                };

                "module/mocp/next" = {
                    type = "custom/script";
                    exec = ''/bin/bash -c "echo \">>\""'';
                    exec-if = ''[[ $("${config.ethorbit.polybar.scripts.mocp.state.outPath}") = "PLAY" ]]'';
                    interval = 1;
                    click-left = "${pkgs.moc}/bin/mocp -f";
                };

                "module/scream" = {
                    exec = "${config.ethorbit.polybar.scripts.scream.scream.outPath}";
                    type = "custom/script";
                    click-left = "${config.ethorbit.polybar.scripts.scream.toggle.outPath}";
                    interval = 1;
                    format-underline = "#ffffff";
                };

                "module/microphone" = {
                    exec = "${config.ethorbit.polybar.scripts.microphone.outPath}";
                    type = "custom/script";
                    click-left = "pa-toggle-mic.sh --toggle";
                    interval = 1;
                    format-underline = "#ffffff";
                };

                "module/xwindow" = {
                    type = "internal/xwindow";
                    label = "%title:0:30:...%";
                };

                "module/xkeyboard" = {
                    type = "internal/xkeyboard";
                    blacklist-0 = "num lock";

                    format-prefix = " ";
                    format-prefix-foreground = colors.foreground-alt;
                    format-prefix-underline = colors.secondary;

                    label-layout = "%layout%";
                    label-layout-underline = colors.secondary;

                    label-indicator-padding = 2;
                    label-indicator-margin = 1;
                    label-indicator-background = colors.secondary;
                    label-indicator-underline = colors.secondary;
                };

                "module/filesystem" = {
                    type = "internal/fs";
                    interval = 25;

                    mount-0 = "/";
                    #mount-1 = /mnt/Int-HDD-Linux
                    #mount-2 = /mnt/Int-SSD-One
                    #mount-2 = /mnt/Ext-HDD-One
                    #mount-4 = /mnt/Ext-HDD-Two
                    #mount-5 = /mnt/Int-HDD-Windows

                    label-mounted = "%{F#fffecc}%mountpoint%%{F-}: %percentage_used%%";
                    label-unmounted = "%mountpoint%";
                    label-unmounted-foreground = colors.foreground-alt;
                    #label-mounted-underline = "#fffee3";
                };

                "module/bspwm" = {
                    type = "internal/bspwm";

                    label-focused = "%index%";
                    label-focused-background = colors.background-alt;
                    label-focused-underline= colors.primary;
                    label-focused-padding = 2;

                    label-occupied = "%index%";
                    label-occupied-padding = 2;

                    label-urgent = "%index%!";
                    label-urgent-background = colors.alert;
                    label-urgent-padding = 2;

                    label-empty = "%index%";
                    label-empty-foreground = colors.foreground-alt;
                    label-empty-padding = 2;

                    # Separator in between workspaces
                    #label-separator = |
                };
                
                "module/i3" = {
                    type = "internal/i3";
                    format = "<label-state> <label-mode>";
                    index-sort = true;
                    wrapping-scroll = false;

                    # Only show workspaces on the same output as the bar
                    pin-workspaces = true;

                    label-mode-padding = 2;
                    label-mode-foreground = "#000";
                    label-mode-background = colors.primary;

                    # focused = Active workspace on focused monitor
                    label-focused = "%name%";
                    label-focused-background = colors.background-alt;
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
                    label-urgent-background = colors.alert;
                    label-urgent-padding = 2;

                    # Separator in between workspaces
                    # label-separator = |
                };

                "module/mpd" = {
                    type = "internal/mpd";
                    format-online = "<label-song>  <icon-prev> <icon-stop> <toggle> <icon-next>";

                    icon-prev = "";
                    icon-stop = "";
                    icon-play = "";
                    icon-pause = "";
                    icon-next = "";

                    label-song-maxlen = 25;
                    label-song-ellipsis = true;
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
                    bar-empty-foreground = colors.foreground-alt;
                };

                "module/backlight-acpi" = {
                    "inherit" = "module/xbacklight";
                    type = "internal/backlight";
                    card = "intel_backlight";
                };

                "module/cpu" = {
                    type = "internal/cpu";
                    interval = 2;
                    format-prefix = " ";
                    format-prefix-foreground = colors.foreground-alt;
                    format-underline = "#7895c4";
                    #f90000
                    label = "CPU: %percentage%% ";
                };

                "module/memory" = {
                    type = "internal/memory";
                    interval = 2;
                    format-prefix = " ";
                    format-prefix-foreground = colors.foreground-alt;
                    format-underline = "#4bffdc";
                    label = "RAM: %percentage_used%%";
                };

                "module/memory-available" = {
                    type = "custom/script";
                    exec = "${config.ethorbit.polybar.scripts.memory-available.outPath}";
                    label-urgent = "";
                    format = " <label>";
                    format-offset = "-7";
                    #format-margin = 1;
                    format-underline = "#7895c4";
                    #f50a4d
                    interval = 12;
                };

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
                    ramp-signal-foreground = colors.foreground-alt;
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
                    format-connected-prefix-foreground = colors.foreground-alt;
                    label-connected = "%local_ip%";

                    format-disconnected = "";
                    #format-disconnected = "<label-disconnected>";
                    #format-disconnected-underline = "$${self.format-connected-underline}";
                    #label-disconnected = "%ifname% disconnected";
                    #label-disconnected-foreground = colors.foreground-alt;
                };
                
                "module/date" = {
                    type = "internal/date";
                    interval = 5;

                    date = "%a,";
                    date-alt = "%D";

                    time = "%I:%M %p";
                    time-alt = "%r";

                    format-prefix = "🕗  ";
                    #format-prefix = " ";
                    format-prefix-foreground = colors.foreground-alt;
                    format-underline = "#0a6cf5";

                    label = "%date% %time%";
                };

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
                    bar-volume-empty-foreground = colors.foreground-alt;
                };

                "module/alsa" = {
                    type = "internal/alsa";

                    format-volume = "<label-volume> <bar-volume>";
                    label-volume = "VOL";
                    label-volume-foreground = "$${root.foreground}";

                    format-muted-prefix = " ";
                    format-muted-foreground = colors.foreground-alt;
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
                    bar-volume-empty-foreground = colors.foreground-alt;
                };

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
                    format-full-prefix-foreground = colors.foreground-alt;
                    format-full-underline = "$${self.format-charging-underline}";

                    ramp-capacity-0 = "";
                    ramp-capacity-1 = "";
                    ramp-capacity-2 = "";
                    ramp-capacity-foreground = colors.foreground-alt;

                    animation-charging-0 = "";
                    animation-charging-1 = "";
                    animation-charging-2 = "";
                    animation-charging-foreground = colors.foreground-alt;
                    animation-charging-framerate = 750;

                    animation-discharging-0 = "";
                    animation-discharging-1 = "";
                    animation-discharging-2 = "";
                    animation-discharging-foreground = colors.foreground-alt;
                    animation-discharging-framerate = 750;
                };

                "module/weather" = {
                    type = "custom/script";
                    exec = "${config.ethorbit.polybar.scripts.weather.outPath}";
                    label-urgent = "";
                    #format-prefix="⛅  ";
                    format = "<label>";
                    #format-offset = "-13";
                    #format-margin = 1;
                    format-underline = "#7895c4";
                    #f50a4d
                    interval = 12;
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

                "module/nvidia-gpu" = {
                    type = "custom/script";
                    exec = "${config.ethorbit.polybar.scripts.nvidia.gpu.outPath}";
                    format = "NVIDIA GPU: <label>";
                    format-underline = "#f50a4d";
                    interval = 5;
                };

                "module/amd-gpu" = {
                    type = "custom/script";
                    exec = "${config.ethorbit.polybar.scripts.amd.gpu.outPath}";
                    format-prefix="⬛ ";
                    #format-prefix="▣ ";
                    format = "AMD GPU: <label>";
                    format-offset = ""; # -4
                    format-underline = "#f50a4d";
                    interval = 5;
                };

                "module/powermenu" = {
                    type = "custom/menu";

                    expand-right = true;

                    format-spacing = 1;

                    label-open = "";
                    label-open-foreground = colors.secondary;
                    label-close = " cancel";
                    label-close-foreground = colors.secondary;
                    label-separator = "|";
                    label-separator-foreground = colors.foreground-alt;

                    menu-0-0 = "power off";
                    menu-0-0-exec = "menu-open-2";
                    menu-0-1 = "reboot";
                    menu-0-1-exec = "menu-open-1";
                    #menu-0-2 = "log out ";
                    #menu-0-2-exec = "menu-open-5";
                    menu-0-2 = "suspend";
                    menu-0-2-exec = "menu-open-3";
                    menu-0-3 = "turn off monitors";
                    menu-0-3-exec = "menu-open-4";

                    menu-1-0 = "cancel";
                    menu-1-0-exec = "menu-open-0";
                    menu-1-1 = "reboot";
                    menu-1-1-exec = "systemctl reboot";

                    menu-2-0 = "power off";
                    menu-2-0-exec = "shutdown -h now";
                    menu-2-1 = "cancel";
                    menu-2-1-exec = "menu-open-0";

                    menu-3-0 = "suspend";
                    menu-3-0-exec = "systemctl suspend";
                    menu-3-1 = "cancel";
                    menu-3-1-exec = "menu-open-0";

                    menu-4-0 = "turn off monitors";
                    menu-4-0-exec = "xset dpms force off";
                    menu-4-1 = "cancel";
                    menu-4-1-exec = "menu-open-0";

                    menu-5-0 = "log out";
                    menu-5-0-exec = "systemctl restart lightdm";
                    menu-5-1 = "cancel";
                    menu-5-1-exec = "menu-open-0";
                };

                "settings" = {
                    screenchange-reload = true;
                    #compositing-background = "xor";
                    #compositing-background = "screen";
                    #compositing-foreground = "source";
                    #compositing-border = "over";
                    #pseudo-transparency = false;
                };

                "global/wm" = {
                    margin-top = 5;
                    margin-bottom = 5;

                    # "vim:ft=dosini";
                };
            };
        };
    };
}