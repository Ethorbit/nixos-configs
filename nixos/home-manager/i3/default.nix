{ config, lib, pkgs, ... }:

{
    imports = [
        ./workspaces.nix
        ./music.nix
    ];
    
    options.ethorbit.home-manager.i3 = with lib; {
        keys = {
            mod = mkOption {
                type = types.str;
                default = "Mod4";
                example = "Mod1";
                description = "This is the special key i3 will use for most key maps. Set it to something that no other application relies on.";
            };

            alt = mkOption {
                type = types.str;
                default = "Mod1";
                example = "Mod4";
                description = ''
                    This is the 'Alt' key. When user presses 'Alt' + h, the window is hidden and 'Alt' + TAB cycles between hidden windows.
                    Unfloating a hidden window also unhides it. This is all meant to mimic alt + tabbing that you'd have in traditional Desktop environments.
                '';
            };
        };
    };

    config = {
        home-manager.sharedModules = [ {
            home.file.".xinitrc" = {
                executable = true;
                text = ''
                    exec ${pkgs.dbus}/bin/dbus-launch ${pkgs.i3}/bin/i3
                '';
            };

            home.file.".config/i3/config" = {
                text = ''
                    # i3 config file (v4)
                    #
                    # Please see https://i3wm.org/docs/userguide.html for a complete reference!

                    include $HOME/.config/i3/workspaces/*
                    include $HOME/.config/i3/music
                    include $HOME/.config/i3/config_system # Put your system-dependent i3 configuration in there.

                    # Prevent auto focusing cause it's really annoying
                    no_focus [all]
                    focus_on_window_activation none
                    mouse_warping none

                    # keep this current file for configuration that is meant for global i3 configuration that ALL systems use by default
                    # if there's something that only a few systems will need, keep that in the config_system file above!
                    set $mod ${config.ethorbit.home-manager.i3.keys.mod}
                    set $alt ${config.ethorbit.home-manager.i3.keys.alt}
                    #set $numlock Mod2

                    # Font for window titles. Will also be used by the bar unless a different font
                    # is used in the bar {} block below.
                    font pango:monospace 8

                    # Why tf is this not the default?
                    exec_always --no-startup-id autotiling

                    # This font is widely installed, provides lots of unicode glyphs, right-to-left
                    # text rendering and scalability on retina/hidpi displays (thanks to pango).
                    #font pango:DejaVu Sans Mono 8

                    # Start XDG autostart .desktop files using dex. See also
                    # https://wiki.archlinux.org/index.php/XDG_Autostart
                    exec --no-startup-id dex --autostart --environment i3

                    # The combination of xss-lock, nm-applet and pactl is a popular choice, so
                    # they are included here as an example. Modify as you see fit.

                    # xss-lock grabs a logind suspend inhibit lock and will use i3lock to lock the
                    # screen before suspend. Use loginctl lock-session to lock your screen.
                    exec --no-startup-id xss-lock --transfer-sleep-lock -- i3lock --nofork

                    # NetworkManager is the most popular way to manage wireless networks on Linux,
                    # and nm-applet is a desktop environment-independent system tray GUI for it.
                    exec --no-startup-id nm-applet

                    # Use pactl to adjust volume in PulseAudio.
                    set $refresh_i3status killall -SIGUSR1 i3status
                    bindsym XF86AudioRaiseVolume exec --no-startup-id pactl set-sink-volume @DEFAULT_SINK@ +10% && $refresh_i3status
                    bindsym XF86AudioLowerVolume exec --no-startup-id pactl set-sink-volume @DEFAULT_SINK@ -10% && $refresh_i3status
                    bindsym XF86AudioMute exec --no-startup-id pactl set-sink-mute @DEFAULT_SINK@ toggle && $refresh_i3status
                    bindsym XF86AudioMicMute exec --no-startup-id pactl set-source-mute @DEFAULT_SOURCE@ toggle && $refresh_i3status

                    # Configure microphone 
                    exec --no-startup-id pa-toggle-mic.sh --disable
                    bindsym XF86AudioPlay exec --no-startup-id pa-toggle-mic.sh --toggle

                    # Use Mouse+$mod to drag floating windows to their wanted position
                    floating_modifier $mod

                    # start a terminal
                    bindsym $mod+Return exec kitty

                    # kill focused window
                    bindsym $mod+Shift+q kill

                    # alt tab
                    #bindsym $mod+Tab exec /usr/bin/i3-alt-tab.py next all
                    #refer to the git for more bindings..

                    # change focus
                    bindsym $mod+j focus left
                    bindsym $mod+k focus down
                    bindsym $mod+l focus up
                    bindsym $mod+semicolon focus right

                    # alternatively, you can use the cursor keys:
                    bindsym $mod+Left focus left
                    bindsym $mod+Down focus down
                    bindsym $mod+Up focus up
                    bindsym $mod+Right focus right

                    # move focused window
                    bindsym $mod+Shift+j move left
                    bindsym $mod+Shift+k move down
                    #bindsym $mod+Shift+l move up
                    bindsym $mod+Shift+semicolon move right

                    # alternatively, you can use the cursor keys:
                    bindsym $mod+Shift+Left move left
                    bindsym $mod+Shift+Down move down
                    bindsym $mod+Shift+Up move up
                    bindsym $mod+Shift+Right move right

                    # split in horizontal orientation
                    bindsym $mod+h split h

                    # split in vertical orientation
                    bindsym $mod+v split v

                    # enter fullscreen mode for the focused container
                    bindsym $mod+f fullscreen toggle

                    # change container layout (stacked, tabbed, toggle split)
                    bindsym $mod+s layout stacking
                    bindsym $mod+w layout tabbed
                    bindsym $mod+e layout toggle split

                    # toggle tiling / floating
                    bindsym $mod+Shift+space floating toggle

                    # change focus between tiling / floating windows
                    bindsym $mod+space focus mode_toggle

                    # focus the parent container
                    bindsym $mod+a focus parent

                    # focus the child container
                    #bindsym $mod+d focus child

                    #### Set command hotkeys ####
                    bindsym $mod+Shift+slash exec "$HOME/.config/rofi/rofi-rofi.sh" 

                    #### Scratchpad ####
                    bindsym --release $alt+h move scratchpad
                    bindsym --release $alt+Tab scratchpad show

                    #### Set default program workspaces ####
                      # Terminal
                    exec --no-startup-id kitty

                    # lock cursor to current window
                    bindsym $mod+Shift+l exec "mousejail 1" 

                    # reload the configuration file
                    bindsym $mod+Shift+c reload
                    # restart i3 inplace (preserves your layout/session, can be used to upgrade i3)
                    bindsym $mod+Shift+r fullscreen disable, restart
                    # exit i3 (logs you out of your X session)
                    bindsym $mod+Shift+e exec "i3-nagbar -t warning -m 'You pressed the exit shortcut. Do you really want to exit i3? This will end your X session.' -B 'Yes, exit i3' 'i3-msg exit'"

                    # resize window (you can also use the mouse for that)
                    mode "resize" {
                            # These bindings trigger as soon as you enter the resize mode

                            # Pressing left will shrink the window’s width.
                            # Pressing right will grow the window’s width.
                            # Pressing up will shrink the window’s height.
                            # Pressing down will grow the window’s height.
                            bindsym j resize shrink width 10 px or 10 ppt
                            bindsym k resize grow height 10 px or 10 ppt
                            bindsym l resize shrink height 10 px or 10 ppt
                            bindsym semicolon resize grow width 10 px or 10 ppt

                            # same bindings, but for the arrow keys
                            bindsym Left resize shrink width 10 px or 10 ppt
                            bindsym Down resize grow height 10 px or 10 ppt
                            bindsym Up resize shrink height 10 px or 10 ppt
                            bindsym Right resize grow width 10 px or 10 ppt

                            # back to normal: Enter or Escape or $mod+r
                            bindsym Return mode "default"
                            bindsym Escape mode "default"
                            bindsym $mod+r mode "default"
                    }

                    bindsym $mod+r mode "resize" fullscreen disable

                    ## Start i3bar to display a workspace bar (plus the system information i3status
                    ## finds out, if available)
                    #bar {
                    #        status_command i3status
                    #   
                    #   colors {
                    #       background #003800
                    #       #background #182118
                    #       # #3cb93c
                    #   }
                    #
                    #   height 22
                    #}

                    #dummy bar for polybar
                    #bar {
                    #   i3bar_command i3bar -t 
                    #   workspace_buttons no
                    #   tray_output none
                    #   height 28
                    #   mode dock
                    #   position top
                    #
                    #       colors { 
                    #           background #00000000
                    #       statusline #00000000
                    #       separator #00000000
                    #       focused_workspace #00000000 #00000000 #00000000
                    #       inactive_workspace #00000000 #00000000 #00000000
                    #       urgent_workspace #00000000 #00000000 #00000000
                    #       }
                    #}

                    client.unfocused #000000 #545455 #FFFFFF #545455
                    client.focused #000000 #4f4f7d #FFFFFF #4f4f7d
                    #client.focused_inactive #000000 #757575 #FFFFFF #4a4a4a

                    # Remove borders (for i3-gaps)
                    for_window [class=".*"] border pixel 1
                    smart_borders on

                    # Add gaps
                    gaps inner 8
                    gaps outer 0
                    gaps top 28
                    #border_radius 10

                    #exec xset -b             
                    #exec xset s off             

                    # Screenshot
                    bindsym --release Print exec flameshot screen -c -p $HOME/Downloads/Screenshots/
                    bindsym $mod+Print exec flameshot gui  

                    # light-locker cannot start on its own, so we must do it manually
                    exec_always --no-startup-id /usr/bin/env bash -c "[ $(command -v light-locker) ] && ${config.ethorbit.pkgs.script.light-locker.script}/bin/script"

                    # exec_always --no-startup-id picom #--experimental-backends

                    # Let these services handle everything else (the things that all desktops should do): 
                    exec --no-startup-id systemctl --user restart window-manager-once.service
                    exec_always --no-startup-id systemctl --user restart window-manager-always.service
                '';
            };
        } ];
    };
}
