{ config, ... }:

{
    security.apparmor.enable = true;
    virtualisation.lxc.lxcfs.enable = true;
    virtualisation.docker.enable = true;

    services.openssh = {
        enable = true;
        ports = [ 2222 ]; # The dockerized nzc sshd server will use port 22, so change it.
        settings = {
            PasswordAuthentication = false;
            PermitRootLogin = "no";
        };
    };
}
