{ config, ... }

{
    imports = [
        ./firewall.nix
    ];

    networking.usePredictableInterfaceNames = false;
}
