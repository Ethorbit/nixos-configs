{ config, ... }:

{
    age.secrets."nixos/restic/repos/workstation/pass" = { file = ../../../../nixos/secrets/restic/repos/workstation/pass.age; };
    age.secrets."nixos/restic/repos/main_os_storage/pass" = { file = ../../../../nixos/secrets/restic/repos/main_os_storage/pass.age; };

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

    services.restic = {
        backups = {
            "system" = {
                user = "root";
                initialize = true;
                paths = [ "/home" ];
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
        };
    };
}
