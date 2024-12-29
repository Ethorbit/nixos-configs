{ config, ... }:

{
    imports = [
        ../..
        ./hardware.nix
        ./packages.nix
        ./services.nix
        ./home-manager.nix
        ./networking.nix
        ../../../../nixos/components/programming/ide
        ../../../../nixos/components/display-server/profiles/xserver
        ../../../../nixos/components/display-manager/profiles/lightdm
        ../../../../nixos/components/audio-server/profiles/pipewire
        ../../../../nixos/components/window-manager/profiles/i3
        ../../../../nixos/components/gaming/steam/profiles/native
    ];

    ethorbit.system.profile.name = "dev";
}
