{
    imports = [
        ../../default.nix
        ./packages.nix
        ./hardware-configuration.nix
        ./bootloader.nix
        ./users.nix
        ../../../display-server/profiles/xserver
        ../../../display-manager/profiles/lightdm
        ../../../window-manager/profiles/i3
    ];
}
