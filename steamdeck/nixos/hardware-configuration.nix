# Basically full-disk encryption would be super inconvenient with a Steam Deck, so I use a script
# located in (packages/scripts/decrypt) to conveniently unlock and mount encrypted partitions (/home and sdcard)

{ config, lib, pkgs, modulesPath, ... }:

{
  boot.initrd.availableKernelModules = [ "sd_mod" "sr_mod" ];
  boot.initrd.kernelModules = [];
  boot.kernelModules = [
    # WiFi
    "rtw88_8822ce"
    "rtw88_8822c"
    "rtw88_pci"
    "rtw88_core"
    "mac80211"
    "cfg80211"
    # Bluetooth
    "btrtl"
    "btintel"
    "btbcm"
    "btmtk"
    "btusb"
    "bluetooth"
  ];
  boot.extraModulePackages = [ ];
  hardware.bluetooth.enable = true;
  hardware.steam-hardware.enable = true;
  hardware.enableAllFirmware = true;
 
  fileSystems."/proc" = {
    device = "proc";
    fsType = "proc";
    options = [ "defaults" "nosuid" "nodev" "noexec" "hidepid=2" ];
  };

  fileSystems."/tmp" = {
    device = "tmpfs";
    fsType = "tmpfs";
    options = [ "defaults" "nosuid" "nodev" "noexec" ];
  };

  fileSystems."/" = { 
    device = "/dev/disk/by-uuid/305f8f54-3406-4fe5-a50e-5046b4f6af23";
    fsType = "btrfs";
    options = [ "defaults" "compress-force=zstd:16" "noatime" "discard" ];
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/0678-FDF8";
    fsType = "vfat";
    options = [ "fmask=0077" "dmask=0077" "defaults" ];
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
