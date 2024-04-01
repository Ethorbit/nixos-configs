{ config, lib, pkgs, modulesPath, ... }:

{
  imports = [ ];
  
  boot.kernelPackages.nvidiaPackages.production;
  boot.initrd.availableKernelModules = [ "sd_mod" "sr_mod" ];
  boot.initrd.kernelModules = [ "dm-snapshot" ];
  boot.kernelModules = [ ];
  boot.extraModulePackages = [ ];

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
	device = "/dev/disk/by-uuid/91bb9ad6-02a9-4953-ac5d-2e1e9d20b9ac";
    fsType = "ext4";
  };

  fileSystems."/boot/EFI" = {
	device = "/dev/disk/by-uuid/4EA7-3BCA";
	fsType = "vfat";
  };

  swapDevices = [ 
	{ device = "/dev/disk/by-uuid/41efd1d9-af1c-4078-b45b-d51a4534db94"; }
  ];

  age.secrets."homenas/samba/users/ethorbit/creds" = { file = ../../homenas/nixos/secrets/samba/users/ethorbit/creds.age; };
  environment.etc."nascreds" = {
	mode = "0600";
	source = config.age.secrets."homenas/samba/users/ethorbit/creds".path;
  };
  fileSystems."/mnt/homenas" = {
    fsType = "cifs";
	device = "//${config.ethorbit.network.homenas.ip}/nzc";
	options = [ "credentials=/etc/nascreds" "uid=1000" "file_mode=0660" "dir_mode=0770" "forceuid" "forcegid" ];
  };

  # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
  # (the default) this is the recommended approach. When using systemd-networkd it's
  # still possible to use this option, but it's recommended to use it in conjunction
  # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
  networking.useDHCP = lib.mkDefault true;
  # networking.interfaces.eth0.useDHCP = lib.mkDefault true;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  virtualisation.hypervGuest.enable = true;
  
  
   # This value determines the NixOS release from which the default
   # settings for stateful data, like file locations and database versions
   # on your system were taken. It's perfectly fine and recommended to leave
   # this value at the release version of the first install of this system.
   # Before changing this value read the documentation for this option
   # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
   system.stateVersion = "23.11";
}
