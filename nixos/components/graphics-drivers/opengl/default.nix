{ lib, ... }:

{
    imports = [
        ../.
        ./before-24.11.nix
        ./24.11-or-later.nix
    ];

    environment = {
        variables = {
            VDPAU_DRIVER = lib.mkDefault "va_gl";
        };
    };
}
