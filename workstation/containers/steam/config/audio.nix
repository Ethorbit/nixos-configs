{ config, lib, ... }:

let
    cfg = config.ethorbit.workstation.container.steam;
in
{
    services.pulseaudio = {
        enable = lib.mkForce false;
        extraClientConf = ''
            default-server = unix:/home/${cfg.username}/.pulse
            enable-shm = no
            autospawn = no
        '';
    };
}
