{ config, ... }:

{
    imports = [
        ./git-clone.nix
        ./restic.nix
        ./openssh.nix
    ];

    # systemd-resolved runs on port 53, which is what 
    # nZC's acme-dns needs to use. I have added resolv.conf 
    # entries in networking/ instead
    services.resolved = {
        enable = false;
    };
}
