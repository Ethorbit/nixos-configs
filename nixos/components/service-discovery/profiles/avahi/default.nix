{ config, ... }:

{
    imports = [
        ./firewall.nix
    ];

    services.avahi = {
        enable = true;
        publish.userServices = true;
    };
}
