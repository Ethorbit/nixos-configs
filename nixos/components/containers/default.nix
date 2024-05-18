{ config, pkgs, ... }:

{
    environment.systemPackages = with pkgs; [
        skopeo
    ];
}
