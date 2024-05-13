# Multi-monitor workspace support added to i3!
# Simply setup monitor names for your system and then you can press Super + monitor # to manage workspaces for each monitor.
# If no monitor is configured, whatever monitor a workspace was opened on becomes the owner of said workspace. This can make navigation confusing.
#
#
# RANT AND UGLY CODE BELOW!! LEAVE NOW! ################################################################################
# If nix wasn't so complicated and so poorly documented, I could have made this implementation WAY BETTER and WAY SHORTER!
#
# If you are one to judge, then you should go fix up the documentation so that us non-nix people 
# can actually understand things and take advantage of the nix language.
#
# Surely some loops could shorten this, BUT HOW DO I USE LOOPS TO SHORTEN THIS??

{ config, lib, pkgs, ... }:

{
    options.ethorbit.home-manager.i3.workspace = with lib; {
        monitor = {
            one = mkOption { type = types.str; default = "none"; };
            two = mkOption { type = types.str; default = "none"; };
            three = mkOption { type = types.str; default = "none"; };
            four = mkOption { type = types.str; default = "none"; };
            five = mkOption { type = types.str; default = "none"; };
            six = mkOption { type = types.str; default = "none"; };
            seven = mkOption { type = types.str; default = "none"; };
            eight = mkOption { type = types.str; default = "none"; };
            nine = mkOption { type = types.str; default = "none"; };
        };
    };

    config = with lib; {
        home-manager.users.${config.ethorbit.users.primary.username} = {
            home.file.".config/i3/workspaces".text = ''
                set $i3_resurrect ${pkgs.i3-resurrect}/bin/i3-resurrect
                
                set $monitor_one "${config.ethorbit.home-manager.i3.workspace.monitor.one}"
                set $monitor_two "${config.ethorbit.home-manager.i3.workspace.monitor.two}"
                set $monitor_three "${config.ethorbit.home-manager.i3.workspace.monitor.three}"
                set $monitor_four "${config.ethorbit.home-manager.i3.workspace.monitor.four}"
                set $monitor_five "${config.ethorbit.home-manager.i3.workspace.monitor.five}"
                set $monitor_six "${config.ethorbit.home-manager.i3.workspace.monitor.six}"
                set $monitor_seven "${config.ethorbit.home-manager.i3.workspace.monitor.seven}"
                set $monitor_eight "${config.ethorbit.home-manager.i3.workspace.monitor.eight}"
                set $monitor_nine "${config.ethorbit.home-manager.i3.workspace.monitor.nine}"

                workspace a1 output $monitor_one
                workspace a2 output $monitor_one
                workspace a3 output $monitor_one
                workspace a4 output $monitor_one
                workspace a5 output $monitor_one
                workspace a6 output $monitor_one
                workspace a7 output $monitor_one
                workspace a8 output $monitor_one
                workspace a9 output $monitor_one

                workspace b1 output $monitor_two
                workspace b2 output $monitor_two
                workspace b3 output $monitor_two
                workspace b4 output $monitor_two
                workspace b5 output $monitor_two
                workspace b6 output $monitor_two
                workspace b7 output $monitor_two
                workspace b8 output $monitor_two
                workspace b9 output $monitor_two
            
                workspace c1 output $monitor_three
                workspace c2 output $monitor_three
                workspace c3 output $monitor_three
                workspace c4 output $monitor_three
                workspace c5 output $monitor_three
                workspace c6 output $monitor_three
                workspace c7 output $monitor_three
                workspace c8 output $monitor_three
                workspace c9 output $monitor_three

                workspace d1 output $monitor_four
                workspace d2 output $monitor_four
                workspace d3 output $monitor_four
                workspace d4 output $monitor_four
                workspace d5 output $monitor_four
                workspace d6 output $monitor_four
                workspace d7 output $monitor_four
                workspace d8 output $monitor_four
                workspace d9 output $monitor_four
            
                workspace e1 output $monitor_five
                workspace e2 output $monitor_five
                workspace e3 output $monitor_five
                workspace e4 output $monitor_five
                workspace e5 output $monitor_five
                workspace e6 output $monitor_five
                workspace e7 output $monitor_five
                workspace e8 output $monitor_five
                workspace e9 output $monitor_five
            
                workspace f1 output $monitor_six
                workspace f2 output $monitor_six
                workspace f3 output $monitor_six
                workspace f4 output $monitor_six
                workspace f5 output $monitor_six
                workspace f6 output $monitor_six
                workspace f7 output $monitor_six
                workspace f8 output $monitor_six
                workspace f9 output $monitor_six
            
                workspace g1 output $monitor_seven
                workspace g2 output $monitor_seven
                workspace g3 output $monitor_seven
                workspace g4 output $monitor_seven
                workspace g5 output $monitor_seven
                workspace g6 output $monitor_seven
                workspace g7 output $monitor_seven
                workspace g8 output $monitor_seven
                workspace g9 output $monitor_seven
            
                workspace h1 output $monitor_eight
                workspace h2 output $monitor_eight
                workspace h3 output $monitor_eight
                workspace h4 output $monitor_eight
                workspace h5 output $monitor_eight
                workspace h6 output $monitor_eight
                workspace h7 output $monitor_eight
                workspace h8 output $monitor_eight
                workspace h9 output $monitor_eight
            
                workspace i1 output $monitor_nine
                workspace i2 output $monitor_nine
                workspace i3 output $monitor_nine
                workspace i4 output $monitor_nine
                workspace i5 output $monitor_nine
                workspace i6 output $monitor_nine
                workspace i7 output $monitor_nine
                workspace i8 output $monitor_nine
                workspace i9 output $monitor_nine

                bindsym $mod+0 mode "all workspace monitors" fullscreen disable
                bindsym $mod+1 mode "workspace monitor 1" fullscreen disable
                bindsym $mod+2 mode "workspace monitor 2" fullscreen disable
                bindsym $mod+3 mode "workspace monitor 3" fullscreen disable
                bindsym $mod+4 mode "workspace monitor 4" fullscreen disable
                bindsym $mod+5 mode "workspace monitor 5" fullscreen disable
                bindsym $mod+6 mode "workspace monitor 6" fullscreen disable
                bindsym $mod+7 mode "workspace monitor 7" fullscreen disable
                bindsym $mod+8 mode "workspace monitor 8" fullscreen disable
                bindsym $mod+9 mode "workspace monitor 9" fullscreen disable

                exec i3-msg workspace a1

                mode "all workspace monitors" {
                    bindsym Escape mode "default"
                    bindsym Return mode "default"
                    bindsym s exec "for i in {1..9}; do $i3_resurrect save -w a''${i}; $i3_resurrect save -w b''${i}; $i3_resurrect save -w c''${i}; done"
                    bindsym r exec "for i in {1..9}; do $i3_resurrect restore -w a''${i}; $i3_resurrect restore -w b''${i}; $i3_resurrect restore -w c''${i}; done"
                }

                mode "workspace monitor 1" {
                    bindsym Escape mode "default"
                    bindsym Return mode "default"
                    bindsym $mod+space mode "workspace custom"
                    bindsym $mod+1 mode "workspace monitor 1"
                    bindsym f focus output $monitor_one
                    bindsym 1 workspace a1
                    bindsym 2 workspace a2
                    bindsym 3 workspace a3
                    bindsym 4 workspace a4
                    bindsym 5 workspace a5
                    bindsym 6 workspace a6
                    bindsym 7 workspace a7
                    bindsym 8 workspace a8
                    bindsym 9 workspace a9
                    bindsym Shift+1 move container to workspace a1
                    bindsym Shift+2 move container to workspace a2
                    bindsym Shift+3 move container to workspace a3
                    bindsym Shift+4 move container to workspace a4
                    bindsym Shift+5 move container to workspace a5
                    bindsym Shift+6 move container to workspace a6
                    bindsym Shift+7 move container to workspace a7
                    bindsym Shift+8 move container to workspace a8
                    bindsym Shift+9 move container to workspace a9
                    bindsym s mode "workspace save monitor 1"
                    bindsym r mode "workspace restore monitor 1"
                }
                
                mode "workspace save monitor 1" {
                    bindsym Escape mode "workspace monitor 1"
                    bindsym Return mode "workspace monitor 1"
                    bindsym a exec "for i in {1..9}; do $i3_resurrect save -w a''${i}; done"
                    bindsym 1 exec "$i3_resurrect save -w a1"
                    bindsym 2 exec "$i3_resurrect save -w a2"
                    bindsym 3 exec "$i3_resurrect save -w a3"
                    bindsym 4 exec "$i3_resurrect save -w a4"
                    bindsym 5 exec "$i3_resurrect save -w a5"
                    bindsym 6 exec "$i3_resurrect save -w a6"
                    bindsym 7 exec "$i3_resurrect save -w a7"
                    bindsym 8 exec "$i3_resurrect save -w a8"
                    bindsym 9 exec "$i3_resurrect save -w a9"
                }
                mode "workspace restore monitor 1" {
                    bindsym Escape mode "workspace monitor 1"
                    bindsym Return mode "workspace monitor 1"
                    bindsym a exec "for i in {1..9}; do $i3_resurrect restore -w a''${i}; done"
                    bindsym 1 exec "$i3_resurrect restore -w a1"
                    bindsym 2 exec "$i3_resurrect restore -w a2"
                    bindsym 3 exec "$i3_resurrect restore -w a3"
                    bindsym 4 exec "$i3_resurrect restore -w a4"
                    bindsym 5 exec "$i3_resurrect restore -w a5"
                    bindsym 6 exec "$i3_resurrect restore -w a6"
                    bindsym 7 exec "$i3_resurrect restore -w a7"
                    bindsym 8 exec "$i3_resurrect restore -w a8"
                    bindsym 9 exec "$i3_resurrect restore -w a9"
                }

                mode "workspace monitor 2" {
                    bindsym Escape mode "default"
                    bindsym Return mode "default"
                    bindsym $mod+space mode "workspace custom"
                    bindsym $mod+1 mode "workspace monitor 2"
                    bindsym f focus output $monitor_two
                    bindsym 1 workspace b1
                    bindsym 2 workspace b2
                    bindsym 3 workspace b3
                    bindsym 4 workspace b4
                    bindsym 5 workspace b5
                    bindsym 6 workspace b6
                    bindsym 7 workspace b7
                    bindsym 8 workspace b8
                    bindsym 9 workspace b9
                    bindsym Shift+1 move container to workspace b1
                    bindsym Shift+2 move container to workspace b2
                    bindsym Shift+3 move container to workspace b3
                    bindsym Shift+4 move container to workspace b4
                    bindsym Shift+5 move container to workspace b5
                    bindsym Shift+6 move container to workspace b6
                    bindsym Shift+7 move container to workspace b7
                    bindsym Shift+8 move container to workspace b8
                    bindsym Shift+9 move container to workspace b9
                    bindsym s mode "workspace save monitor 2"
                    bindsym r mode "workspace restore monitor 2"
                }
                
                mode "workspace save monitor 2" {
                    bindsym Escape mode "workspace monitor 2"
                    bindsym Return mode "workspace monitor 2"
                    bindsym a exec "for i in {1..9}; do $i3_resurrect save -w a''${i}; done"
                    bindsym 1 exec "$i3_resurrect save -w b1"
                    bindsym 2 exec "$i3_resurrect save -w b2"
                    bindsym 3 exec "$i3_resurrect save -w b3"
                    bindsym 4 exec "$i3_resurrect save -w b4"
                    bindsym 5 exec "$i3_resurrect save -w b5"
                    bindsym 6 exec "$i3_resurrect save -w b6"
                    bindsym 7 exec "$i3_resurrect save -w b7"
                    bindsym 8 exec "$i3_resurrect save -w b8"
                    bindsym 9 exec "$i3_resurrect save -w b9"
                }
                mode "workspace restore monitor 2" {
                    bindsym Escape mode "workspace monitor 2"
                    bindsym Return mode "workspace monitor 2"
                    bindsym a exec "for i in {1..9}; do $i3_resurrect restore -w a''${i}; done"
                    bindsym 1 exec "$i3_resurrect restore -w b1"
                    bindsym 2 exec "$i3_resurrect restore -w b2"
                    bindsym 3 exec "$i3_resurrect restore -w b3"
                    bindsym 4 exec "$i3_resurrect restore -w b4"
                    bindsym 5 exec "$i3_resurrect restore -w b5"
                    bindsym 6 exec "$i3_resurrect restore -w b6"
                    bindsym 7 exec "$i3_resurrect restore -w b7"
                    bindsym 8 exec "$i3_resurrect restore -w b8"
                    bindsym 9 exec "$i3_resurrect restore -w b9"
                }

                mode "workspace monitor 3" {
                    bindsym Escape mode "default"
                    bindsym Return mode "default"
                    bindsym $mod+space mode "workspace custom"
                    bindsym $mod+1 mode "workspace monitor 3"
                    bindsym f focus output $monitor_three
                    bindsym 1 workspace c1
                    bindsym 2 workspace c2
                    bindsym 3 workspace c3
                    bindsym 4 workspace c4
                    bindsym 5 workspace c5
                    bindsym 6 workspace c6
                    bindsym 7 workspace c7
                    bindsym 8 workspace c8
                    bindsym 9 workspace c9
                    bindsym Shift+1 move container to workspace c1
                    bindsym Shift+2 move container to workspace c2
                    bindsym Shift+3 move container to workspace c3
                    bindsym Shift+4 move container to workspace c4
                    bindsym Shift+5 move container to workspace c5
                    bindsym Shift+6 move container to workspace c6
                    bindsym Shift+7 move container to workspace c7
                    bindsym Shift+8 move container to workspace c8
                    bindsym Shift+9 move container to workspace c9
                    bindsym s mode "workspace save monitor 3"
                    bindsym r mode "workspace restore monitor 3"
                }
                
                mode "workspace save monitor 3" {
                    bindsym Escape mode "workspace monitor 3"
                    bindsym Return mode "workspace monitor 3"
                    bindsym a exec "for i in {1..9}; do $i3_resurrect save -w a''${i}; done"
                    bindsym 1 exec "$i3_resurrect save -w c1"
                    bindsym 2 exec "$i3_resurrect save -w c2"
                    bindsym 3 exec "$i3_resurrect save -w c3"
                    bindsym 4 exec "$i3_resurrect save -w c4"
                    bindsym 5 exec "$i3_resurrect save -w c5"
                    bindsym 6 exec "$i3_resurrect save -w c6"
                    bindsym 7 exec "$i3_resurrect save -w c7"
                    bindsym 8 exec "$i3_resurrect save -w c8"
                    bindsym 9 exec "$i3_resurrect save -w c9"
                }
                mode "workspace restore monitor 3" {
                    bindsym Escape mode "workspace monitor 3"
                    bindsym Return mode "workspace monitor 3"
                    bindsym a exec "for i in {1..9}; do $i3_resurrect restore -w a''${i}; done"
                    bindsym 1 exec "$i3_resurrect restore -w c1"
                    bindsym 2 exec "$i3_resurrect restore -w c2"
                    bindsym 3 exec "$i3_resurrect restore -w c3"
                    bindsym 4 exec "$i3_resurrect restore -w c4"
                    bindsym 5 exec "$i3_resurrect restore -w c5"
                    bindsym 6 exec "$i3_resurrect restore -w c6"
                    bindsym 7 exec "$i3_resurrect restore -w c7"
                    bindsym 8 exec "$i3_resurrect restore -w c8"
                    bindsym 9 exec "$i3_resurrect restore -w c9"
                }

                mode "workspace monitor 4" {
                    bindsym Escape mode "default"
                    bindsym Return mode "default"
                    bindsym $mod+space mode "workspace custom"
                    bindsym $mod+1 mode "workspace monitor 4"
                    bindsym f focus output $monitor_four
                    bindsym 1 workspace d1
                    bindsym 2 workspace d2
                    bindsym 3 workspace d3
                    bindsym 4 workspace d4
                    bindsym 5 workspace d5
                    bindsym 6 workspace d6
                    bindsym 7 workspace d7
                    bindsym 8 workspace d8
                    bindsym 9 workspace d9
                    bindsym Shift+1 move container to workspace d1
                    bindsym Shift+2 move container to workspace d2
                    bindsym Shift+3 move container to workspace d3
                    bindsym Shift+4 move container to workspace d4
                    bindsym Shift+5 move container to workspace d5
                    bindsym Shift+6 move container to workspace d6
                    bindsym Shift+7 move container to workspace d7
                    bindsym Shift+8 move container to workspace d8
                    bindsym Shift+9 move container to workspace d9
                    bindsym s mode "workspace save monitor 4"
                    bindsym r mode "workspace restore monitor 4"
                }
                
                mode "workspace save monitor 4" {
                    bindsym Escape mode "workspace monitor 4"
                    bindsym Return mode "workspace monitor 4"
                    bindsym a exec "for i in {1..9}; do $i3_resurrect save -w a''${i}; done"
                    bindsym 1 exec "$i3_resurrect save -w d1"
                    bindsym 2 exec "$i3_resurrect save -w d2"
                    bindsym 3 exec "$i3_resurrect save -w d3"
                    bindsym 4 exec "$i3_resurrect save -w d4"
                    bindsym 5 exec "$i3_resurrect save -w d5"
                    bindsym 6 exec "$i3_resurrect save -w d6"
                    bindsym 7 exec "$i3_resurrect save -w d7"
                    bindsym 8 exec "$i3_resurrect save -w d8"
                    bindsym 9 exec "$i3_resurrect save -w d9"
                }
                mode "workspace restore monitor 4" {
                    bindsym Escape mode "workspace monitor 4"
                    bindsym Return mode "workspace monitor 4"
                    bindsym a exec "for i in {1..9}; do $i3_resurrect restore -w a''${i}; done"
                    bindsym 1 exec "$i3_resurrect restore -w d1"
                    bindsym 2 exec "$i3_resurrect restore -w d2"
                    bindsym 3 exec "$i3_resurrect restore -w d3"
                    bindsym 4 exec "$i3_resurrect restore -w d4"
                    bindsym 5 exec "$i3_resurrect restore -w d5"
                    bindsym 6 exec "$i3_resurrect restore -w d6"
                    bindsym 7 exec "$i3_resurrect restore -w d7"
                    bindsym 8 exec "$i3_resurrect restore -w d8"
                    bindsym 9 exec "$i3_resurrect restore -w d9"
                }

                mode "workspace monitor 5" {
                    bindsym Escape mode "default"
                    bindsym Return mode "default"
                    bindsym $mod+space mode "workspace custom"
                    bindsym $mod+1 mode "workspace monitor 5"
                    bindsym f focus output $monitor_five
                    bindsym 1 workspace e1
                    bindsym 2 workspace e2
                    bindsym 3 workspace e3
                    bindsym 4 workspace e4
                    bindsym 5 workspace e5
                    bindsym 6 workspace e6
                    bindsym 7 workspace e7
                    bindsym 8 workspace e8
                    bindsym 9 workspace e9
                    bindsym Shift+1 move container to workspace e1
                    bindsym Shift+2 move container to workspace e2
                    bindsym Shift+3 move container to workspace e3
                    bindsym Shift+4 move container to workspace e4
                    bindsym Shift+5 move container to workspace e5
                    bindsym Shift+6 move container to workspace e6
                    bindsym Shift+7 move container to workspace e7
                    bindsym Shift+8 move container to workspace e8
                    bindsym Shift+9 move container to workspace e9
                    bindsym s mode "workspace save monitor 5"
                    bindsym r mode "workspace restore monitor 5"
                }
                
                mode "workspace save monitor 5" {
                    bindsym Escape mode "workspace monitor 5"
                    bindsym Return mode "workspace monitor 5"
                    bindsym a exec "for i in {1..9}; do $i3_resurrect save -w a''${i}; done"
                    bindsym 1 exec "$i3_resurrect save -w e1"
                    bindsym 2 exec "$i3_resurrect save -w e2"
                    bindsym 3 exec "$i3_resurrect save -w e3"
                    bindsym 4 exec "$i3_resurrect save -w e4"
                    bindsym 5 exec "$i3_resurrect save -w e5"
                    bindsym 6 exec "$i3_resurrect save -w e6"
                    bindsym 7 exec "$i3_resurrect save -w e7"
                    bindsym 8 exec "$i3_resurrect save -w e8"
                    bindsym 9 exec "$i3_resurrect save -w e9"
                }
                mode "workspace restore monitor 5" {
                    bindsym Escape mode "workspace monitor 5"
                    bindsym Return mode "workspace monitor 5"
                    bindsym a exec "for i in {1..9}; do $i3_resurrect restore -w a''${i}; done"
                    bindsym 1 exec "$i3_resurrect restore -w e1"
                    bindsym 2 exec "$i3_resurrect restore -w e2"
                    bindsym 3 exec "$i3_resurrect restore -w e3"
                    bindsym 4 exec "$i3_resurrect restore -w e4"
                    bindsym 5 exec "$i3_resurrect restore -w e5"
                    bindsym 6 exec "$i3_resurrect restore -w e6"
                    bindsym 7 exec "$i3_resurrect restore -w e7"
                    bindsym 8 exec "$i3_resurrect restore -w e8"
                    bindsym 9 exec "$i3_resurrect restore -w e9"
                }

                mode "workspace monitor 6" {
                    bindsym Escape mode "default"
                    bindsym Return mode "default"
                    bindsym $mod+space mode "workspace custom"
                    bindsym $mod+1 mode "workspace monitor 6"
                    bindsym f focus output $monitor_six
                    bindsym 1 workspace f1
                    bindsym 2 workspace f2
                    bindsym 3 workspace f3
                    bindsym 4 workspace f4
                    bindsym 5 workspace f5
                    bindsym 6 workspace f6
                    bindsym 7 workspace f7
                    bindsym 8 workspace f8
                    bindsym 9 workspace f9
                    bindsym Shift+1 move container to workspace f1
                    bindsym Shift+2 move container to workspace f2
                    bindsym Shift+3 move container to workspace f3
                    bindsym Shift+4 move container to workspace f4
                    bindsym Shift+5 move container to workspace f5
                    bindsym Shift+6 move container to workspace f6
                    bindsym Shift+7 move container to workspace f7
                    bindsym Shift+8 move container to workspace f8
                    bindsym Shift+9 move container to workspace f9
                    bindsym s mode "workspace save monitor 6"
                    bindsym r mode "workspace restore monitor 6"
                }
                
                mode "workspace save monitor 6" {
                    bindsym Escape mode "workspace monitor 6"
                    bindsym Return mode "workspace monitor 6"
                    bindsym a exec "for i in {1..9}; do $i3_resurrect save -w a''${i}; done"
                    bindsym 1 exec "$i3_resurrect save -w f1"
                    bindsym 2 exec "$i3_resurrect save -w f2"
                    bindsym 3 exec "$i3_resurrect save -w f3"
                    bindsym 4 exec "$i3_resurrect save -w f4"
                    bindsym 5 exec "$i3_resurrect save -w f5"
                    bindsym 6 exec "$i3_resurrect save -w f6"
                    bindsym 7 exec "$i3_resurrect save -w f7"
                    bindsym 8 exec "$i3_resurrect save -w f8"
                    bindsym 9 exec "$i3_resurrect save -w f9"
                }
                mode "workspace restore monitor 6" {
                    bindsym Escape mode "workspace monitor 6"
                    bindsym Return mode "workspace monitor 6"
                    bindsym a exec "for i in {1..9}; do $i3_resurrect restore -w a''${i}; done"
                    bindsym 1 exec "$i3_resurrect restore -w f1"
                    bindsym 2 exec "$i3_resurrect restore -w f2"
                    bindsym 3 exec "$i3_resurrect restore -w f3"
                    bindsym 4 exec "$i3_resurrect restore -w f4"
                    bindsym 5 exec "$i3_resurrect restore -w f5"
                    bindsym 6 exec "$i3_resurrect restore -w f6"
                    bindsym 7 exec "$i3_resurrect restore -w f7"
                    bindsym 8 exec "$i3_resurrect restore -w f8"
                    bindsym 9 exec "$i3_resurrect restore -w f9"
                }

                mode "workspace monitor 7" {
                    bindsym Escape mode "default"
                    bindsym Return mode "default"
                    bindsym $mod+space mode "workspace custom"
                    bindsym $mod+1 mode "workspace monitor 7"
                    bindsym f focus output $monitor_seven
                    bindsym 1 workspace g1
                    bindsym 2 workspace g2
                    bindsym 3 workspace g3
                    bindsym 4 workspace g4
                    bindsym 5 workspace g5
                    bindsym 6 workspace g6
                    bindsym 7 workspace g7
                    bindsym 8 workspace g8
                    bindsym 9 workspace g9
                    bindsym Shift+1 move container to workspace g1
                    bindsym Shift+2 move container to workspace g2
                    bindsym Shift+3 move container to workspace g3
                    bindsym Shift+4 move container to workspace g4
                    bindsym Shift+5 move container to workspace g5
                    bindsym Shift+6 move container to workspace g6
                    bindsym Shift+7 move container to workspace g7
                    bindsym Shift+8 move container to workspace g8
                    bindsym Shift+9 move container to workspace g9
                    bindsym s mode "workspace save monitor 7"
                    bindsym r mode "workspace restore monitor 7"
                }
                
                mode "workspace save monitor 7" {
                    bindsym Escape mode "workspace monitor 7"
                    bindsym Return mode "workspace monitor 7"
                    bindsym a exec "for i in {1..9}; do $i3_resurrect save -w a''${i}; done"
                    bindsym 1 exec "$i3_resurrect save -w g1"
                    bindsym 2 exec "$i3_resurrect save -w g2"
                    bindsym 3 exec "$i3_resurrect save -w g3"
                    bindsym 4 exec "$i3_resurrect save -w g4"
                    bindsym 5 exec "$i3_resurrect save -w g5"
                    bindsym 6 exec "$i3_resurrect save -w g6"
                    bindsym 7 exec "$i3_resurrect save -w g7"
                    bindsym 8 exec "$i3_resurrect save -w g8"
                    bindsym 9 exec "$i3_resurrect save -w g9"
                }
                mode "workspace restore monitor 7" {
                    bindsym Escape mode "workspace monitor 7"
                    bindsym Return mode "workspace monitor 7"
                    bindsym a exec "for i in {1..9}; do $i3_resurrect restore -w a''${i}; done"
                    bindsym 1 exec "$i3_resurrect restore -w g1"
                    bindsym 2 exec "$i3_resurrect restore -w g2"
                    bindsym 3 exec "$i3_resurrect restore -w g3"
                    bindsym 4 exec "$i3_resurrect restore -w g4"
                    bindsym 5 exec "$i3_resurrect restore -w g5"
                    bindsym 6 exec "$i3_resurrect restore -w g6"
                    bindsym 7 exec "$i3_resurrect restore -w g7"
                    bindsym 8 exec "$i3_resurrect restore -w g8"
                    bindsym 9 exec "$i3_resurrect restore -w g9"
                }

                mode "workspace monitor 8" {
                    bindsym Escape mode "default"
                    bindsym Return mode "default"
                    bindsym $mod+space mode "workspace custom"
                    bindsym $mod+1 mode "workspace monitor 8"
                    bindsym f focus output $monitor_eight
                    bindsym 1 workspace h1
                    bindsym 2 workspace h2
                    bindsym 3 workspace h3
                    bindsym 4 workspace h4
                    bindsym 5 workspace h5
                    bindsym 6 workspace h6
                    bindsym 7 workspace h7
                    bindsym 8 workspace h8
                    bindsym 9 workspace h9
                    bindsym Shift+1 move container to workspace h1
                    bindsym Shift+2 move container to workspace h2
                    bindsym Shift+3 move container to workspace h3
                    bindsym Shift+4 move container to workspace h4
                    bindsym Shift+5 move container to workspace h5
                    bindsym Shift+6 move container to workspace h6
                    bindsym Shift+7 move container to workspace h7
                    bindsym Shift+8 move container to workspace h8
                    bindsym Shift+9 move container to workspace h9
                    bindsym s mode "workspace save monitor 8"
                    bindsym r mode "workspace restore monitor 8"
                }
                
                mode "workspace save monitor 8" {
                    bindsym Escape mode "workspace monitor 8"
                    bindsym Return mode "workspace monitor 8"
                    bindsym a exec "for i in {1..9}; do $i3_resurrect save -w a''${i}; done"
                    bindsym 1 exec "$i3_resurrect save -w h1"
                    bindsym 2 exec "$i3_resurrect save -w h2"
                    bindsym 3 exec "$i3_resurrect save -w h3"
                    bindsym 4 exec "$i3_resurrect save -w h4"
                    bindsym 5 exec "$i3_resurrect save -w h5"
                    bindsym 6 exec "$i3_resurrect save -w h6"
                    bindsym 7 exec "$i3_resurrect save -w h7"
                    bindsym 8 exec "$i3_resurrect save -w h8"
                    bindsym 9 exec "$i3_resurrect save -w h9"
                }
                mode "workspace restore monitor 8" {
                    bindsym Escape mode "workspace monitor 8"
                    bindsym Return mode "workspace monitor 8"
                    bindsym a exec "for i in {1..9}; do $i3_resurrect restore -w a''${i}; done"
                    bindsym 1 exec "$i3_resurrect restore -w h1"
                    bindsym 2 exec "$i3_resurrect restore -w h2"
                    bindsym 3 exec "$i3_resurrect restore -w h3"
                    bindsym 4 exec "$i3_resurrect restore -w h4"
                    bindsym 5 exec "$i3_resurrect restore -w h5"
                    bindsym 6 exec "$i3_resurrect restore -w h6"
                    bindsym 7 exec "$i3_resurrect restore -w h7"
                    bindsym 8 exec "$i3_resurrect restore -w h8"
                    bindsym 9 exec "$i3_resurrect restore -w h9"
                }

                mode "workspace monitor 9" {
                    bindsym Escape mode "default"
                    bindsym Return mode "default"
                    bindsym $mod+space mode "workspace custom"
                    bindsym $mod+1 mode "workspace monitor 9"
                    bindsym f focus output $monitor_nine
                    bindsym 1 workspace i1
                    bindsym 2 workspace i2
                    bindsym 3 workspace i3
                    bindsym 4 workspace i4
                    bindsym 5 workspace i5
                    bindsym 6 workspace i6
                    bindsym 7 workspace i7
                    bindsym 8 workspace i8
                    bindsym 9 workspace i9
                    bindsym Shift+1 move container to workspace i1
                    bindsym Shift+2 move container to workspace i2
                    bindsym Shift+3 move container to workspace i3
                    bindsym Shift+4 move container to workspace i4
                    bindsym Shift+5 move container to workspace i5
                    bindsym Shift+6 move container to workspace i6
                    bindsym Shift+7 move container to workspace i7
                    bindsym Shift+8 move container to workspace i8
                    bindsym Shift+9 move container to workspace i9
                    bindsym s mode "workspace save monitor 9"
                    bindsym r mode "workspace restore monitor 9"
                }
                
                mode "workspace save monitor 9" {
                    bindsym Escape mode "workspace monitor 9"
                    bindsym Return mode "workspace monitor 9"
                    bindsym a exec "for i in {1..9}; do $i3_resurrect save -w a''${i}; done"
                    bindsym 1 exec "$i3_resurrect save -w i1"
                    bindsym 2 exec "$i3_resurrect save -w i2"
                    bindsym 3 exec "$i3_resurrect save -w i3"
                    bindsym 4 exec "$i3_resurrect save -w i4"
                    bindsym 5 exec "$i3_resurrect save -w i5"
                    bindsym 6 exec "$i3_resurrect save -w i6"
                    bindsym 7 exec "$i3_resurrect save -w i7"
                    bindsym 8 exec "$i3_resurrect save -w i8"
                    bindsym 9 exec "$i3_resurrect save -w i9"
                }
                mode "workspace restore monitor 9" {
                    bindsym Escape mode "workspace monitor 9"
                    bindsym Return mode "workspace monitor 9"
                    bindsym a exec "for i in {1..9}; do $i3_resurrect restore -w a''${i}; done"
                    bindsym 1 exec "$i3_resurrect restore -w i1"
                    bindsym 2 exec "$i3_resurrect restore -w i2"
                    bindsym 3 exec "$i3_resurrect restore -w i3"
                    bindsym 4 exec "$i3_resurrect restore -w i4"
                    bindsym 5 exec "$i3_resurrect restore -w i5"
                    bindsym 6 exec "$i3_resurrect restore -w i6"
                    bindsym 7 exec "$i3_resurrect restore -w i7"
                    bindsym 8 exec "$i3_resurrect restore -w i8"
                    bindsym 9 exec "$i3_resurrect restore -w i9"
                }
            '';
        };
    };
}
