{ config, lib, pkgs, modulesPath, ... }:

{
  boot.initrd.luks.devices."crypt_root" = {
      device = "/dev/disk/by-uuid/418ac3dd-152d-4c9b-9458-053e1527fc41";
      preLVM = true;
      allowDiscards = true;
  };
  boot.initrd.availableKernelModules = [ "sd_mod" "sr_mod" ];
  boot.initrd.kernelModules = [ "dm-snapshot" "dm_thin_pool" ];
  boot.kernelModules = [ ];
  boot.extraModulePackages = [ ];
  hardware.bluetooth.enable = true;
  hardware.enableAllFirmware = true;

  fileSystems."/proc" = {
    device = "proc";
    fsType = "proc";
    options = [ "defaults" "nosuid" "nodev" "noexec" "hidepid=2" ];
  };

  fileSystems."/tmp" = {
    device = "tmpfs";
    fsType = "tmpfs";
    options = [ "defaults" "nosuid" "nodev" ];
  };

  fileSystems."/" = {
    device = "/dev/mapper/crypt_root";
    fsType = "ext4";
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/b85ec453-91d6-49e5-bc35-75c86917b74a";
    fsType = "ext4";
  };

  swapDevices = [{
    device = "/swapfile";
    size = 6 * 1024;
  }];

  age.secrets."homenas/samba/users/ethorbit/creds" = { file = ../../homenas/nixos/secrets/samba/users/ethorbit/creds.age; };
  environment.etc."nascreds" = {
    mode = "0600";
    source = config.age.secrets."homenas/samba/users/ethorbit/creds".path;
  };
  fileSystems."/mnt/homenas" = {
    fsType = "cifs";
    device = "//${config.ethorbit.network.homenas.ip}/ethorbit";
    options = [ "credentials=/etc/nascreds" "uid=1000" "gid=1000" "file_mode=0660" "dir_mode=0770" "forceuid" "forcegid" "x-systemd.automount" ];
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
   system.stateVersion = "24.11";
}
