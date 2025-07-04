{ lib, ... }:

{
    imports = [
        ./networking.nix
        ./packages.nix
        ./desktop.nix
        ./users.nix
    ];

    networking.hostName = "builder";

    hardware.pulseaudio.enable = true;
    services.pipewire.enable = lib.mkForce false;

    services.openssh.enable = true;

    system.stateVersion = "24.11";
}
