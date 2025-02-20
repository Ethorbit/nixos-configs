{ config, ... }:

{
    imports = [
        ../../.
        ./wrappers.nix
    ];

    programs.chromium = {
        # Honestly Chromium was fine without all this extra crap.
        # If you want stuff like Tor, use Tor..
        extraOpts = {
            "BraveRewardsDisabled" = true;
            "BraveWalletDisabled" = true;
            "BraveVPNDisabled" = true;
            "BraveAIChatEnabled" = false;
            "TorDisabled" = true;
        };
    };
}
