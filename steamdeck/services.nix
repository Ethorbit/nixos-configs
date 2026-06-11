{ config, pkgs, ... }:

{
    systemd.user.services."steamos-force-desktop-mode" = {
        description = "Set SteamOS session to Desktop at startup to avoid Steam auto-updates";
        serviceConfig.Type = "oneshot";
        after = [ "default.target" ];
        before = [ "graphical-session.target" ];
        wantedBy = [ "default.target" ];
        script = let
            steamosctl = "/run/current-system/sw/bin/steamosctl";
        in ''
            ${steamosctl} set-default-login-mode desktop
        '';
    };

    services.btrfs.autoScrub.enable = true;

    services.openssh = {
        enable = true;
        settings = {
            PermitRootLogin = "no";
        };
    };
}
