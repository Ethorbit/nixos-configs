{ config, ... }:

{
    age.secrets."nixos/restic/repos/nzc/pass" = { file = ../../../nixos/secrets/restic/repos/nzc/pass.age; };
    environment.etc."restic_pass" = {
        mode = "0600";
        user = config.ethorbit.users.primary.username;
        source = config.age.secrets."nixos/restic/repos/nzc/pass".path;
    };

    # Only the home directory (where the git repo is cloned to) will be backed up.
    # The actual server file backups must be made from an SFTP client's own actions
    services.restic = {
        backups = {
            "system" = {
                user = config.ethorbit.users.primary.username;
                initialize = true;
                paths = [ "/home/${config.ethorbit.users.primary.username}" ];
                repository = "/mnt/homenas/restic_backup.${config.ethorbit.system.profile.name}";
                passwordFile = "/etc/restic_pass";
                timerConfig = {
                    OnCalendar = "daily";
                    Persistent = true;
                };
            };
        };
    };
}
