{ config, ... }:

{
    imports = [
        ../..
        ./home-manager.nix
        ./packages.nix
        ./services.nix
    ];

    # "Enabling realtime may improve latency and reduce stuttering, specially in high load scenarios." - https://nixos.wiki/wiki/Sway
    security.pam.loginLimits = [
        { domain = "@users"; item = "rtprio"; type = "-"; value = 1; }
    ];
}
