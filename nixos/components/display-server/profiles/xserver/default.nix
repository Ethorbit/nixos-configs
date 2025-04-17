{ config, ... }:

{
    imports = [
        ../..
        ./redshift.nix
    ];

    services.xserver = {
        enable = true;
        exportConfiguration = true;
    };
}
