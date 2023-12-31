{ shared, inputs, lib, config, pkgs, ... }:

{
    imports = [
        ./hardware-configuration.nix
        ./bootloader.nix
        ./packages.nix
    ];

    nix.settings = {
        experimental-features = "nix-command flakes";
        auto-optimise-store = true;
    };

    environment.systemPackages = with pkgs; [
        grub2
        sudo
        lxcfs
        envsubst
        openssl
        lsof
    ];

    # Since NZC services run inside Docker,
    # the nzc user doesn't need access to anything other than Docker.
    # TODO: add SELinux to exclude unrelated actions.
    # TODO: configure iptables
    
    virtualisation.lxc.lxcfs.enable = true;
 
    services.openssh = {
        enable = true;
        passwordAuthentication = false;
        permitRootLogin = "no";
        ports = [ 2222 ]; # The dockerized nzc sshd server will use port 22, so change it.
    };

    age.secrets."users/nzc/password" = { file = ./secrets/users/nzc/pass.age; };
    users.users = {
        root = {
            shell = "/usr/sbin/nologin";
        };

        nzc = {
            isNormalUser = true;
            extraGroups = [ "sudo" ];
            initialPassword = config.age."nzc/users/nzc/password";
            openssh.authorizedKeys.keyFiles = [ "./authorizedKeys/id_ed25519.pub" ];
        };
    };
}
