{ ... }:

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
}
