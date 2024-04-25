{ config, pkgs, ... }:

{
    environment.systemPackages = with pkgs; [
        docker-compose
    ];
}
