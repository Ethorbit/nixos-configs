{ config, lib, pkgs, modulesPath, ... }:

{
  boot.initrd.availableKernelModules = [ "sd_mod" "sr_mod" ];
  boot.initrd.kernelModules = [ "dm-snapshot" ];
  boot.kernelModules = [ ];
  boot.extraModulePackages = [ ];

  imports = [
    ../../nixos/hardware/vm/hyperv
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
    device = "/dev/disk/by-uuid/ce8fe699-02c4-40c1-9a88-a30ff21592ae";
    fsType = "ext4";
  };

  #fileSystems."/mnt/storage" = {
  #  device = "/dev/disk/by-uuid/c7059d02-312a-45c1-a937-9030b875a3c5";
  #  fsType = "ext4";
  #};

  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/8031-C5C0";
    fsType = "vfat";
    options = [ "fmask=0077" "dmask=0077" "defaults" ];
  };

  swapDevices = [ 
    { device = "/dev/disk/by-uuid/7daf30c5-f342-4943-9d17-2869f8e13b99"; }
  ];

  age.secrets."homenas/samba/users/ethorbit/creds" = { file = ../../homenas/nixos/secrets/samba/users/ethorbit/creds.age; };
  environment.etc."nascreds" = {
    mode = "0600";
    source = config.age.secrets."homenas/samba/users/ethorbit/creds".path;
  };
  fileSystems."/mnt/homenas" = {
    fsType = "cifs";
    device = "//${config.ethorbit.network.homenas.ip}/ethorbit";
    options = [ "credentials=/etc/nascreds" "uid=1000" "file_mode=0660" "dir_mode=0770" "forceuid" "forcegid" "x-systemd.automount" ];
  };

  # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
  # (the default) this is the recommended approach. When using systemd-networkd it's
  # still possible to use this option, but it's recommended to use it in conjunction
  # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
  networking.useDHCP = lib.mkDefault true;
  # networking.interfaces.eth0.useDHCP = lib.mkDefault true;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  
  
   # This value determines the NixOS release from which the default
   # settings for stateful data, like file locations and database versions
   # on your system were taken. It's perfectly fine and recommended to leave
   # this value at the release version of the first install of this system.
   # Before changing this value read the documentation for this option
   # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
   system.stateVersion = "23.11";
}
