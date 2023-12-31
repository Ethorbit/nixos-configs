{
    boot.loader.grub.enable = true;
    boot.loader.efi.canTouchEfiVariables = true;
    # Change this to the boot device(s) specified in hardware-configuration.nix
    boot.loader.grub.devices = [ "/dev/disk/by-uuid/261F-3B88" ];
}
