{ config, ... }:

{
    imports = [
        ../../../../services/sunshine
        ./security-wrapper.nix
        ./firewall-rules.nix
        ./packages.nix
    ];
}
