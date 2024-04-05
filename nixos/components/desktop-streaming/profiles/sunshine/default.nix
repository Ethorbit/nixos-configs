{ config, ... }:

{
    imports = [
        ../../../../services/sunshine
        ./firewall-rules.nix
        ./packages.nix
    ];
}
