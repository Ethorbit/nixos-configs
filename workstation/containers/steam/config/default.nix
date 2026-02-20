{ ... }:

{
    imports = [
        ../../../graphics.nix
        ../../../../nixos/components/gaming/steam/profiles/native
        ../../../../nixos/components/display-server/profiles/xserver
        ../../../../nixos/components/audio-server/profiles/pulseaudio
        ../../../../nixos/components/recording/obs/profiles/native
        # Since passing XDG grants privileges over host, we need
        # our own toolset for accessing and viewing our files
        ../../../../nixos/components/window-manager
        ../../../../nixos/components/programming/ide
        ../../../../nixos/components/file-browser/profiles/nautilus
        ./users.nix
        ./networking
        ./audio.nix
        ./packages.nix
        ./environment-variables.nix
        ./home-manager.nix
    ];
}
