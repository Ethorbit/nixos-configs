# Cinnamon desktop will be used simply because it fits better
# when you simultaneously use Moonlight client for Windows as well

{ config, ... }:

{
    imports = [
        ../../../../nixos/components/display-server/profiles/xserver
        ../../../../nixos/components/audio-server/profiles/pipewire
        ../../../../nixos/components/display-manager/profiles/lightdm
        ../../../../nixos/components/desktop-environment/profiles/cinnamon
    ];

    services.xserver.displayManager.defaultSession = "cinnamon";
    services.xserver.displayManager.autoLogin.user = config.ethorbit.users.primary.username;
}
