{ config, ... }:

{
    imports = [
        ./packages.nix
        ./home-manager
        ./services.nix
    ];

    # Hide mouse cursor when typing.
    services.xbanish.enable = config.services.xserver.enable;

    xdg.terminal-exec = {
        enable = true;
        settings = {
            default = [ "kitty.desktop" ];
        };
    };
}
