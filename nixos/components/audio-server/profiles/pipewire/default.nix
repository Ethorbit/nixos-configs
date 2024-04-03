{ config, lib, ... }:

{
    imports = [
        ./home-manager.nix
        ./packages.nix
    ];

    services.pipewire = {
        enable = true;
        pulse.enable = true;
    };

    # This is required to be off or build error.
    hardware.pulseaudio.enable = lib.mkForce false;
}
