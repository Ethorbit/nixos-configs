# X11 Cinnamon desktop environment

{ config, ... }:

{
    imports = [
        ../../../nixos/components/display-server/profiles/xserver
        ../../../nixos/components/display-manager/profiles/lightdm
        ../../../nixos/components/desktop-environment/profiles/cinnamon
    ];

    services.xserver = {
        displayManager = {
            defaultSession = "cinnamon";
            autoLogin.user = config.ethorbit.users.primary.username;
        };
    };
}
