{ lib, homeModules, ... }:

{
    imports = [
        ./packages.nix
    ];

    home-manager.sharedModules = [ homeModules.pulseeffects ];

    hardware.pulseaudio = {
        enable = true;
        extraConfig = "unload-module module-suspend-on-idle";
    };

    # Using PipeWire as the sound server conflicts with PulseAudio. This option requires `hardware.pulseaudio.enable` to be set to false
    # WTF NixOS devs... started occurring after 24.11, never had this error prior
    # https://discourse.nixos.org/t/how-can-i-disable-pipewire/58274 fixed it for me.
    services.pipewire.enable = lib.mkForce false;

    services.ananicy.extraRules = [
        {
            name = "pulseeffects";
            type = "Player-Audio";
        }
        {
            name = ".pulseeffects-wrapped";
            type = "Player-Audio";
        }
    ];
}
