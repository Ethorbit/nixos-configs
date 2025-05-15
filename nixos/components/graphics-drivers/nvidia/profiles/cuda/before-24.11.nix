{ config, lib, pkgs, ... }:

{
    # The option `hardware.opengl.extraPackages' has been renamed to `hardware.graphics.extraPackages'.
    config = lib.mkIf (config.system.nixos.release < "24.11") {
        hardware.opengl.extraPackages = [ pkgs.cudaPackages.cudatoolkit ];
    };
}
