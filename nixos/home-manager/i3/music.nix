{ config, lib, pkgs, ... }:

{
    options.ethorbit.home-manager.i3.music = with lib; {
        refreshDirectory = mkOption {
            default = "/home/${config.ethorbit.users.primary.username}/Music";
            description = "The directory to load audio files for when the music player refreshes.";
        };
    };

    config = with lib; {
        home-manager.users.${config.ethorbit.users.primary.username} = {
            home.file.".config/i3/music".text = ''
                mode "music" {
                    bindsym m mode "default"
                    bindsym q mode "default"
                    bindsym $mod+m mode "default"
                    bindsym Return mode "default"
                    bindsym Escape mode "default"

                    # Refresh
                    bindsym --release r exec --no-startup-id mocp -c && mocp -a "${config.ethorbit.home-manager.i3.music.refreshDirectory}" && mocp -p, mode "default"

                    # Next / Previous
                    bindsym --release Prior exec --no-startup-id mocp -f
                    bindsym --release Next exec --no-startup-id mocp -r
                    bindsym --release Up exec --no-startup-id mocp -f
                    bindsym --release Down exec --no-startup-id mocp -r
                    bindsym --release End exec --no-startup-id mocp -f
                    bindsym --release XF86AudioNext exec --no-startup-id mocp -f
                    bindsym --release XF86AudioPrev exec --no-startup-id mocp -r

                    # Toggle Pause
                    bindsym --release p exec --no-startup-id mocp -G, mode "default"
                    bindsym --release Pause exec --no-startup-id mocp -G, mode "default"
                    bindsym --release space exec --no-startup-id mocp -G, mode "default"
                    bindsym --release XF86AudioPlay exec --no-startup-id mocp -G, mode "default"

                    # Time manipulation
                    bindsym Right exec --no-startup-id mocp -k +3
                    bindsym Left exec --no-startup-id mocp -k -3
                    
                    # Volume
                    bindsym KP_Add exec --no-startup-id mocp -v +1
                    bindsym KP_Subtract exec --no-startup-id mocp -v -1
                    bindsym Add exec --no-startup-id mocp -v +1
                    bindsym Subtract exec --no-startup-id mocp -v -1
                    bindsym XF86AudioRaiseVolume exec --no-startup-id mocp -v +1
                    bindsym XF86AudioLowerVolume exec --no-startup-id mocp -v -1
                    
                    #bindsym s mode "music settings"
                    #bindsym Insert mode "music settings"

                    # GUI
                    bindsym --release Home exec --no-startup-id kitty mocp, mode "default"
                }

                mode "music settings" {
                    bindsym m mode "default"
                    bindsym q mode "default"
                    bindsym $mod+m mode "music"
                    bindsym Return mode "music"
                    bindsym Escape mode "music"
                    bindsym r exec --no-startup-id mocp -t repeat
                }

                bindsym $mod+m mode "music" fullscreen disable
            '';
        };
    };
}

