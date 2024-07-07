{ config, ... }:

{
    age.secrets."homenas/samba/users/videos/creds" = { file = ../../../../../../../../homenas/nixos/secrets/samba/users/videos/creds.age; };

    environment.etc."nascreds_videos" = {
        mode = "0600";
        source = config.age.secrets."homenas/samba/users/videos/creds".path;
    };

    fileSystems."/mnt/homenas_videos" = {
        fsType = "cifs";
        device = "//${config.ethorbit.network.homenas.ip}/videos";
        options = [
            "credentials=/etc/nascreds_videos"
            "uid=${toString config.users.users.${config.ethorbit.users.primary.username}.uid}"
            "gid=${toString config.users.groups.${config.ethorbit.users.primary.username}.gid}"
            "file_mode=0660"
            "dir_mode=0770"
            "forceuid"
            "forcegid"
        ];
    };
}
