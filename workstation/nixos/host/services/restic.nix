{ config, pkgs, ... }:

{
    age.secrets."nixos/restic/repos/workstation/pass" = { file = ../../../../nixos/secrets/restic/repos/workstation/pass.age; };
    age.secrets."nixos/restic/repos/main_os_storage/pass" = { file = ../../../../nixos/secrets/restic/repos/main_os_storage/pass.age; };
    age.secrets."nixos/restic/repos/android_pixel_u0/pass" = { file = ../../../../nixos/secrets/restic/repos/android_pixel_u0/pass.age; };
    age.secrets."nixos/restic/repos/android_pixel_u12/pass" = { file = ../../../../nixos/secrets/restic/repos/android_pixel_u12/pass.age; };
    age.secrets."nixos/restic/repos/android_pixel_u16/pass" = { file = ../../../../nixos/secrets/restic/repos/android_pixel_u16/pass.age; };

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

    environment.etc."restic_android_pixel_u0_pass" = {
        mode = "0600";
        user = config.ethorbit.users.primary.username;
        source = config.age.secrets."nixos/restic/repos/android_pixel_u0/pass".path;
    };

    environment.etc."restic_android_pixel_u12_pass" = {
        mode = "0600";
        user = config.ethorbit.users.primary.username;
        source = config.age.secrets."nixos/restic/repos/android_pixel_u12/pass".path;
    };

    environment.etc."restic_android_pixel_u16_pass" = {
        mode = "0600";
        user = config.ethorbit.users.primary.username;
        source = config.age.secrets."nixos/restic/repos/android_pixel_u16/pass".path;
    };

    services.restic = {
        backups = {
            "system" = {
                user = "root";
                initialize = true;
                paths = [ "/" ];
                # Exclude large reproducible / useless data
                exclude = [
                    "/nix"
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
            };

            # Below expect SSHFS mounts in the user's own mnt directory and won't auto backup.
            # this system has scripts to automate mount creation and service start
            "android-pixel-u0" = {
                user = config.ethorbit.users.primary.username;
                initialize = true;
                paths = [ "/home/${config.ethorbit.users.primary.username}/mnt/android_pixel_u0" ];
                repository = "/mnt/homenas/Restic_Backups/android_pixel_u0";
                passwordFile = "/etc/restic_android_pixel_u0_pass";
                # Exclude the stuff that is synced with scripts
                exclude = [
                    "/home/${config.ethorbit.users.primary.username}/mnt/android_pixel_u0/Music"
                ];
                extraBackupArgs = [
                    "--compression=max"
                    "--verbose=2"
                    "--one-file-system=true"
                ];
            };

            "android-pixel-u12" = {
                user = config.ethorbit.users.primary.username;
                initialize = true;
                paths = [ "/home/${config.ethorbit.users.primary.username}/mnt/android_pixel_u12" ];
                repository = "/mnt/homenas/Restic_Backups/android_pixel_u12";
                passwordFile = "/etc/restic_android_pixel_u12_pass";
                extraBackupArgs = [
                    "--compression=max"
                    "--verbose=2"
                    "--one-file-system=true"
                ];
            };

            "android-pixel-u16" = {
                user = config.ethorbit.users.primary.username;
                initialize = true;
                paths = [ "/home/${config.ethorbit.users.primary.username}/mnt/android_pixel_u16" ];
                repository = "/mnt/homenas/Restic_Backups/android_pixel_u16";
                passwordFile = "/etc/restic_android_pixel_u16_pass";
                extraBackupArgs = [
                    "--compression=max"
                    "--verbose=2"
                    "--one-file-system=true"
                ];
            };
        };
    };

}
