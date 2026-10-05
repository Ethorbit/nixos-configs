{ ... }:

{
    imports = [
        ./openssh.nix
    ];

    # systemd-resolved runs on port 53, which is what 
    # nZC's acme-dns needs to use. I have added resolv.conf 
    # entries in networking/ instead
    # services.resolved = lib.mkForce {
    #     enable = false;
    # };

    # Fixes containers not starting after reboot when bound to an interface
    systemd.services.docker = {
        after = [ "network-online.target" ];
        wants = [ "network-online.target" ];
    };
}
