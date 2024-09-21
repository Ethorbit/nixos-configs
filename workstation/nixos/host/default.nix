{ config, ... }:

{
    imports = [
        ./hardware-configuration.nix
        ./bootloader.nix
        ./audio.nix
        ./packages
        ./users.nix
        ./services
        ./networking
        ./desktop.nix
        ./home-manager.nix
        ../../../nixos/components/web-browsing/chromium
        ../../../nixos/components/containers/docker
        ../../../nixos/components/display-nesting/profiles/xephyr
        ../../../nixos/components/programming/ide
        ../../../nixos/components/file-browser/profiles/nautilus
    ];

    networking.hostName = "workstation";
    programs.virt-manager.enable = true;
    virtualisation.libvirtd.enable = true;

    # We need to optimize the slices to reduce lag
    # during resource contention
    systemd.slices = {
        # Host
        "user".sliceConfig = {
            IOAccounting = true;
            BlockIOAccounting = true;
            CPUAccounting = true;
            CPUWeight = 100;
            IOWeight = 100;
            BlockIOWeight = 100;
        };

        "system".sliceConfig = {
            IOAccounting = true;
            BlockIOAccounting = true;
            CPUAccounting = true;
            CPUWeight = 100;
            IOWeight = 100;
            BlockIOWeight = 100;
        };

        # Containers, leave some resources for host
        "machine".sliceConfig = {
            IOAccounting = true;
            CPUAccounting = true;
            BlockIOAccounting = true;
            CPUWeight = 60;
            StartupCPUWeight = 60;
            IOWeight = 80;
            BlockIOWeight = 80;
            MemoryMax = "90%";
        };

        "container" = {
            sliceConfig = config.systemd.slices."machine".sliceConfig;
        };
    };

    ethorbit.termdown-wrapper.soundPath = "/home/${config.ethorbit.users.primary.username}/Documents/timer.opus";
}
