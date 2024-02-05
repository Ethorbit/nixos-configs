{
    imports = [
        ../..
        ./home-manager.nix
        ./packages.nix
        ./hardware-configuration.nix
        ./bootloader.nix
        ./users.nix
        ../../../display-server/profiles/xserver
        ../../../display-manager/profiles/lightdm
        ../../../audio-server/profiles/pipewire
        ../../../window-manager/profiles/i3
    ];
}
