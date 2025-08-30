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

    #
    # Below are some settings to prevent lag / stutter during
    # rebuilds.
    #

    nix = {
        # I use a Proxmox virtual machine as a "Build Node"
        # because Proxmox's resource schedulers balances
        # the resource load between VMs WAY BETTER than
        # a standalone Linux kernel could ever handle
        # load between its user processes and the Nix daemon
        #
        # This is the only option for top performance (I promise):
        distributedBuilds = mkDefault true;
        buildMachines = mkDefault [ {
            hostName = mkDefault "nixos.internal";
            sshUser = mkDefault "builder";
            system = mkDefault "x86_64-linux";
            publicHostKey = mkDefault "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDsJralwCIT8MB1cSxzmXTzIfVks6YyVZSF4lr/54S3X root@workstation";
        } ];

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
