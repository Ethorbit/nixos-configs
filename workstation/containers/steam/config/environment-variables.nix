{ config, ... }:

let
    cfg = config.ethorbit.workstation.container.steam;
in
{
    environment.sessionVariables = {
        DISPLAY = ":1";
        XDG_RUNTIME_DIR = "/run/user/${toString cfg.uid}";
        DBUS_SESSION_BUS_ADDRESS = "unix:path=/run/user/${toString cfg.uid}/bus";
        # We don't use this anymore
        #XAUTHORITY = "/home/${cfg.username}/.Xauthority";
        PULSE_SERVER = "/home/${cfg.username}/.pulse";
        SDL_AUDIODRIVER = "pulse";
        XTERM = "xterm-256color";
        PROTON_VERSION = "Proton 8.0"; # Satisfies protontricks
    };
}
