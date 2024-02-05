{ config, ... }:

{
    imports = [
        ../..
    ];

    services.xserver.enable = true;
}
