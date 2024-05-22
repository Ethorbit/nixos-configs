{ config, ... }:

{
    imports = [
        ./hardware-configuration.nix
        ./bootloader.nix
        ./packages
        ./users.nix
        ./audio.nix
        ./services
        ./networking
        ./desktop.nix
        ./home-manager.nix
        ../../../nixos/components/containers/docker
        ../../../nixos/components/display-nesting/profiles/xephyr
        ../../../nixos/components/programming/ide
        ../../../nixos/components/file-chooser/profiles/nautilus
    ];

    networking.hostName = "workstation";

    # "Enabling realtime may improve latency and reduce stuttering, specially in high load scenarios." - https://nixos.wiki/wiki/Sway
    security.pam.loginLimits = [
        { domain = "@users"; item = "rtprio"; type = "-"; value = 1; }
    ];

    ethorbit.termdown-wrapper.soundPath = "/home/${config.ethorbit.users.primary.username}/Documents/timer.opus";
}
