{ config, ... }

{
    security.apparmor.enable = true;
    virtualisation.lxc.lxcfs.enable = true;
    virtualisation.docker.enable = true;
}
