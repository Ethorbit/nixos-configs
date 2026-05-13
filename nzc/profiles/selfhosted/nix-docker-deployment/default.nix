{ pkgs, inputs, config, system, ... }:

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

    config.nzc.apps = deployment.apps;
}
