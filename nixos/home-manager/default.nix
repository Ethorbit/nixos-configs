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
            espanso
        ] ++ [ {
            # https://discourse.nixos.org/t/brave-browser-and-kde-wallet-on-25-05/64915
            # Starting on NixOS 25.05, many KDE packages will put kwallet into your system path
            #
            # Since I never needed kwallet and because it's causing slowness problems,
            # I'm disabling it for all systems by default.
            home.file.".config/kwalletrc".text = ''
                [Wallet]
                Enabled=false
            '';
        } ];
    };
}
