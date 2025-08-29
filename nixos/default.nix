{ lib, ... }:

with lib;

{
    imports = [
        ./nixpkgs
        ./options.nix
        ./bootloader.nix
        ./packages.nix
        ./flatpak.nix
        ./programs
        ./users.nix
        ./timezone.nix
        ./locale.nix
        ./home-manager
        ./services
        ./udev-rules.nix
        ./networking.nix
        ./sudo.nix
    ];

    # Since I build on the systems I use, I'm setting
    # RESOURCE LIMITS so that builds don't FREEZE
    # SYSTEMS!
    #
    # This config should allow desktop usage during large builds :D

    nix = {
        daemonCPUSchedPolicy = mkDefault "idle";
        daemonIOSchedClass = mkDefault "idle";

        settings = {
            auto-optimise-store = mkDefault true;

            # Fixes 'warning: download buffer is full'
            # https://github.com/NixOS/nix/issues/11728
            download-buffer-size = 524288000;
        };

        gc = {
            automatic = mkDefault true;
            dates = mkDefault "weekly";
        };

        extraOptions = ''
            experimental-features = nix-command flakes
        '';
    };

    # TY https://nix.dev/tutorials/nixos/distributed-builds-setup.html
    systemd.services.nix-daemon.serviceConfig = {
        MemoryAccounting = mkDefault true;
        MemoryMax = mkDefault "90%";
        OOMScoreAdjust = mkDefault 500;
    };
}
