{ lib, ... }:

with lib;

{
    options.ethorbit.components.gaming.steam.native = {
        extraEnvironment = mkOption {
            type = types.attrsOf types.anything;
            default = {};
            example = {
                key = "value";
            };
        };

        extraPackages = mkOption {
            type = types.listOf types.package;
            default = [];
        };
    };
}
