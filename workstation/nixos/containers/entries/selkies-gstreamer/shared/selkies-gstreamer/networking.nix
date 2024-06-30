{ config, lib, ... }:

{
    networking.firewall.enable = lib.mkForce false;
}
