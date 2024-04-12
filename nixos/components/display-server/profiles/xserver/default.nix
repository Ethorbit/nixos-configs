{ config, ... }:

{
    imports = [
        ../..
    ];

    services.xserver = {
        enable = true;
        exportConfiguration = true;
    };
}
