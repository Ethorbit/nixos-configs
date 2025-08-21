{ config, ... }:

{
    fileSystems."/proc" = {
        device = "proc";
        fsType = "proc";
        options = [ "defaults" "nosuid" "nodev" "noexec" "hidepid=2" ];
    };

    fileSystems."/tmp" = {
        device = "tmpfs";
        fsType = "tmpfs";
        options = [ "defaults" "nosuid" "nodev" "noexec" ];
    };

    age.secrets."homenas/samba/users/nzc/creds" = { file = ../../homenas/secrets/samba/users/nzc/creds.age; };
    environment.etc."nascreds" = {
        mode = "0600";
        source = config.age.secrets."homenas/samba/users/nzc/creds".path;
    };
    fileSystems."/mnt/homenas" = {
        fsType = "cifs";
        device = "//${config.ethorbit.network.homenas.ip}/nzc";
        options = [ "credentials=/etc/nascreds" "uid=1000" "file_mode=0660" "dir_mode=0770" "forceuid" "forcegid" ];
    };
}
