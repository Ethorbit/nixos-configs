{ config, ... }:

{
    imports = [
        ./home-manager.nix
        ./packages.nix
    ];

    services.pipewire = {
        enable = true;
        pulse.enable = true;
    };
}
