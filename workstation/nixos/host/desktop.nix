{ config, ... }:

{
    imports = [
        ../../../nixos/components/display-server/profiles/xserver
        ../../../nixos/components/display-manager/profiles/lightdm
        ../../../nixos/components/desktop-environment/profiles/xfce
    ];

    services.xserver = {
        displayManager = {
            defaultSession = "xfce";
            autoLogin.user = config.ethorbit.users.primary.username;
        };
    };
}
