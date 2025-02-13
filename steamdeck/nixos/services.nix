{ config, ... }:

{
    services.btrfs.autoScrub.enable = true;

    services.openssh = {
        enable = true;
        settings = {
            PermitRootLogin = "no";
        };
    };
}
