{ config, lib, ... }:

with lib;

{
    options.ethorbit.components.gaming.steam.flatpak = {
        appNames = {
            "steam" = mkOption {
                type = types.str;
                default = "com.valvesoftware.Steam";
            };
        };
    };
}
