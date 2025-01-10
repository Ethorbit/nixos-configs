{ config, ... }:

{
    imports = [
        ./vlc.nix
        ../../../nixos/components/gaming/steam/profiles/flatpak
        ../../../nixos/components/gaming/lutris/profiles/flatpak
        ../../../nixos/components/gaming/minecraft/profiles/flatpak
    ];

    services.flatpak = {
        enable = true;
        packages = [
            {
                appId = "org.deluge_torrent.deluge";
                origin = "flathub";
            }

            # Because the Spotify devs are too incapable of fixing their website
            #
            # I have literally been receiving a "Spotify can't play this" error
            # on Linux Firefox & Chrome for YEARS now, they are actually not able
            # to figure it out. SPOTIFY: HIRE ME! I will OUTPERFORM ALL your devs!
            # I will have this bug fixed ASAP! I will not sit on this for years.
            {
                appId = "com.spotify.Client";
                origin = "flathub";
            }

            # Useful for accessing Windows VM(s?) or remote systems
            # maybe even GPU passthrough --> Windows --> GPU-PV --> multiple Windows guests w/ Sunshine
            {
                appId = "com.moonlight_stream.Moonlight";
                origin = "flathub";
            }
        ];
    };
}
