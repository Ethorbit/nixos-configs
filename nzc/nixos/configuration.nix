{ config, pkgs, ... }:

{
    imports = [
        ./hardware-configuration.nix
        ./bootloader.nix
        ./packages.nix
        ./users.nix
    ];

    nix.settings = {
        auto-optimise-store = true;
    };

    nix.extraOptions = ''
        experimental-features = nix-command flakes
    '';

    # TODO: configure iptables
    security.apparmor.enable = true;
    virtualisation.lxc.lxcfs.enable = true;
 
    services.openssh = {
        enable = true;
        ports = [ 2222 ]; # The dockerized nzc sshd server will use port 22, so change it.
        settings = {
            PasswordAuthentication = false;
            PermitRootLogin = "no";
        };
    };
}
