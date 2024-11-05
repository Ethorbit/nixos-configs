{ config, pkgs, ... }:

{
    age.secrets."nixos/restic/repos/workstation/pass" = { file = ../../../nixos/secrets/restic/repos/workstation/pass.age; };
    age.secrets."nixos/restic/repos/main_os_storage/pass" = { file = ../../../nixos/secrets/restic/repos/main_os_storage/pass.age; };
    age.secrets."nixos/restic/repos/android_pixel_primary/pass" = { file = ../../../nixos/secrets/restic/repos/android_pixel_primary/pass.age; };
    age.secrets."nixos/restic/repos/android_pixel_high/pass" = { file = ../../../nixos/secrets/restic/repos/android_pixel_high/pass.age; };
    age.secrets."nixos/restic/repos/android_pixel_dark/pass" = { file = ../../../nixos/secrets/restic/repos/android_pixel_dark/pass.age; };

    environment.etc."restic_workstation_pass" = {
        mode = "0600";
        user = "root";
        source = config.age.secrets."nixos/restic/repos/workstation/pass".path;
    };

    environment.etc."restic_main_os_storage_pass" = {
        mode = "0600";
        user = "root";
        source = config.age.secrets."nixos/restic/repos/main_os_storage/pass".path;
    };

    environment.etc."restic_games_pass" = {
        mode = "0600";
        user = config.ethorbit.users.primary.username;
        text = "games";
    };

    environment.etc."restic_android_pixel_primary_pass" = {
        mode = "0600";
        user = config.ethorbit.users.primary.username;
        source = config.age.secrets."nixos/restic/repos/android_pixel_primary/pass".path;
    };

    environment.etc."restic_android_pixel_high_pass" = {
        mode = "0600";
        user = config.ethorbit.users.primary.username;
        source = config.age.secrets."nixos/restic/repos/android_pixel_high/pass".path;
    };

    environment.etc."restic_android_pixel_dark_pass" = {
        mode = "0600";
        user = config.ethorbit.users.primary.username;
        source = config.age.secrets."nixos/restic/repos/android_pixel_dark/pass".path;
    };

    services.restic = {
        backups = {
            "system" = {
                user = "root";
                initialize = true;
                paths = [ "/" ];
                # Exclude large reproducible / useless data and common mount locations
                exclude = [
                    "/nix"
                    "/media"
                    "/mnt"
                    "/var/lib/nixos-containers/**/nix/**"
                    "/var/lib/nixos-containers/**/media/**"
                    "/var/lib/nixos-containers/**/mnt/**"
                    "/**/docker/overlay2/**"
                    "/**/flatpak-module/boot/**"
                ];
                repository = "/mnt/homenas/Restic_Backups/workstation";
                passwordFile = "/etc/restic_workstation_pass";
                timerConfig = {
                    OnCalendar = "daily";
                    Persistent = true;
                };
                extraBackupArgs = [
                    "--compression=max"
                    "--verbose=2"
                    "--one-file-system=true"
                ];
            };

            "storage" = {
                user = "root";
                initialize = true;
                paths = [ "/mnt/storage" ];
                repository = "/mnt/homenas/Restic_Backups/main_os_storage";
                passwordFile = "/etc/restic_main_os_storage_pass";
                timerConfig = {
                    OnCalendar = "weekly";
                    Persistent = true;
                };
                extraBackupArgs = [
                    "--compression=max"
                    "--verbose=2"
                    "--one-file-system=true"
                ];
                exclude = [
                    "/mnt/storage/.Trash-*/"
                ];
            };

            "games" = {
                user = config.ethorbit.users.primary.username;
                initialize = true;
                repository = "/mnt/homenas/Restic_Backups/linux_games";
                passwordFile = "/etc/restic_games_pass";
                timerConfig = {
                    OnCalendar = "daily";
                    Persistent = true;
                };
                # Only backup game saves and files with common
                # config file extensions to save on space
                dynamicFilesFrom = ''
                    (find /mnt/games -type d -name "My Games" ;\
                    find /mnt/games -type d -name "*Saves*" ;\
                    find /mnt/games -type f -size -50M \
                        -regex '.*\.\(cfg\|txt\|json\|ini\|lua\|db\)$')
                '';
                exclude = [
                    "/mnt/games/.Trash-*/"
                ];
                extraBackupArgs = [
                    "--compression=max"
                    "--verbose=2"
                    "--one-file-system=true"
                ];
            };

            # Below expect SSHFS mounts in the user's own mnt directory and won't auto backup.
            # this system has scripts to automate mount creation and service start
            "android-pixel-primary" = {
                user = config.ethorbit.users.primary.username;
                initialize = true;
                paths = [ "/home/${config.ethorbit.users.primary.username}/mnt/android_pixel_primary" ];
                repository = "/mnt/homenas/Restic_Backups/android_pixel_primary";
                passwordFile = "/etc/restic_android_pixel_primary_pass";
                # Exclude the stuff that is synced with scripts
                exclude = [
                    "/home/${config.ethorbit.users.primary.username}/mnt/android_pixel_primary/Music"
                ];
                extraBackupArgs = [
                    "--compression=max"
                    "--verbose=2"
                    "--one-file-system=true"
                ];
            };

            "android-pixel-high" = {
                user = config.ethorbit.users.primary.username;
                initialize = true;
                paths = [ "/home/${config.ethorbit.users.primary.username}/mnt/android_pixel_high" ];
                repository = "/mnt/homenas/Restic_Backups/android_pixel_high";
                passwordFile = "/etc/restic_android_pixel_high_pass";
                extraBackupArgs = [
                    "--compression=max"
                    "--verbose=2"
                    "--one-file-system=true"
                ];
            };

            "android-pixel-dark" = {
                user = config.ethorbit.users.primary.username;
                initialize = true;
                paths = [ "/home/${config.ethorbit.users.primary.username}/mnt/android_pixel_dark" ];
                repository = "/mnt/homenas/Restic_Backups/android_pixel_dark";
                passwordFile = "/etc/restic_android_pixel_dark_pass";
                extraBackupArgs = [
                    "--compression=max"
                    "--verbose=2"
                    "--one-file-system=true"
                ];
            };
        };
    };

}
