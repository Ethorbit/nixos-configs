{ pkgs, lib, inputs, config, system, ... }:

let
    instances = config.nzc.instances;
    deployment = inputs.nzc-nix-docker.lib.mkDeployment {
        inherit pkgs system;
        instances = instances;
    };
in {
    imports = [
        ./instances
    ];

    options.ethorbit.nzc.nix-docker.cpu = with lib; let
        threadCount = 12; # CHANGE ME
        maxThreads = builtins.genList (x: x) threadCount;
    in {
        threadOf = mkOption {
            type = types.anything;    
            default = inputs.nzc-nix-docker.lib.allocation.threadOf;
        };

        threads = mkOption {
            type = types.attrsOf (types.listOf types.int);
            default = {
                all = maxThreads;
                game = maxThreads;
            };
        };
    };

    config.nzc.apps = deployment.apps;
}
