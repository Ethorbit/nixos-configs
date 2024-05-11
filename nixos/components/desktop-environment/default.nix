{ config, ... }:

{
    imports = [
        ./home-manager.nix
    ];

    # Hide mouse cursor when typing.
    services.xbanish.enable = config.services.xserver.enable;
}
