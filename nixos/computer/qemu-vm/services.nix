{ config, pkgs, ... }:

{
    services.xserver.videoDrivers = [ "qxl" ];
}
