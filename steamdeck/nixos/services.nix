{ config, ... }:

{
    # Set SteamOS session preference to Desktop at startup
    # This way we're not dependent on Steam
    # to use the system.
    #
    # This is useful if Steam decides to auto-update and take ages
    systemd.services."steamos-force-desktop-mode" = {
        wantedBy = [ "graphical.target" ];
        before = [ "greetd.service" ];
        script = ''
            home_dir=$(${pkgs.getent}/bin/getent passwd "${config.jovian.steam.user}" | cut -d: -f6)
            echo "${config.jovian.steam.desktopSession}" > "$home_dir/.local/state/steamos-session-select"
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
