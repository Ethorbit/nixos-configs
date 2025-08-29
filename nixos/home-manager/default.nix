{ homeModules, ... }:

{
    imports = [
        ./flatpak
    ];

    home-manager = {
        useGlobalPkgs = true;
        backupFileExtension = ".bak";

        sharedModules = 
        with homeModules; [
            default
            shell
            htop
            xdg
        ] ++ [ {
            # https://discourse.nixos.org/t/brave-browser-and-kde-wallet-on-25-05/64915
            # NixOS 25.05 seems to have polluted my systems with kwallet
            # and kwallet is delaying browser launch by ~60 secs
            #
            # Until I can find out the root cause:
            home.file.".config/kwalletrc".text = ''
                [Wallet]
                Enabled=false
            '';
        } ];
    };
}
