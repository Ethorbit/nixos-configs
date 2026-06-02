{ config, lib, inputs, pkgs, ... }:

{
    options = {
        ethorbit.components.gamedev.packages = with lib; mkOption {
            default = inputs.nixpkgs-gamedev.legacyPackages.${pkgs.system};
        };
    };

    config = {
        environment.systemPackages = with config.ethorbit.components.gamedev.packages; [
            blender
        ];
    };
}
