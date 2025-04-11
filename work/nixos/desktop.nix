{ config, pkgs, ... }:

{
    imports = [
        ../../nixos/components/display-server/profiles/xserver
        ../../nixos/components/display-manager/profiles/lightdm
        ../../nixos/components/desktop-environment/profiles/xfce
    ];

    services.displayManager = {
        defaultSession = "xfce";
        autoLogin.user = config.ethorbit.users.primary.username;
    };
}
