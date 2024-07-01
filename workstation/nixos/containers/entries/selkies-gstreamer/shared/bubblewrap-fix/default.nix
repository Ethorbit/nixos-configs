# /proc needs to be bind-mounted to /newroot when using bubblewrap in systemd nspawn containers
# If we don't set that up, we will get this error:
# bwrap: Can't mount proc on /newroot/proc: Operation not permitted

{ config, ... }:

{
    fileSystems."/newroot" = {
        device = "/proc";
        options = [ "bind" ];
    };
}
