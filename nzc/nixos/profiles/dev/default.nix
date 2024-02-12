{ config, ... }:

{
    imports = [
        ../..
        ./hardware.nix
        ./packages.nix
        ./services.nix
        ../../../../nixos/components/ide
        ../../../../nixos/components/display-server/profiles/xserver
        ../../../../nixos/components/display-manager/profiles/lightdm
        ../../../../nixos/components/audio-server/profiles/pipewire
        ../../../../nixos/components/window-manager/profiles/i3
    ];
}
