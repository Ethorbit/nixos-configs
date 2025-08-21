{ config, lib, pkgs, modulesPath, ... }:

{
    imports = [ 
        (modulesPath + "/profiles/qemu-guest.nix")
    ];

    boot.initrd.availableKernelModules = [ "ahci" "xhci_pci" "virtio_pci" "sr_mod" "virtio_blk" ];
    boot.initrd.kernelModules = [ ];
    boot.kernelModules = [ "kvm-amd" "dm-snapshot" "dm_thin_pool" ];
    boot.extraModulePackages = [ ];

    fileSystems."/" = { 
        device = "/dev/disk/by-uuid/5b4fadad-2000-48d6-8509-420ebab8e57b";
        fsType = "ext4";
    };

    fileSystems."/boot" = { 
        device = "/dev/disk/by-uuid/7A71-1EF6";
        fsType = "vfat";
        options = [ "fmask=0077" "dmask=0077" "defaults" ];
    };

    swapDevices = [ 
        { device = "/dev/disk/by-uuid/f9be5093-fc06-45f6-9a0b-0368edeb0020"; }
    ];

    # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
    # (the default) this is the recommended approach. When using systemd-networkd it's
    # still possible to use this option, but it's recommended to use it in conjunction
    # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
    networking.useDHCP = lib.mkDefault true;
    # networking.interfaces.enp1s0.useDHCP = lib.mkDefault true;

    # This value determines the NixOS release from which the default
    # settings for stateful data, like file locations and database versions
    # on your system were taken. It's perfectly fine and recommended to leave
    # this value at the release version of the first install of this system.
    # Before changing this value read the documentation for this option
    # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
    system.stateVersion = "24.11";
}
