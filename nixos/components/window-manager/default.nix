{ config, ... }:

{
    imports = [
        ./packages.nix
        ./home-manager
        ./services.nix
    ];

    # Hide mouse cursor when typing.
    services.xbanish.enable = config.services.xserver.enable;
}
