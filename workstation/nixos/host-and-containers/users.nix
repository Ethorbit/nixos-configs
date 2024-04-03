{ config, pkgs, ... }:

{
    users = {
        mutableUsers = false;

        # There's no reason for root; workstation user uses sudo
        # and containers don't use any form of root for security.
        users."root" = {
            shell = ''${pkgs.shadow}/bin/nologin'';
            hashedPassword = "!";
        };
    };
}
