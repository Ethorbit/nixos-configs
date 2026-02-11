{ config, ... }:

let
    cfg = config.ethorbit.workstation.container.steam;
in
{
    imports = [
        ./users.nix
        ./networking.nix
        ./packages.nix
    ];

    environment.sessionVariables = {
        DISPLAY = ":1";
        XDG_RUNTIME_DIR = "/run/user/${toString cfg.uid}";
        DBUS_SESSION_BUS_ADDRESS = "unix:path=/run/user/${toString cfg.uid}/bus";
        XAUTHORITY = "/home/${cfg.username}/.Xauthority";
    };
}
