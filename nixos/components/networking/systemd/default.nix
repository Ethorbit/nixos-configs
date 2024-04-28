# Basically, 'networking' was added BEFORE 'systemd.network'
# So the idea here is that if you want systemd networking, 
# we should FORCE all conflicting stuff OFF.
#
# I think this setup is considered 'experimental' currently
# however I've had zero issues with it so far.
#
# Also there is so much more flexibility with systemd networking
# which is why I think it should be easy to fully enable it.
#

{ config, lib, ... }:

with lib;
{
    systemd.network = {
        enable = true;

        # I've had issues with this halting rebuilds when using
        # an ethernet bridge. nixos.org says it's unnecessary
        # so I'm going to disable it by default.
        wait-online.enable = mkDefault false;
    };

    networking = {
        useNetworkd = mkForce true;
        dhcpcd.enable = mkForce false;
        useDHCP = mkForce false;
        useHostResolvConf = mkForce false;
    };

    services.resolved.enable = mkForce true;
}
