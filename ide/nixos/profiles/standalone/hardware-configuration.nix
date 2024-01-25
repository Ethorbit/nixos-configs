{ config, lib, pkgs, modulesPath, ... }:

{
    imports = [ (modulesPath + "/profiles/qemu-guest.nix") ];

    boot.initrd.availableKernelModules = [ "ahci" "xhci_pci" "virtio_pci" "sr_mod" "virtio_blk" ];
    boot.initrd.kernelModules = [ ];
    boot.kernelModules = [ "kvm-amd" ];
    boot.extraModulePackages = [ ];

    fileSystems."/tmp" = { 
        device = "tmpfs";
        fsType = "tmpfs";
    };

    fileSystems."/" = { 
        device = "/dev/disk/by-uuid/c3905c8a-95a3-46cd-bd67-f4e54c7b73d8";
        fsType = "ext4";
    };

    fileSystems."/boot" = { 
        device = "/dev/disk/by-uuid/E676-59A3";
        fsType = "vfat";
        options = [ "fmask=0077" "dmask=0077" "defaults" ];
    };
    
    age.secrets."homenas/samba/users/nzc/creds" = { file = ../../../../homenas/nixos/secrets/samba/users/nzc/creds.age; };
    environment.etc."nascreds" = {
        mode = "0600";
        source = config.age.secrets."homenas/samba/users/nzc/creds".path;
    };
    fileSystems."/mnt/homenas" = {
        fsType = "cifs";
        device = "//${config.ethorbit.network.homenas.ip}/nzc";
        options = [ "credentials=/etc/nascreds" "uid=1000" "file_mode=0660" "dir_mode=0770" "forceuid" "forcegid" ];
    };

    swapDevices = [ ];

    # Enables DHCP on each ethernet and wireless interface. In case of scripted networking  
    # (the default) this is the recommended approach. When using systemd-networkd it's
    # still possible to use this option, but it's recommended to use it in conjunction
    # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
    networking.useDHCP = lib.mkDefault true;
    # networking.interfaces.enp1s0.useDHCP = lib.mkDefault true;

    nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";

    # This value determines the NixOS release from which the default
    # settings for stateful data, like file locations and database versions
    # on your system were taken. It's perfectly fine and recommended to leave
    # this value at the release version of the first install of this system.
    # Before changing this value read the documentation for this option
    # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
    system.stateVersion = "23.11";
}
