{ config, lib, ... }:

with lib;

{
    options.ethorbit.components.gaming.lutris.flatpak = {
        # Shouldn't be changed, only referenced.
        appName = mkOption {
            type = types.str;
            default = "net.lutris.Lutris";
        };
    };
}
