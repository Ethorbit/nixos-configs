{ config, pkgs, ... }:

{
    nixpkgs.config.cudaSupport = true;

    environment.systemPackages = with pkgs; [
        cudaPackages.cudatoolkit
    ];
}
