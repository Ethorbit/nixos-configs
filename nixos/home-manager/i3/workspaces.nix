# Multi-monitor workspace support added to i3!
# Simply setup monitor names for your system and then you can press Super + monitor # to manage workspaces for each monitor.
# If no monitor is configured, whatever monitor a workspace was opened on becomes the owner of said workspace. This can make navigation confusing.

{ config, lib, pkgs, ... }:

with lib;
let
    # There is a hard limit of nine monitors because of number keys 1-9.
    # I will be impressed if someone is actually utilizing more than 9 monitors though.
    monitors = {
        one = { name = "one"; number = "1"; prefix = "a"; };
        two = { name = "two"; number = "2"; prefix = "b"; };
        three = { name ="three"; number = "3"; prefix = "c"; };
        four = { name = "four"; number = "4"; prefix = "d"; };
        five = { name = "five"; number = "5"; prefix = "e"; };
        six = { name = "six"; number = "6"; prefix = "f"; };
        seven = { name = "seven"; number = "7"; prefix = "g"; };
        eight = { name = "eight"; number = "8"; prefix = "h"; };
        nine = { name = "nine"; number = "9"; prefix = "i"; };
    };

    # Basically just monitors, but the keys changed from the word of the number to the path of the i3 file.
    # I did this so that I can directly map it to the home-manager file config just as I was able to do with the workspace.monitor options
    monitorFiles = listToAttrs (map (v: { name = ".config/i3/workspaces/${v}"; value = monitors."${v}"; }) (attrNames monitors));
in
{
    options.ethorbit.home-manager.i3.workspace.monitor = mapAttrs (monitor: _: mkOption {
        type = types.str;
        default = "none";
        example = "HDMI-2";
        description = "The monitor name (retrieved by tools such as Xrandr) that should be assigned to this keyboard number, you press (Super + #) to select which monitor to manage workspaces for.";
    }) monitors;

    config.home-manager.sharedModules = [ {
        home.file = mapAttrs (name: data: {
            text = ''
                set $i3_resurrect ${pkgs.i3-resurrect}/bin/i3-resurrect
                set $monitor_${data.name} "${config.ethorbit.home-manager.i3.workspace.monitor.${data.name}}"

                workspace ${data.prefix}1 output $monitor_${data.name}
                workspace ${data.prefix}2 output $monitor_${data.name}
                workspace ${data.prefix}3 output $monitor_${data.name}
                workspace ${data.prefix}4 output $monitor_${data.name}
                workspace ${data.prefix}5 output $monitor_${data.name}
                workspace ${data.prefix}6 output $monitor_${data.name}
                workspace ${data.prefix}7 output $monitor_${data.name}
                workspace ${data.prefix}8 output $monitor_${data.name}
                workspace ${data.prefix}9 output $monitor_${data.name}

                bindsym $mod+${data.number} mode "workspace monitor ${data.number}" fullscreen disable

                mode "workspace monitor ${data.number}" {
                    bindsym Escape mode "default"
                    bindsym Return mode "default"
                    bindsym $mod+space mode "workspace custom"
                    bindsym $mod+1 mode "workspace monitor ${data.number}"
                    bindsym f focus output $monitor_${data.name}
                    bindsym 1 workspace ${data.prefix}1
                    bindsym 2 workspace ${data.prefix}2
                    bindsym 3 workspace ${data.prefix}3
                    bindsym 4 workspace ${data.prefix}4
                    bindsym 5 workspace ${data.prefix}5
                    bindsym 6 workspace ${data.prefix}6
                    bindsym 7 workspace ${data.prefix}7
                    bindsym 8 workspace ${data.prefix}8
                    bindsym 9 workspace ${data.prefix}9
                    bindsym Shift+1 move container to workspace ${data.prefix}1
                    bindsym Shift+2 move container to workspace ${data.prefix}2
                    bindsym Shift+3 move container to workspace ${data.prefix}3
                    bindsym Shift+4 move container to workspace ${data.prefix}4
                    bindsym Shift+5 move container to workspace ${data.prefix}5
                    bindsym Shift+6 move container to workspace ${data.prefix}6
                    bindsym Shift+7 move container to workspace ${data.prefix}7
                    bindsym Shift+8 move container to workspace ${data.prefix}8
                    bindsym Shift+9 move container to workspace ${data.prefix}9
                    bindsym s mode "workspace save monitor ${data.number}"
                    bindsym r mode "workspace restore monitor ${data.number}"
                }
                
                mode "workspace save monitor ${data.number}" {
                    bindsym Escape mode "workspace monitor ${data.number}"
                    bindsym Return mode "workspace monitor ${data.number}"
                    bindsym a exec "for i in {1..9}; do $i3_resurrect save -w a''${i}; done"
                    bindsym 1 exec "$i3_resurrect save -w ${data.prefix}1"
                    bindsym 2 exec "$i3_resurrect save -w ${data.prefix}2"
                    bindsym 3 exec "$i3_resurrect save -w ${data.prefix}3"
                    bindsym 4 exec "$i3_resurrect save -w ${data.prefix}4"
                    bindsym 5 exec "$i3_resurrect save -w ${data.prefix}5"
                    bindsym 6 exec "$i3_resurrect save -w ${data.prefix}6"
                    bindsym 7 exec "$i3_resurrect save -w ${data.prefix}7"
                    bindsym 8 exec "$i3_resurrect save -w ${data.prefix}8"
                    bindsym 9 exec "$i3_resurrect save -w ${data.prefix}9"
                }
                mode "workspace restore monitor ${data.number}" {
                    bindsym Escape mode "workspace monitor ${data.number}"
                    bindsym Return mode "workspace monitor ${data.number}"
                    bindsym a exec "for i in {1..9}; do $i3_resurrect restore -w a''${i}; done"
                    bindsym 1 exec "$i3_resurrect restore -w ${data.prefix}1"
                    bindsym 2 exec "$i3_resurrect restore -w ${data.prefix}2"
                    bindsym 3 exec "$i3_resurrect restore -w ${data.prefix}3"
                    bindsym 4 exec "$i3_resurrect restore -w ${data.prefix}4"
                    bindsym 5 exec "$i3_resurrect restore -w ${data.prefix}5"
                    bindsym 6 exec "$i3_resurrect restore -w ${data.prefix}6"
                    bindsym 7 exec "$i3_resurrect restore -w ${data.prefix}7"
                    bindsym 8 exec "$i3_resurrect restore -w ${data.prefix}8"
                    bindsym 9 exec "$i3_resurrect restore -w ${data.prefix}9"
                }

                ${(if (data.number == "1") then ''
                exec i3-msg workspace a1
                
                bindsym $mod+0 mode "all workspace monitors" fullscreen disable

                mode "all workspace monitors" {
                    bindsym Escape mode "default"
                    bindsym Return mode "default"
                    bindsym s exec "for i in {1..9}; do $i3_resurrect save -w a''${i}; $i3_resurrect save -w b''${i}; $i3_resurrect save -w c''${i}; done"
                    bindsym r exec "for i in {1..9}; do $i3_resurrect restore -w a''${i}; $i3_resurrect restore -w b''${i}; $i3_resurrect restore -w c''${i}; done"
                }
                '' else "")}
            ''; 
        }) monitorFiles;
    } ];
}
