{ config, ... }:

{
    age.secrets."nixos/restic/repos/ai/pass" = { file = ../../nixos/secrets/restic/repos/ai/pass.age; };

    environment.etc."restic_ai_pass" = {
        mode = "0600";
        user = "root";
        source = config.age.secrets."nixos/restic/repos/ai/pass".path;
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
                repository = "/mnt/homenas/restic_repo";
                passwordFile = "/etc/restic_ai_pass";
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
        };
    };
}
