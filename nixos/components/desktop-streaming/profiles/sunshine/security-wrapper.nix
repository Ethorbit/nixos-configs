# Sunshine needs CAP_SYS_ADMIN to run correctly.

{ config, pkgs, ... }:

{
    security.wrappers.sunshine = {
        owner = "root";
        group = "root";
        capabilities = "cap_sys_admin+p";
        source = "${pkgs.sunshine}/bin/sunshine";
    };
}
