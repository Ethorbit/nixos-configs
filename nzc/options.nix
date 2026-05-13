{ lib, ... }:
{
    options.nzc = {
        instances = lib.mkOption {
            type = lib.types.attrsOf lib.types.anything;
            default = {};
            description = "nzc-nix-docker deployment instances";
        };

        apps = lib.mkOption {
            type = lib.types.attrsOf lib.types.anything;
            default = {};
            description = "Arion apps produced by mkDeployment";
        };
    };
}
