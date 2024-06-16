{ config, pkgs, ... }:

with pkgs;
{
    environment.systemPackages = [
        ungoogled-chromium
    ];
}
