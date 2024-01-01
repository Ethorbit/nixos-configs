{ config, pkgs, ... }:

{
    imports = [
        ./hardware-configuration.nix
        ./bootloader.nix
        ./packages
        ./users.nix
    ];

    system.stateVersion = "23.11";
    
    nix.settings = {
        auto-optimise-store = true;
    };

    nix.extraOptions = ''
        experimental-features = nix-command flakes
    '';

    # TODO: configure iptables
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
