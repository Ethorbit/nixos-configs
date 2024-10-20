{ config, lib, pkgs, modulesPath, ... }:

{
  boot.initrd.availableKernelModules = [ "sd_mod" "sr_mod" ];
  boot.initrd.kernelModules = [ "dm-snapshot" ];
  boot.kernelModules = [ ];
  boot.extraModulePackages = [ ];

  imports = [
    ../../nixos/hardware/vm/virtio
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
    device = "/dev/disk/by-uuid/fe2f5fa2-263c-40dc-8770-c5106a85a7bf";
    fsType = "ext4";
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/5336-B9AC";
    fsType = "vfat";
    options = [ "fmask=0077" "dmask=0077" "defaults" ];
  };

  fileSystems."/mnt/storage" = {
    device = "/dev/disk/by-uuid/c7059d02-312a-45c1-a937-9030b875a3c5";
    fsType = "ext4";
  };

  swapDevices = [ 
    { device = "/dev/disk/by-uuid/d157b62c-a80f-4164-8eb7-b05eb8b3a0d2"; }
  ];

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
   system.stateVersion = "23.11";
}
