{ config, lib, ... }:

{
    boot.initrd.availableKernelModules = [ "sd_mod" "sr_mod" ];
    boot.initrd.kernelModules = [ "dm-snapshot" "dm_thin_pool" ];
    boot.kernelModules = [ ];
    boot.extraModulePackages = [ ];
    hardware.bluetooth.enable = true;
    hardware.steam-hardware.enable = true;

    imports = [
        ../nixos/hardware/vm/virtio
    ];

    fileSystems."/proc" = {
        device = "proc";
        fsType = "proc";
        options = [ "defaults" "nosuid" "nodev" "noexec" "hidepid=2" ];
    };

    fileSystems."/tmp" = {
        device = "tmpfs";
        fsType = "tmpfs";
        options = [ "defaults" "nosuid" "nodev" ]; #"noexec" ]; # noexec causes nvidia-vaapi-driver build to fail :shrug:
    };

    fileSystems."/" = { 
        device = "/dev/disk/by-uuid/f1deb13f-1332-4a88-8137-df2ad2e4a9dd";
        fsType = "ext4";
    };

    fileSystems."/boot" = {
        device = "/dev/disk/by-uuid/97D4-06D2";
        fsType = "vfat";
        options = [ "fmask=0077" "dmask=0077" "defaults" ];
    };

    swapDevices = [{
        device = "/swapfile";
        size = 16 * 1024;
    }];

    age.secrets."homenas/samba/users/ai/creds" = { file = ../homenas/secrets/samba/users/ai/creds.age; };
    environment.etc."nascreds_ai" = {
        mode = "0600";
        source = config.age.secrets."homenas/samba/users/ai/creds".path;
    };
    fileSystems."/mnt/homenas" = {
        fsType = "cifs";
        device = "//${config.ethorbit.network.homenas.ip}/ai";
        options = [ "credentials=/etc/nascreds_ai" "uid=1000" "gid=1000" "file_mode=0660" "dir_mode=0770" "forceuid" "forcegid" "_netdev" "x-systemd.automount" ];
    };

    # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
    # (the default) this is the recommended approach. When using systemd-networkd it's
    # still possible to use this option, but it's recommended to use it in conjunction
    # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
    networking.useDHCP = lib.mkDefault true;
    # networking.interfaces.eth0.useDHCP = lib.mkDefault true;

    # This value determines the NixOS release from which the default
    # settings for stateful data, like file locations and database versions
    # on your system were taken. It's perfectly fine and recommended to leave
    # this value at the release version of the first install of this system.
    # Before changing this value read the documentation for this option
    # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
    system.stateVersion = "25.05";
}
