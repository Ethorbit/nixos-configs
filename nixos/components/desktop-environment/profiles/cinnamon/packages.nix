{ config, pkgs, ... }:

{
    environment.systemPackages = with pkgs; [
        cinnamon.cinnamon-common
    ];
}
