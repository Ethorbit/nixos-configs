{ config, lib, ... }:

{
    boot.loader.grub = {
        enable = true;
        efiSupport = false;
        device = "/dev/sda";
    };
}
